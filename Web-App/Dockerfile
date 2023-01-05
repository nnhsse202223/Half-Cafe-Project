FROM python:3.10-buster
RUN useradd -d /home/half-caf-web-app -m half-caf-web-app
WORKDIR /home/half-caf-web-app
COPY requirements.txt requirements.txt
RUN python -m venv env
RUN env/bin/pip install -r requirements.txt
RUN env/bin/pip install gunicorn pymysql cryptography
COPY theapp.py .env config.py boot.sh ./
RUN chmod +x boot.sh
ENV FLASK_APP theapp.py
RUN chown -R half-caf-web-app:half-caf-web-app ./
USER half-caf-web-app
EXPOSE 5000
ENTRYPOINT ["./boot.sh"]
