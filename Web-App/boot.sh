#!/bin/bash
source env/bin/activate
flask db migrate
flask db upgrade

if [ "$FLASK_ENV" = "development" ]; then
    echo "running in development mode"
    python -m debugpy --listen 0.0.0.0:5678 -m flask run --host 0.0.0.0
else
    echo "running in production mode"
    exec gunicorn -b :5000 --access-logfile - --error-logfile - theapp:app
fi