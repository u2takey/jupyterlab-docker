FROM python:3.7-slim

RUN apt-get update && apt-get install  -y --no-install-recommends \
    nodejs \
    gcc \
    make \
    g++ \
    gfortran \
    libpng-dev \
    freetype-dev libxml2-dev libxslt-dev \
    curl \
    git \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8

COPY requirements.txt requirements.txt
RUN pip --no-cache-dir install -r requirements.txt  -i https://pypi.douban.com/simple
COPY installext.sh  installext.sh
RUN ./installext.sh

EXPOSE 8888
RUN mkdir -p /opt/app/data
CMD jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root