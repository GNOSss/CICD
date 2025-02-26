#!/bin/sh

# Nginx 시작
service nginx start

# Flask 실행
/flaskapp/venv/bin/flask --app /flaskapp/app run --host=0.0.0.0