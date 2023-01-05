from operator import truediv
from flask import render_template, flash, redirect, url_for
from app import app
from app import db
from app.main.forms import RegistrationForm, TeacherRegistrationForm, LoginForm, CustomizeForm, OrderForm, FavoriteDrinksForm, BaristaForm, A_AddUserForm, A_DeleteUserForm, A_AddDrinkForm, A_DeleteDrinkForm, A_AddFlavorForm, A_DeleteFlavorForm, A_UserDashboardForm, A_ModifyDrinkForm, ResetPasswordRequestForm, ResetPasswordForm
from flask_login import current_user
from flask_login import login_user
from app import models
from app.models import User, Flavor, MenuItem, Drink, Order, Temp, RoomNum, DrinksToFlavor, FavoriteDrink, HalfCaf
from flask_login import logout_user, login_required
from flask import request
from werkzeug.urls import url_parse
from app.main import bp
from app import login
from app.main.email import send_password_reset_email
import datetime ##hello
from app.main.email import order_email, reg_email

@login.user_loader
def load_user(id):
        return User.query.get(int(id))

@bp.route('/', methods=['GET', 'POST'])
@bp.route('/home', methods=['GET', 'POST'])
def home():
        if current_user.is_authenticated:
                if current_user.user_type == 'Barista':
                        return redirect(url_for('main.barista'))
                elif current_user.user_type == 'Admin':
                        return redirect(url_for('main.a_addUser'))

        menuItems = MenuItem.query.all()

        return render_template('home.html', title='Home Page', menuItems=menuItems)


@bp.route('/login', methods=['GET', 'POST'])
def login():

    if current_user.is_authenticated:
        return redirect(url_for('main.home'))

    form = LoginForm()
    if request.method == 'POST':
        user = User.query.filter_by(username=form.username.data).first()
        if user is None or not user.check_password(form.password.data):
            flash('Invalid username or password')
            return redirect(url_for('main.login'))
        elif not user.isActivated:
            flash('This account has not been activated yet.')
            return redirect(url_for('main.login'))

        login_user(user, remember=form.remember_me.data)

        next_page = request.args.get('next')
        if not next_page or url_parse(next_page).netloc != '' :
            next_page = url_for('main.home')

        if current_user.user_type == 'Teacher':
                return redirect(next_page)
        elif current_user.user_type == 'Barista':
                return redirect(url_for('main.barista'))
        else:
                return redirect(url_for('main.a_addUser'))
    return render_template('login.html', title='Sign In', form=form)

@bp.route('/logout')
def logout():
        logout_user()
        return redirect(url_for('main.login'))

@bp.route('/email')
def email():
        return redirect(url_for('main.login'))
        # http://localhost:5000/email  #Leads to internal server error but send email
        # send_email('[Microblog] Reset Your Password', sender=app.config['ADMINS'][0], recipients=app.config['ADMINS'], text_body='hi')

@bp.route('/supersecretpage', methods=['GET', 'POST'])
def register():
        if current_user.is_authenticated:
                return redirect(url_for('main.home'))
        form = RegistrationForm()
        if form.validate_on_submit():
                user = User(username=form.username.data, user_type=form.user_type.data, current_order_id=None, isActivated=True, email=form.email.data)
                user.set_password(form.password.data)
                db.session.add(user)
                
                db.session.commit()
                user = User.query.filter_by(username=form.username.data).first()

                first_order = Order(teacher_id=user.id, complete=False)
                db.session.add(first_order)
                db.session.commit()
                user.current_order_id = Order.query.all()[-1].id
                db.session.commit()

                return redirect(url_for('main.login'))
        return render_template('register.html', title='Super Secret Register', form=form)

