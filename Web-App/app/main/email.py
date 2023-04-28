from flask_mail import Message
from app import mail
from flask import render_template
from app import app

def order_email(name, order, subject, sender, recipients):
    msg = Message(subject, sender = sender, recipients = recipients)
    msg.body = "Hi " + name + "! Thanks for ordering from the Half-Caf! Your order has been completed and you will be recieving it shortly. Here is what you have ordered: " + str(order) 
    msg.html = "Hi " + name + "! Thanks for ordering from the Half-Caf! <br> \
    Your order has been completed and you will be receiving it shortly. <br> Here is what you have ordered: " + str(order)
    mail.send(msg)


def reg_email(user):
    msg = Message("Please activate new user", sender = 'nnhshalfcafapp@gmail.com', recipients = ['nnhshalfcafapp@gmail.com'])
    msg.body = "username: " + user.username + " user type: " + user.user_type + " user email: " + user.email
    msg.html = "<b> Username: </b>" + user.username + "<br> <b> User Type: </b>" + user.user_type + "<br><b> User Email Address: </b>"+ user.email
    mail.send(msg)
    
def send_email(subject, sender, recipients, text_body, html_body):
    msg = Message(subject, sender = sender, recipients = recipients)
    msg.body = text_body
    msg.html = html_body
    mail.send(msg)

def send_password_reset_email(user):
    token = user.get_reset_password_token()
    send_email('[Microblog] Reset Your Password', sender=app.config['ADMINS'][0], recipients=[user.email], text_body=render_template('email/reset_password.txt', user=user, token=token), html_body=render_template('email/reset_password.html', user=user, token=token))