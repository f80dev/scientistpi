#install docker
#sudo curl -sSL get.docker.com | sh

#arm
#FROM python:3
#docker build -t f80hub/scientistpi . & docker push f80hub/scientistpi:latest
#pour les problemes de droit sur les répertoires : su -c "setenforce 0"
#docker rm -f scientistpi && docker pull f80hub/scientistpi:latest && docker run --restart=always --name scientistpi -d f80hub/scientistpi:latest

#arm
FROM arm32v7/python:3-alpine

RUN apk update && apk upgrade

RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk --no-cache --update-cache add gcc g++ gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev openblas-dev
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN apk add py3-numpy
RUN apk add py3-scipy
RUN apk add py3-openssl

RUN pip3 install --upgrade pip
RUN pip3 install setuptools

RUN pip3 install --no-deps pandas==0.23.0
RUN pip3 -v install scikit-learn
RUN pip3 -v install networkx
RUN pip3 -v install hdbscan
RUN pip3 -v install simpledbf
RUN pip3 -v install xlrd
RUN pip3 -v install folium
RUN pip3 -v install openpyxl
RUN pip3 -v install Flask
RUN pip3 -v install flask_restplus
RUN pip3 -v install stringDist
RUN pip3 -v install flask_cors
RUN pip3 -v install simplejson

RUN pip3 -v install --no-cache-dir minstall matplotlib==3.0.3

#Configuration pour l'application
RUN adduser -D app && mkdir /server && chown -R app:app /server
WORKDIR server

USER app

#Installation des libraries complémentaires
ADD requirements.txt /server/requirements.txt
RUN pip3 install -r /server/requirements.txt

#Installation du serveur
ADD app.py /server/app.py
ADD test.py /server/test.py

#Netoyage
RUN apk del --purge build-base libgfortran libpng-dev freetype-dev python3-dev py-numpy-dev && rm -vrf /var/cache/apk/*

ENTRYPOINT ["python"]
