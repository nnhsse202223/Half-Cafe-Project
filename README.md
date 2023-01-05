# half-caf-web-app
Group Members: Nathan, Naglis, David, Aadi

Group Members v2: Grace, Jessica, Kasey, Owen

Group Members v3 (Best group): Divya, Hansheng, Krish, Sophia

nnhshalfcaf.com


## Insights

Do not turn to any of those "easy web app maker" sites and source their code. We tried this for the first sprint and a half, and ultimately we discovered that the coding conventions are so diverse that none of the tutorial code or prior knowledge you have gained applies. It takes longer to understand and modify this code to your needs than it does to make your own web app with your obtained knowledge.

Make sure everyone is on the same page throughout the course of the semester. Take your stand-up meeting times to make sure everyone understands the concepts and has everything they need to work on their assigned tasks. It is okay to slow down to have somebody catch up because by the end of the project it will be a lot more efficient and helpful to have them on the same page.

Create a schedule and stick to it (google calendar is a great tool for this). When writing the code for the website, unknown issues frequently come up. In order to ensure that you have enough time to finish a sprint, leave yourself time at the end of each sprint to tie up loose ends.

Use pair programming to your advantage. Just because it may seem faster to divide and conquer in terms of being able to get tasks done doesnt mean it necessarily is. Having a second set of eyes to catch errors and talk things through with can be extremely beneficial and save you tons of time in the long run.

## Quickstart

From a terminal in VS Code, in the root directory of this repository, run the following:

```
docker compose up
```

After running it, proceed to your browser and go to "localhost:5000" to see the running webapp.

## Git

Git workflows: https://www.google.com/url?q=https://docs.google.com/document/d/1eWng-q4m3h4TwRcapSAPxexKST6AjQMfA9iVv2GRnwM/edit?usp%3Dsharing&sa=D&ust=1559225309220000

### Models (Database)
Record - Entry in a table
SQLite - A form of database used for testing that will only save the content of the database to a file called app.db inside the app
MySQL - The type of database used on the production server which is a real database that can be accessed from any instance of the app
Model - A class in models.py which will define a table in the SQLite or MySQL database

A database is a collection of tables with the name of the item or "model" each record represents. Each table has columns, each of with having a data type and a name. Every table will have an ID column which is used to identify the individual records in the table.


__tablename__ - The name you can use to reference this table anywhere else in this file
id - The only column every table will have, always a db.Integer

The __repr__ function tells python how to print a record from the table. This example would print "Example David" or "Example Nathan"

```python
class Example(db.Model):

    __tablename__ = 'example'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), index=True)
    otherModel = db.relationship('Other Model', backref='example', foreign_keys='[OtherModel.order_id]')

    def __repr__(self):
            return '<Example {}>'.format(self.name)
```

### Migrations
Whenever you make a change to the database, you will notice a new file is automatically generated in the /migrations/versions folder. 

This is a database migration, which "upgrades" the existing database structure to incorporate your changes (instead of, for example, a system that entirely wipes and regenerates the database whenever a change is made.) If you make a change to the models.py file, and end up with new migrations on your branch, make sure to compare them to the migrations in the main branch, and also confirm that the migrations in your branch refer to each other linearly with no loops or splitting. This will prevent painful merge conflicts occur when you pull.

In addition, before pulling a branch into main that has modified the schema, check if multiple migration files have been created. If so, delete all new migration files and regenerate a single migration file. The benefit of this practice is that it minimizes the number of migration files to only those that are required.  

### Routes
Each function in the routes.py file is a view function. View functions are basically the code that the page you are viewing is running on.

The @bp.route decorator tells Flask that this function will be used as the view function for the page specified in the render_template function.

The model variable is an example of how you can query the database in the view function and pass it as a variable to later be accessed in the templating code on that page.

```python
@bp.route('/', methods=['GET', 'POST'])
@bp.route('/example, methods=['GET', 'POST'])
def example():
        model = Model.query.all()

        return render_template('example.html', title=Example Page', model=model)
```

### Forms

The only thing about forms that we used that was not covered in the tutorial is the dynamically populated fields. 

In the init function, you call super then set each field's choices as the items coerced from the database with a for loop in the format shown.

```python
class ExForm(FlaskForm):
    dynamicField= SelectField(u'Things', coerce=str)

    submit = SubmitField('Submitr')

    def __init__(self):
        super(Form, self).__init__()

        self.dynamicField.choices = [(m.id, m.name) for m in Model.query.order_by(Model.id)]
```


### Jinja (Templating Language)
This link has everything you need to know
https://pythonprogramming.net/bootstrap-jinja-templates-flask/

