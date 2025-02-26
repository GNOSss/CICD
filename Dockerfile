# FROM nginx:latest  

# RUN apt update  
# RUN apt install -y python3-full  
# RUN apt install -y procps  

# WORKDIR /flaskapp  
# RUN python3 -m venv /flaskapp/venv  

# COPY requirements.txt requirements.txt  
# RUN /flaskapp/venv/bin/pip install -r requirements.txt  

# COPY app.py app.py  
# COPY site.conf /etc/nginx/sites-available/flaskapp.conf  
# RUN ln -s /etc/nginx/sites-available/flaskapp.conf /etc/nginx/conf.d  
# RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak  

# COPY start.sh start.sh  
# RUN chmod 777 start.sh  

# ENTRYPOINT ["/flaskapp/start.sh"]

FROM nginx:latest  

# 필수 패키지 설치
RUN apt update && apt install -y python3-full procps python3-venv

# 작업 디렉토리 설정
WORKDIR /flaskapp  

# Python 가상환경 생성
RUN python3 -m venv /flaskapp/venv  

# 필요한 파일 복사
COPY requirements.txt /flaskapp/requirements.txt  
COPY app.py /flaskapp/app.py  
COPY site.conf /etc/nginx/sites-available/flaskapp.conf  
COPY start.sh /flaskapp/start.sh  

# Nginx 설정 적용
RUN ln -s /etc/nginx/sites-available/flaskapp.conf /etc/nginx/conf.d
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak  

# 실행 권한 부여
RUN chmod +x /flaskapp/start.sh  

# Python 패키지 설치
RUN /flaskapp/venv/bin/pip install -r /flaskapp/requirements.txt  

# 컨테이너 시작 시 start.sh 실행
ENTRYPOINT ["sh", "/flaskapp/start.sh"]
