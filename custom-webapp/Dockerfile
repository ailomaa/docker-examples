FROM python:3.12

COPY myapp/ /srv/myapp
WORKDIR /srv

RUN pip install --upgrade pip
RUN pip install flask

CMD ["flask", "--app", "myapp/main", "run", "--host=0.0.0.0"]