### CSS / Bootstrap
All of the styling of an HTML document is set by code written in a language called CSS (Cascading Style Sheets). With CSS code, you can set every aspect of the styling (colors, size, elements, features) of either an entire page of the web app, or a portion of a page. Bootstrap is the most popular CSS and HTML framework.

If order to style a page, you need to set a &lt;style&gt; html tag within the head of your html page and define some properties of the  page within it. For example:

```html
<style>
	margin = 10px;
	color = #F0F8FF;
</style>
```

This is the exact styling used on our "layout" template, meaning if the html page "layout" was displayed, the page margin would be 10 pixels and the color associated with the HEX value of #F0F8FF, which is "Alice Blue" (link for all color Hex tags linked below).

All colors and Hex tags recognized in CSS: https://www.w3schools.com/colors/colors_names.asp

Now if you look at the rest of our HTML template pages, they all extend "layout". This means the styling of the "layout" page applies to all pages extending it as well. However, simply adding a new style tag in the head of a page extending "layout" would override the styling of "layout".

If you don't want to style the whole page and only certain elements within the page, use a method called in line styling. Essentially, you can add &lt;div&gt; tags around the element you would like to style and then add CSS code for that element within the div tag.
	
## Docker

Docker is the shell-like container that holds the webapp so that we can easily deploy it onto Amazon Web Services. However, we have three main docker containers that we are combining using docker-compose. You shouldn't have to modify the docker container files at all unless additional features added somehow interfere. However, when you add new code to your local machine, you need to migrate the code to the database container by using the command docker db migrate (if changes are made to the db). Instead of using flask run to run the program, you will now run the changes that you made through the docker container using docker compose up --build when starting your machine or after making changes. If you have already run this command but want to rerun it, you can use docker compose up to run it quicker. Then upload the newly made changes from the docker container into AWS. You will need to reference Mr.Schmit for this part.

Essential lines of code include:

- STARTING APP (WHEN YOU FIRST LOG ON)
Run each command in a different terminal window (do not have to be in your virtual  environment)

- Start all three containers in development mode (database, phpMyAdmin, flask app)
	```
	docker compose -f docker-compose.yml -f docker-compose.debug.yml up --build
	```

- Rebuild and restart just the webapp container (usually this is not needed when making changes)
  ```
  docker compose -f docker-compose.yml -f docker-compose.debug.yml up --build webapp
  ```

- Allows user to enter the executive container in order to execute certain commands
	```
	docker compose exec webapp /bin/sh
	```

- Rebuild the MYSQL container and recreate from scratch. Use this when you make changes to the db container before building the container again. Leave out -d to see it run	
	```
	docker compose up -d --build --force-recreate --renew-anon-volumes db
	```

- Stops ALL docker containers running	
	```
	docker compose stop
	```
	
## Debugging
The python code running in the docker container can be debugged via VS Code. When run in development mode, the debugpy module is used to connect VS Code to the Flask server. To attach to the Flask server running in the docker container, choose "Start Debugging" from the "Run" menu.

## Requirements.txt
Specifies the versions of all the different modules that have been imported/used within the code

Essential Lines of code:

- Do this to install/ create the requirements document (only do once in the beginning)
	```
	pip install -r requirements.txt
	```
	
- Do this if you import anything new to automatically update your requirement.txt file to the newest version	
	```
	pip freeze > requirements.txt
	```
	

## Backup.sql
This file holds all the hardcoded database information regarding the website in case the database is ever wiped

Essential lines of code:

- To create and/or update backup file for database
	```
	docker exec CONTAINER /usr/bin/mysqldump -u root --password=PASSWORD nnhshalfcaf > backup.sql
	```
	
- To restore file for database on a machine
	```
	cat ./backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=PASSWORD nnhshalfcaf
	```
	

## Things for repairing

use /supersecretpage to register any types of users.
This is a way to get around activating accounts manually.
If you get locked out, start here.

## Moving Forward… 
Easy things that could be improved with the website
- Styling, it is a very basic look right now and with some added CSS and bootstrap it can look pretty great (add logo)

Harder things
- improve funtionality of modify drinks page for all aspects of a drink not just flavors
- have a way to store information to show trends to Mr.Skarr of what people are buying
- Potentially show inventory of specific ingredients and after each order is made baristas would be able to enter it, and Mr.Skarr would know when to buy more
- notification for barista when order is made

See Trello for more details


## Production Server

#### Initial Setup:

1. Create an [AWS EC2 instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) running an Ubuntu Server
	* don't change any of the default settings while stepping through the wizard except to add HTTP and HTTPS to the security group when stepping through the wizard
