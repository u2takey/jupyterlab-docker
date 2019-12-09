FROM python:3.8-slim

ARG PYTHON_VERSION=3.8
RUN apt-get update && apt-get install  -y --no-install-recommends \
    build-essential \
    cmake \
    nodejs \
    curl \
    git \
    npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN node --version
ENV LANG=C.UTF-8

RUN pip --no-cache-dir install \
    jupyter \
    ipywidgets \
    jupyterlab \
    cython \
    jupyter-lab-serverless \
    jupyterlab_code_formatter \
    jupyterlab-snippets \
    jupyterlab_latex \
    jupyterlab_github \

RUN jupyter labextension install \
    @jupyter-widgets/jupyterlab-manager \
    @u2takey/jupyter-lab-serverless \
    @jupyterlab/toc \
    @krassowski/jupyterlab_go_to_definition \
    @ryantam626/jupyterlab_code_formatter \
    @jupyterlab/latex \
    jupyterlab-drawio \
    @jupyterlab/github \
    jupyterlab_bokeh \
    @lckr/jupyterlab_variableinspector


EXPOSE 8888
RUN mkdir -p /opt/app/data
CMD jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root