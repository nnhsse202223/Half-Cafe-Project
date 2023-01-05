from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, SelectField, SelectMultipleField, TextAreaField, widgets, RadioField, FieldList, FormField
from wtforms.validators import DataRequired, ValidationError, Email, EqualTo
from app.models import User, Flavor, MenuItem, Drink, Order, Temp, RoomNum, DrinksToFlavor

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember_me = BooleanField('Remember Me')
    submit = SubmitField('Sign in')

class RegistrationForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    password2 = PasswordField(
        'Repeat password', validators=[DataRequired(), EqualTo('password')])
    user_type = SelectField(u'User Type', choices=[('Teacher', 'Teacher'), ('Barista', 'Barista'), ('Admin', 'Admin')])
    # ^ change this line here ^
    submit = SubmitField('Register')

    def validate_username(self, username):
        user = User.query.filter_by(username=username.data).first()
        if user is not None:
            raise ValidationError('Please use a different username.')
    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        if user is not None:
            raise ValidationError('Please use a different email address.')

class TeacherRegistrationForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    email = StringField('Email', validators=[DataRequired(), Email()])
    password = PasswordField('Password', validators=[DataRequired()])
    password2 = PasswordField(
        'Repeat password', validators=[DataRequired(), EqualTo('password')])
    user_type = SelectField(u'User Type', choices=[('Teacher', 'Teacher')])
    # ^ change this line here ^
    submit = SubmitField('Register')

    def validate_username(self, username):
        user = User.query.filter_by(username=username.data).first()
        if user is not None:
            raise ValidationError('Please use a different username.')

    def validate_email(self, email):
        user = User.query.filter_by(email=email.data).first()
        if user is not None:
            raise ValidationError('Please use a different email address.')

class CustomizeForm(FlaskForm):
    temp = SelectField(u'Temperature', coerce=int)
    decaf = BooleanField(u'Decaf')
    flavors = SelectField(u'Flavors', coerce=str)
    fav = BooleanField(u'Favorite')
    inst = TextAreaField(u'Special Instructions')

    submit = SubmitField('Add to Order')

    def __init__(self, drinkI):
        super(CustomizeForm, self).__init__()

        self.temp.choices = [(t.id, t.temp) for t in Temp.query.order_by(Temp.id)]
        self.flavors.choices = [(f.flavorId, f.flavor) for f in DrinksToFlavor.query.filter_by(drinkId = drinkI)] #this is where i need to change the query


class FavoriteDrinksForm(FlaskForm):
    favs = SelectField(u'Favorites', coerce=int)
    order = SubmitField('Add to Order')
    delete = SubmitField('Delete')
    
    def __init__(self, favDrinks):
        super(FavoriteDrinksForm, self).__init__()

        self.favList = []
        self.favs.choices = []
        counter = 0
        for i in favDrinks:
            d = Drink.query.get(i.drinkId)
            f = Flavor.query.get(i.flavorId).name
            t = Temp.query.get(i.tempId).temp
            m = MenuItem.query.get(i.menuId)
            self.favList.append((d, m, f, t, counter))
            self.favs.choices.append((i.id, m.name + " (" + f + ")"))
            counter+=1

        

class OrderForm(FlaskForm):
    room = SelectField(u'Room Number:', coerce=int, validators=[DataRequired()])

    submit = SubmitField('Order')

    def __init__(self):
        super(OrderForm, self).__init__()

        self.room.choices = [(r.id, r.num) for r in RoomNum.query.order_by(RoomNum.id)]

class BaristaForm(FlaskForm):

    clear_completed_orders = SubmitField(u'Complete Orders')

    

class A_UserDashboardForm(FlaskForm):
    submitActivate = SubmitField('Activate Users')
    submitDeactivate = SubmitField('Deactivate Users')
    submitView = SubmitField('Update Display')
    views = RadioField('Views')
    users = SelectMultipleField('Users')


    def __init__(self, view='1'):
        super(A_UserDashboardForm, self).__init__()
        self.userList = []

        if view == '1': #all
            self.userList = [(i.id, i.username) for i in User.query.order_by(User.id)]
        elif view == '2': #activated
            for u in User.query.order_by(User.id):
                if u.isActivated:
                    self.userList.append((u.id, u.username))
        elif view == '3': #unactivated
            for u in User.query.order_by(User.id):
                if not u.isActivated:
                    self.userList.append((u.id, u.username))
        self.users.choices = self.userList
        self.views.choices = [('1', 'All'), ('2', 'Activated'), ('3', 'Unactivated')]


# User Forms
class A_AddUserForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    
    user_email = StringField('Email Address', validators=[DataRequired(), Email()])
    user_type = SelectField(u'User Type', choices=[('Teacher', 'Teacher'), ('Barista', 'Barista'), ('Admin', 'Admin')])
    
    submit = SubmitField('Add User')

    def validate_username(self, username):
        u = User.query.filter_by(username=username.data).first()
        if u is not None:
            raise ValidationError('Please use a different username.')

class A_DeleteUserForm(FlaskForm):
    user = SelectField(u'User', coerce=str)

    submit = SubmitField('Delete User')

    def __init__(self):
        super(A_DeleteUserForm, self).__init__()
        self.user.choices = [(i.id, i.username) for i in User.query.order_by(User.id)]

class ResetPasswordRequestForm(FlaskForm):
    email = StringField('Email', validators={DataRequired(), Email()})
    submit = SubmitField('Request Password Reset')

class ResetPasswordForm(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired()])
    password2 = PasswordField('Repeat Password', validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Request Password Reset')

# Drink Forms
class A_AddDrinkForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])
    desc = TextAreaField('Description', validators=[DataRequired()])
    price = StringField('Price', validators=[DataRequired()])
    popular = BooleanField('Popular')

    submit = SubmitField('Add Drink')

    def validate_name(self, name):
        m = MenuItem.query.filter_by(name=name.data).first()
        if m is not None:
            raise ValidationError('Please use a different name.')


class A_ModifyDrinkForm(FlaskForm):
    drink = SelectField('Drink', coerce=str)
    submit = SubmitField('Modify Drink')
    flavor = SelectMultipleField('Flavors') #the varable for the drop down part for flavors

    def __init__(self):
        super(A_ModifyDrinkForm, self).__init__()
        self.drink.choices = [(i.id, i.name) for i in MenuItem.query.order_by(MenuItem.id)]
        self.flavor.choices = [(i.id, i.name) for i in Flavor.query.order_by(Flavor.id)]

class A_DeleteDrinkForm(FlaskForm):
    drink = SelectField('Drink', coerce=str)

    submit = SubmitField('Delete Drink')

    def __init__(self):
        super(A_DeleteDrinkForm, self).__init__()
        self.drink.choices = [(i.id, i.name) for i in MenuItem.query.order_by(MenuItem.id)]


# Flavor Forms
class A_AddFlavorForm(FlaskForm):
    name = StringField('Name', validators=[DataRequired()])

    submit = SubmitField('Add Flavor')

    def validate_name(self, name):
        f = Flavor.query.filter_by(name=name.data).first()
        if f is not None:
            raise ValidationError('Please use a different name.')

class A_DeleteFlavorForm(FlaskForm):
    flavor = SelectField(u'Flavor', coerce=str)

    submit = SubmitField('Delete Flavor')

    def __init__(self):
        super(A_DeleteFlavorForm, self).__init__()
        self.flavor.choices = [(i.id, i.name) for i in Flavor.query.order_by(Flavor.id)]