2. Click the Connect button in the EC2 dashboard. Follow the instructions. You will need to have the private key in order to ssh into the instance.
3. On the EC2 instance, install nginx:
	`sudo apt-get -y install nginx`
4. Remove the default site:
	`sudo rm /etc/nginx/sites-enabled/default`
5. Create a reverse proxy for the Half Caf flask server. In the file /etc/nginx/sites-enabled/nnhshalfcaf:

```
	server {
		# listen on port 80 (http)
		listen 80;
		server_name nnhshalfcaf.com;

		# write access and error logs to /var/log
		access_log /var/log/nnhshalfcaf_access.log;
		error_log /var/log/nnhshalfcaf_error.log;

		location / {
			# forward application requests to the node server
			proxy_pass http://localhost:5000;
			proxy_redirect off;
			proxy_set_header Host $host;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		}
	}
```

6. Restart the nginx server:
	`sudo service nginx reload`
7. Install and configure [certbot](https://certbot.eff.org/lets-encrypt/ubuntufocal-nginx)
8. clone this repository from GitHub
9. [Install docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) from its repository
10. [Install docker compose](https://docs.docker.com/compose/install/).
11. create the .env file in the Web-App folder:
```
	SECRET_KEY=<secret key>
	DATABASE_URL=mysql+pymysql://halfcafmysql:<password>@db/nnhshalfcaf
```
12. Build and run the db container:
```
	sudo docker-compose up --build db
```
13. Build and run the webapp container:
```
	sudo docker-compose up --build webapp
```
14. Initialize the database:
```
	sudo cat /home/ubuntu/half-caf-app-2022/backup.sql | sudo docker exec -i half-caf-app-2022_db_1 /usr/bin/mysql -u root --password=<PASSWORD> nnhshalfcaf
```
15. On the EC2 instance, [install](https://github.com/nodesource/distributions/blob/master/README.md) Node.js v12:
```
curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
```
16. Install Production Manager 2, which is used to keep the node server running and restart it when changes are pushed to main:
```
sudo npm install pm2 -g
sudo pm2 --name db start "docker-compose up --build db"
sudo pm2 --name webapp start "docker-compose up --build webapp" --watch
```
17. Verify that the node server is running:
```
sudo pm2 list
```
18. Configure pm2 to automatically run when the EC2 instance restarts:
```
sudo pm2 startup
```
19. Add a crontab entry to pull from GitHub every 15 minutes:
```
crontab -e
*/15 * * * * cd /home/ubuntu/half-caf-app-2022 && git pull
```
20. [Unlock Captcha](https://accounts.google.com/b/0/displayunlockcaptcha)

#### Connecting to the EC2 Instance:
1. Click the Connect button in the EC2 dashboard. Follow the instructions. You will need to have the private key in order to ssh into the instance.


#### Updating code on the EC2 instance:
1. Pull the latest code from main:
```
	git pull
```
2. start the container for the database:
```
	sudo docker-compose up --build db
```
3. start the container for the webapp:
```
	sudo docker-compose up --build webapp
```




## ESSENTIAL LINES OF CODE AND COMMANDS

<style>
#tips {
  border-collapse: collapse;
  width: 100%;
}

#tips td, #tips th {
  border: 1px solid #ddd;
  padding: 8px;
}

#tips tr:nth-child(even){background-color: #f2f2f2;}

#tips tr:hover {background-color: #ddd;}

#tips th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
}
</style>
<table id="tips">
  <tr>
    <td>code</td>
    <td>where it's used</td>
    <td>what it does/when to use</td>
  </tr>
  <tr>
    <td>1. shift command P → select interpreter (python 3 venv)
2. shift command P →  integrated terminal</td>
    <td>VS Code</td>
    <td>DO THIS RIGHT WHEN YOU START VS CODE!</td>
  </tr>
  <tr>
    <td>flask run</td>
    <td>terminal</td>
    <td>Runs the web app</td>
  </tr>
  <tr>
    <td>flask db migrate
flask db upgrade</td>
    <td>terminal</td>
    <td>Use whenever you modify the database to upload the changes</td>
  </tr>
  <tr>
    <td>db.session.commit()</td>
    <td>routes, forms</td>
    <td>Commits changes to the database</td>
  </tr>
  <tr>
    <td>docker-compose up --build db
docker-compose up --build webapp</td>
    <td>terminal (docker)</td>
    <td>STARTING APP (WHEN YOU FIRST LOG ON)
Run each command in a different terminal window (do not have to be in your virtual  environment)</td>
  </tr>
  <tr>
    <td>docker-compose exec webapp /bin/sh</td>
    <td>terminal (docker)</td>
    <td>Allows user to enter the executive container in order to execute certain commands</td>
  </tr>
  <tr>
    <td>docker-compose up --build</td>
    <td>Terminal (docker)</td>
    <td>Builds and runs the docker container. Can build individual containers by adding the container name at the end.</td>
  </tr>
  <tr>
    <td>docker-compose up</td>
    <td>Terminal (docker)</td>
    <td>Use to run the webapp if you have already built container and have not made any changes</td>
  </tr>
  <tr>
    <td>docker-compose up -d --build --force-recreate --renew-anon-volumes db</td>
    <td>Terminal (docker)</td>
    <td>Rebuild the MYSQL container and recreate from scratch. Use this when you make changes to the db container before building the container again. Leave out -d to see it run</td>
  </tr>
  <tr>
    <td>docker-compose stop</td>
    <td>Terminal (docker)</td>
    <td>Stops ALL docker containers running</td>
  </tr>
  <tr>
    <td>docker db migrate
docker db upgrade</td>
    <td>Terminal 
 </td>
    <td>Use to upload changes to the docker containers database (in place of flask db migrate/upgrade)</td>
  </tr>
  <tr>
    <td>pip install -r requirements.txt</td>
    <td>Terminal</td>
    <td>Do this to install/ create the requirements document (only do once in the beginning)</td>
  </tr>
  <tr>
    <td>pip freeze > requirements.txt</td>
    <td>Terminal</td>
    <td>Do this if you import anything new to automatically update your requirement.txt file to the newest version</td>
  </tr>
  <tr>
    <td>docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql</td>
    <td>Terminal</td>
    <td>Creates and/or updates backup file for database</td>
  </tr>
  <tr>
    <td>cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE</td>
    <td>Terminal</td>
    <td>Restore file for database on a machine</td>
  </tr>
  <tr>
    <td>Open the terminal
Secure shell into the existing server
Ls
Cd nnhshalfcaf.com
Ls
Cd tmp
Ls
Touch restart
Touch restart.txt</td>
    <td>Terminal</td>
    <td>Restart old nnhsCaf server</td>
  </tr>
</table>


## HALF CAF WEB APP STRUCTURE

### models.py

Where all the tables in the database are created as classes. Add new columns/tables to the database here. Must do "docker db migrate" & "docker db upgrade" in the terminal afterward to update the database.

### forms.py

This is where you make all of the buttons, text fields, select fields, etc. This works using the HTML templates.

### routes.py

Handles interactions between the user and the webpage. This is where everything is connected (forms, models, etc). This is where you read information from the site (e.g. which button was pressed or if a checkmark is selected) and do things with the info like modify the database (make sure to use db.session.commit()!!!). Once you're done, reroute the user to a different page (or to the same one to refresh).

### Templates

HTML templates for page designs/structures.

**Requirements.txt**

Specifies the versions of all the different modules that have been imported/used within the code

**Docker-Compose.yml**

Initializes container that includes both Dockerfile and database

* Uses mysql

* Container  name: webapp

* Root password: [see Mr. Schmit]

**Init.sql**

Creates and Initializes database

	Database name: nnhshalfcaf

Creates and grants all privileges to user

	Username: [see Mr. Schmit]

	Password: [see Mr. Schmit]

**Dockerfile**

Initializes container by running set commands

COPY: copies files

RUN: runs files

**.env**

Creates a secret key, initializes database url, and configures flask mail.

	DATABASE_URL=mysql+pymysql://username:password@db/databasename
	MAIL_SERVER=smtp.googlemail.com
	MAIL_PORT=587
	MAIL_USE_TLS=1
	MAIL_USERNAME= [see Mr. Schmit]
	MAIL_PASSWORD= [see Mr. Schmit]

Accessed through config.py

## NOTES

**Docker**

Docker is the shell-like container that holds the webapp so that we can easily deploy it onto Amazon Web Services. However, we have two main docker containers that we are combining using docker-compose. You shouldn't have to modify the docker container files at all unless additional features added somehow interfere. However, when you add new code to your local machine, you need to migrate the code to the database container by using the command *docker db migrate *(if changes are made to the db). Instead of using flask run to run the program, you will now run the changes that you made through the docker container using *docker-compose up --build *when starting your machine or after making changes. If you have already run this command but want to rerun it, you can use *docker-compose up *to run it quicker. Then upload the newly made changes from the docker container into AWS. You will need to reference Mr.Schmit for this part.

**DrinksToFlavor**

This is an object created to designate what flavors belong to what drink. Each object has two parts, saying a drink and a flavor. This means that there would be a bunch of DrinkToFlavor objects for a singular drink, and if you collected all of them it would display what flavors belong to what drink, which is what we do in the modify drink page.







