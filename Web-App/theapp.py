from app import app, db
from app.models import User, Flavor, MenuItem, Drink, Order, Temp, RoomNum, DrinksToFlavor

@app.shell_context_processor
def make_shell_context():
    return {'db': db,
            'User': User,
            'Flavor': Flavor,
            'MenuItem': MenuItem,
            'Drink' : Drink,
            'Order' : Order,
            'Temp' : Temp,
            'RoomNum' : RoomNum,
            'DrinksToFlavor' : DrinksToFlavor
            }