@bp.route('/register', methods=['GET', 'POST'])
def teacherRegister():
        if current_user.is_authenticated:
                return redirect(url_for('main.home'))
        form = TeacherRegistrationForm()
        if form.validate_on_submit():
                user = User(username=form.username.data, user_type=form.user_type.data, current_order_id=None, isActivated=False, email=form.email.data)
                user.set_password(form.password.data)
                db.session.add(user)
                reg_email(user)
                db.session.commit()
                user = User.query.filter_by(username=form.username.data).first()

                first_order = Order(teacher_id=user.id, complete=False)
                db.session.add(first_order)
                db.session.commit()
                user.current_order_id = Order.query.all()[-1].id
                db.session.commit()

                return redirect(url_for('main.login'))
        return render_template('teachreg.html', title='Register', form=form)

@bp.route('/menu')
def menu():
        if current_user.is_authenticated:
                if current_user.user_type == "Barista":
                        return redirect(url_for('main.barista'))
                elif current_user.user_type == "Admin":
                        return redirect(url_for('main.a_addUser'))

        menuItems = MenuItem.query.all()
        return render_template('menu.html', title='Menu', menuItems=menuItems)

@bp.route('/customizeDrink/<drinkId>', methods=['GET', 'POST'])
def custDrink(drinkId):
        if current_user.is_anonymous:
                return redirect(url_for('main.login'))
        elif current_user.user_type == "Barista":
                return redirect(url_for('main.barista'))
        elif current_user.user_type == "Admin":
                return redirect(url_for('main.a_addUser'))

        form = CustomizeForm(drinkId)
        m = MenuItem.query.get(drinkId)
        if request.method == 'POST':

                d = Drink(menuItem=m.name,
                          temp_id=form.temp.data,
                          decaf=form.decaf.data,
                          flavors=form.flavors.data,
                          order_id=current_user.current_order_id,
                          inst=form.inst.data)
                db.session.add(d)
                db.session.commit()

                o = Order.query.get(current_user.current_order_id)

                if form.fav.data:
                        f = FavoriteDrink(userId=current_user.id, drinkId=d.id, menuId=m.id, tempId=form.temp.data, decaf=form.decaf.data, flavorId=form.flavors.data)
                        db.session.add(f)
                        db.session.commit()

                return redirect(url_for('main.myOrder', orderId=o.id))
        return render_template('customize.html', title='Customize Drink', form=form, m=m)

@bp.route('/myOrder/<orderId>', methods=['GET', 'POST'])
def myOrder(orderId):

        if current_user.is_anonymous:
                return redirect(url_for('main.login'))
        elif current_user.user_type == "Barista":
                return redirect(url_for('main.barista'))
        elif current_user.user_type == "Admin":
                return redirect(url_for('main.a_addUser'))
        
        order = Order.query.get(orderId)
        halfcaf = HalfCaf.query.get(1)
        form = OrderForm()

        if request.method == 'POST' and order.drink != [] and halfcaf.acc_order==True:
                order.roomnum_id = form.room.data
                order.timestamp = datetime.datetime.now()
                order.read = datetime.datetime.now()
                db.session.commit()
                new_order = Order(teacher_id=current_user.id)
                db.session.add(new_order)
                db.session.commit()
                new_order_id = Order.query.all()[-1].id
                current_user.current_order_id=new_order_id
                db.session.commit()
                return redirect(url_for('main.myOrder', orderId=current_user.current_order_id))
        elif halfcaf.acc_order == False:
                flash("This is not a time for ordering drinks ")
                return redirect(url_for('main.home'))

        return render_template('myOrder.html', title='My Order', form=form, order=order)

        
