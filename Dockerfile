FROM python:3.6-slim

ARG PYTHON_VERSION=3.6
COPY setup_10.x /tmp/
RUN bash /tmp/setup_10.x

RUN apt-get update && apt-get install  -y --no-install-recommends \
    build-essential \
    nodejs \
    cmake \
    libpng-dev \
    libxml2 \
    curl \
    git \
    ca-certificates \
    libjpeg-dev \
    libpng-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ENV PATH /opt/conda/bin:$PATH
# RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
#      chmod +x ~/miniconda.sh && \
#      ~/miniconda.sh -b -p /opt/conda && \
#      rm ~/miniconda.sh && \
#      /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing pytorch && \
#      /opt/conda/bin/conda clean -ya

ENV LANG=C.UTF-8


COPY requirements.txt requirements.txt
RUN pip --no-cache-dir install -r requirements.txt
COPY installext.sh  installext.sh
RUN ./installext.sh

EXPOSE 8888
RUN mkdir -p /opt/app/data
CMD jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root