from datetime import datetime
from app import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from app import login
from time import time
import jwt
from app import app


class User(UserMixin, db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    isActivated = db.Column(db.Boolean, index=True)
    username = db.Column(db.String(64), index=True, unique=True)
    email = db.Column(db.String(120), index=True, unique=True)
    password_hash = db.Column(db.String(128))
    order = db.relationship('Order', backref='teacher' , foreign_keys='[Order.teacher_id]')
    current_order_id = db.Column(db.Integer, db.ForeignKey('order.id'), nullable=True)
    user_type = db.Column(db.String(10), index=True)

    def __repr__(self):
        return '<User {}>'.format(self.username)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    def get_reset_password_token(self, expires_in=600):
        return jwt.encode({'reset_password': self.id, 'exp': time() + expires_in}, app.config['SECRET_KEY'], algorithm='HS256')
    
    
    @staticmethod
    def verify_reset_password_token(token):
        try:
            id = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])['reset_password']
        except:
            return
        return User.query.get(id)


class Order(db.Model):
    __tablename__ = 'order'
    id = db.Column(db.Integer, primary_key=True)
    teacher_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    drink = db.relationship('Drink', backref='order', foreign_keys='[Drink.order_id]')
    roomnum_id = db.Column(db.Integer, db.ForeignKey('roomnum.id'), nullable=True)
    timestamp = db.Column(db.DateTime, index=True, default=datetime.utcnow)
    read = db.Column(db.DateTime, index=True, default=datetime.utcnow)
    complete = db.Column(db.Boolean, index=True)

    def __repr__(self):
            return '<Order {}>'.format(self.id)

@login.user_loader
def load_user(id):
    return User.query.get(int(id))

class Flavor(db.Model):
    __tablename__ = 'flavor'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), index=True)


    def __repr__(self):
            return '<Flavor {}>'.format(self.name)

class MenuItem(db.Model):
    __tablename__ = 'menuItem'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), index=True, unique=True)
    description = db.Column(db.String(200), index=True)
    price = db.Column(db.Float, index=True)
    popular = db.Column(db.Boolean, index=True)

    def __repr__(self):
            return '<MenuItem {}>'.format(self.name)

class Temp(db.Model):
    __tablename__='temp'
    id = db.Column(db.Integer, primary_key=True)
    temp = db.Column(db.String(20), index=True)

class RoomNum(db.Model):
    __tablename__= 'roomnum'
    id = db.Column(db.Integer, primary_key=True)
    num = db.Column(db.String(25), index=True)

class Drink(db.Model):
    __tablename__ = 'drink'
    id = db.Column(db.Integer, primary_key=True)
    menuItem = db.Column(db.String(50), index=True)
    temp_id = db.Column(db.Integer, db.ForeignKey('temp.id'), nullable=False)
    decaf = db.Column(db.Boolean, index=True, default=False)
    flavors = db.Column(db.String(50), index=True)
    order_id = db.Column(db.Integer, db.ForeignKey('order.id'), nullable=True)
    inst = db.Column(db.String(150), index=True)

    def __repr__(self):
             return '<MenuItem {}>'.format(self.menuItem)

class DrinksToFlavor(db.Model):
    __tablename__ = 'drinksToFlavor'
    id = db.Column(db.Integer, primary_key=True)
    drink = db.Column(db.String(50), index=True)
    drinkId = db.Column(db.Integer, index=True)
    flavor = db.Column(db.String(50), index=True) #also might want to make this the id
    flavorId = db.Column(db.Integer, db.ForeignKey('flavor.id'), index=True)

    def __repr__(self):
             return '<DrinksToFlavor {}>'.format(self.drink)

class FavoriteDrink(db.Model):
    __tablename__ = 'favoriteDrinks'
    id = db.Column(db.Integer, primary_key=True)
    userId = db.Column(db.Integer, db.ForeignKey('user.id'), index=True)
    drinkId = db.Column(db.Integer, db.ForeignKey('drink.id'), index=True) 
    menuId = db.Column(db.Integer, db.ForeignKey('menuItem.id'), index=True)
    tempId = db.Column(db.Integer, db.ForeignKey('temp.id'))
    decaf = db.Column(db.Boolean, index=True, default=False)
    flavorId = db.Column(db.Integer, db.ForeignKey('flavor.id'), index=True)


class HalfCaf(db.Model):
    __tablename__ = 'HalfCaf'
    id = db.Column(db.Integer, primary_key=True)
    acc_order =db.Column(db.Boolean, index=True, default=True)