@bp.route('/favoriteDrinks', methods=['GET','POST'])
def favoriteDrinks():
        if current_user.is_anonymous:
                return redirect(url_for('main.login'))
        elif current_user.user_type == "Barista":
                return redirect(url_for('main.barista'))
        elif current_user.user_type == "Admin":
                return redirect(url_for('main.a_addUser'))


        favDrinks = FavoriteDrink.query.filter_by(userId=current_user.id)
        favorite_drinks = []
        for i in favDrinks:
                favorite_drinks.append({'id' : i.drinkId}) #CHANGE NAME?

        favoriteDrinks = FavoriteDrinksForm(favDrinks)#, favorites=favorite_drinks)
        

        if request.method == 'POST':
                if favoriteDrinks.order.data: 
                        f = FavoriteDrink.query.get(favoriteDrinks.favs.data)
                        m = MenuItem.query.get(f.menuId)
                        d = Drink(menuItem=m.name,
                          temp_id=f.tempId,
                          decaf=f.decaf,
                          flavors=f.flavorId,
                          order_id=current_user.current_order_id)
                        db.session.add(d)
                        db.session.commit()
                        o = Order.query.get(current_user.current_order_id)
                        return redirect(url_for('main.myOrder', orderId=o.id))

                elif favoriteDrinks.delete.data:
                        f = FavoriteDrink.query.get(favoriteDrinks.favs.data)
                        db.session.delete(f)
                        db.session.commit()
                        return redirect(url_for('main.favoriteDrinks'))

                

        return render_template('favoriteDrinks.html', title='Favorite Drinks', favoriteDrinksForm=favoriteDrinks)

@bp.route('/barista', methods=['GET', 'POST'])
def barista():
        if current_user.is_anonymous or current_user.user_type != 'Barista':
                return redirect(url_for('main.login'))

        form = BaristaForm()
        store = HalfCaf.query.get(1)
        orders = Order.query.all()
        order_list = []
        order_reverse = []
        order = ()
        drink_list = []
        drink = ()
        new = False

        for o in orders:
                drink_list = []
                if o.roomnum_id != None:
                        if not o.complete:
                                teacher = User.query.get(o.teacher_id)
                                roomnum = RoomNum.query.get(o.roomnum_id)
                                for d in o.drink:
                                        temp = Temp.query.get(d.temp_id)
                                        drink = (d.menuItem, temp.temp, d.decaf, d.flavors, d.inst) #added the inst thing
                                        drink_list.append(drink)

                                order = (teacher.username, drink_list, roomnum.num, o.timestamp.strftime("%Y-%m-%d at %H:%M"), o.id, o.read)
                                order_list.append(order)
                                order_reverse.insert(0, order)
                                
                                if o.timestamp >= o.read:
                                        new = True
                                        o.read = datetime.datetime.now()
                                        db.session.commit()
                                else:
                                        new = False
                                
        print(order_list)
        if request.method == 'POST':
                completed_order_id = request.form.get("complete_order")
                completed_order = Order.query.get(completed_order_id)
                completed_order.complete = True
                
                emailDrinkList  = []
                for i in completed_order.drink:
                        emailDrinkList.append(i.menuItem)

                completed_teacher_id = completed_order.teacher_id
                completed_teacher = User.query.filter_by(id = completed_teacher_id).first()
               
                order_email(completed_teacher.username, emailDrinkList, 'order ready!!', sender=app.config['ADMINS'][0], recipients=[completed_teacher.email])
                
                db.session.commit()
                return redirect(url_for('main.barista'))


        return render_template('barista.html', title='Barista', order_list=order_list, form=form, new_order=new, order_reverse = order_reverse, order_time = store.acc_order)


@bp.route('/baristaCompleted', methods=['GET', 'POST'])
def baristaCompleted():
        if current_user.is_anonymous or current_user.user_type != 'Barista':
                return redirect(url_for('main.login'))

        form = BaristaForm()

        orders = Order.query.all()
        order_list = []
        order = ()
        drink_list = []
        drink = ()
        store = HalfCaf.query.get(1)

        order_list_complete = []

        for o in orders:
                drink_list = []
                if o.roomnum_id != None:
                        if o.complete:
                                teacher = User.query.get(o.teacher_id)
                                roomnum = RoomNum.query.get(o.roomnum_id)
                                for d in o.drink:
                                        temp = Temp.query.get(d.temp_id)
                                        drink = (d.menuItem, temp.temp, d.decaf, d.flavors)
                                        drink_list.append(drink)

                                order = (teacher.username, drink_list, roomnum.num, o.timestamp.strftime("%Y-%m-%d at %H:%M"), o.id)
                                order_list_complete.append(order)

        if request.method == 'POST':
                completed_order_id = request.form.get("mark_incomplete")
                completed_order = Order.query.get(completed_order_id)
                completed_order.complete = False
                db.session.commit()
                return redirect(url_for('main.baristaCompleted'))

        return render_template('baristaCompleted.html', title='Completed Orders', order_list_complete=order_list_complete, form=form, order_time = store.acc_order)

