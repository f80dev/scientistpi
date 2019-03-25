#install docker
#sudo curl -sSL get.docker.com | sh

#arm
#FROM python:3
#docker build -t f80hub/scientistpi . & docker push f80hub/scientistpi:latest
#pour les problemes de droit sur les répertoires : su -c "setenforce 0"
#docker rm -f scientistpi && docker pull f80hub/scientistpi:latest && docker run --restart=always -p 6271:6271 --name scientistpi -d f80hub/scientistpi:latest

#arm
FROM arm32v7/python:3-alpine
RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk --no-cache --update-cache add gcc g++ gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev openblas-dev
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN apk add py3-numpy
RUN apk add py3-scipy
RUN pip3 -v install matplotlib
RUN pip3 install --no-deps pandas==0.23.0
RUN pip3 -v install scikit-learn
RUN pip3 -v install networkx
RUN pip3 -v install hdbscan
RUN pip3 -v install simpledbf
RUN apk add py3-openssl
RUN pip3 -v install xlrd
RUN pip3 -v install folium
RUN pip3 -v install openpyxl
RUN pip3 -v install Flask
RUN pip3 -v install flask_restplus
RUN pip3 -v install stringDist
RUN pip3 -v install flask_cors
RUN pip3 -v install simplejson

EXPOSE 5000

RUN pip3 install --upgrade pip
RUN pip3 install setuptools

COPY requirements.txt requirements.txt
COPY app.py app.py
RUN pip3 install -r requirements.txt

ENTRYPOINT ["python", "app.py"]