@bp.route('/addUser', methods=['GET', 'POST'])
def a_addUser():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        addUser = A_AddUserForm()

        if request.method == 'POST':
                user = User(username=addUser.username.data, user_type=addUser.user_type.data, email = addUser.user_email.data, isActivated=True)
                user.set_password(addUser.password.data)

                db.session.add(user)
                db.session.commit()
                user = User.query.filter_by(username=addUser.username.data).first()

                first_order = Order(teacher_id=user.id, complete=False)
                db.session.add(first_order)
                db.session.commit()
                user.current_order_id = Order.query.all()[-1].id
                db.session.commit()

                return redirect(url_for('main.a_addUser'))

        return render_template('a_addUser.html', title='Add User', addUserForm=addUser)

@bp.route('/deleteUser', methods=['GET', 'POST'])
def a_deleteUser():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        deleteUser = A_DeleteUserForm()

        if request.method == 'POST':
                user = User.query.get(deleteUser.user.data)

                user.current_order_id = None #added

                for o in Order.query.all():

                        if o.teacher_id == user.id:
                        
                                for d in o.drink:

                                        db.session.delete(d)
                                db.session.delete(o)

                db.session.delete(user)
                db.session.commit()

                return redirect(url_for('main.a_deleteUser'))

        return render_template('a_deleteUser.html', title='Delete User', deleteUserForm=deleteUser)

@bp.route('/addDrink', methods=['GET', 'POST'])
def a_addDrink():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        addDrink = A_AddDrinkForm()

        if request.method == 'POST':
                drink = MenuItem(name=addDrink.name.data,
                                 description=addDrink.desc.data,
                                 price=addDrink.price.data,
                                 popular=addDrink.popular.data)
                db.session.add(drink)
                db.session.commit()

                return redirect(url_for('main.a_addDrink'))

        return render_template('a_addDrink.html', title='Add Drink', addDrinkForm=addDrink)

@bp.route('/modifyDrink', methods=['GET', 'POST'])
def a_modifyDrink():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        modifyDrink = A_ModifyDrinkForm()

        if request.method == 'POST':
                drink1 = MenuItem.query.get(modifyDrink.drink.data)
                if modifyDrink.flavor.data and modifyDrink.drink.data:
                        for f in DrinksToFlavor.query.filter_by(drinkId = drink1.id):
                                db.session.delete(f)
                        for flavorId in modifyDrink.flavor.data:
                                f = Flavor.query.get(flavorId)

                                drinkFlavor = DrinksToFlavor(drink=drink1.name, flavor=f.name, drinkId = drink1.id, flavorId=f.id)
                                db.session.add(drinkFlavor)

                db.session.commit()
                return redirect(url_for('main.a_modifyDrink'))

        return render_template('a_modifyDrink.html', title='Modify Drink', modifyDrinkForm=modifyDrink)

@bp.route('/deleteDrink', methods=['GET', 'POST'])
def a_deleteDrink():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        deleteDrink = A_DeleteDrinkForm()

        if request.method == 'POST':
                drink = MenuItem.query.get(deleteDrink.drink.data)

                for o in Order.query.all():
                        if drink in o.drink:
                                db.session.delete(o)
                db.session.delete(drink)
                db.session.commit()

                return redirect(url_for('main.a_deleteDrink'))

        return render_template('a_deleteDrink.html', title='Delete Drink', deleteDrinkForm=deleteDrink)

@bp.route('/addFlavor', methods=['GET', 'POST'])
def a_addFlavor():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        addFlavor = A_AddFlavorForm()

        if request.method == 'POST':
                flavor = Flavor(name=addFlavor.name.data)
                db.session.add(flavor)
                db.session.commit()

                return redirect(url_for('main.a_addFlavor'))

        return render_template('a_addFlavor.html', title='Add Flavor', addFlavorForm=addFlavor)

@bp.route('/deleteFlavor', methods=['GET', 'POST'])
def a_deleteFlavor():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        deleteFlavor = A_DeleteFlavorForm()

        if request.method == 'POST':
                flavor = Flavor.query.get(deleteFlavor.flavor.data)

                orders = Order.query.all() # Added to define "orders". Might not be needed [addition]
                for o in orders:
                        for d in o.drink:
                                if d.flavors == flavor:
                                        db.session.delete(o)

                db.session.delete(flavor)
                db.session.commit()

                return redirect(url_for('main.a_deleteFlavor'))

        return render_template('a_deleteFlavor.html', title='Delete Flavor', deleteFlavorForm=deleteFlavor)

@bp.route('/userDashboard', methods=['GET','POST'])
def a_userDashboard():
        if current_user.is_anonymous or current_user.user_type != 'Admin':
                return redirect(url_for('main.login'))

        query = '1'
        if request.method == 'GET':
                query = request.args.get('v', '1')

        userDashboard = A_UserDashboardForm(query)

        if request.method == 'POST':
                if userDashboard.submitActivate.data:
                        msg = 'Successfully activated users: '
                        for userId in userDashboard.users.data:
                                u = User.query.get(userId)
                                u.isActivated = True
                                msg = msg + u.username + ' '
                        flash(msg)
                elif userDashboard.submitDeactivate.data:
                        msg = 'Successfully deactivated users: '
                        for userId in userDashboard.users.data:
                                u = User.query.get(userId)
                                u.isActivated = False
                                msg = msg + u.username + ' '
                        flash(msg)
                elif userDashboard.submitView.data:
                        return redirect(url_for('main.a_userDashboard', v=userDashboard.views.data))

                db.session.commit()
                return redirect(url_for('main.a_userDashboard'))




        return render_template('a_userDashboard.html', title='User Dashboard', userDashboardForm=userDashboard)


@app.route('/reset_password_request', methods=['GET', 'POST'])
def reset_password_request():
        if current_user.is_authenticated:
                return redirect(url_for('main.login'))  #main.index is what's on the tutorial
        form = ResetPasswordRequestForm()
        if form.validate_on_submit():
                user = User.query.filter_by(email=form.email.data).first()
                if user:
                        send_password_reset_email(user)
                flash('Check your email for the instructions to reset your password')
                return redirect(url_for('main.login'))
        return render_template('reset_password_request.html', title='Reset Password', form=form)

@app.route('/reset_password/<token>', methods=['GET', 'POST'])
def reset_password(token):
        if current_user.is_authenticated:
                return redirect(url_for('main.login'))
        user = User.verify_reset_password_token(token)
        if not user:
                return redirect(url_for('main.login'))
        form = ResetPasswordForm()
        if form.validate_on_submit():
                user.set_password(form.password.data)
                db.session.commit()
                flash('Your password has been reset.')
                return redirect(url_for('main.login'))
        return render_template('reset_password.html', form=form)




@bp.route('/disable', methods=['GET'])
def disable():
        if current_user.is_anonymous or current_user.user_type != 'Barista':
                return redirect(url_for('main.login'))
        store = HalfCaf.query.get(1)
        store.acc_order = False
        db.session.commit()
        return redirect(url_for('main.barista'))



@bp.route('/enable', methods=['GET'])
def enable():
        if current_user.is_anonymous or current_user.user_type != 'Barista':
                return redirect(url_for('main.login'))
        store = HalfCaf.query.get(1)
        store.acc_order = True
        db.session.commit()
        return redirect(url_for('main.barista'))

@app.errorhandler(404)
def not_found_error(error):
    return render_template('404.html'), 404
    
@app.errorhandler(500)
def internal_error(error):
    db.session.rollback()
    return render_template('500.html'), 500
