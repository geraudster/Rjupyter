FROM debian:jessie-backports
MAINTAINER geraudster

RUN echo 'deb http://ftp.igh.cnrs.fr/pub/CRAN/bin/linux/debian jessie-cran3/' >> /etc/apt/sources.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

RUN apt-get update && apt-get -y upgrade && apt-get -y install locales
RUN sed -i.bak 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -y install \
    build-essential python3-dev python3-pip python3-zmq

RUN apt-get -y install \
    curl \
    openjdk-7-jre-headless \
    libcurl4-gnutls-dev \
    libzmq3-dev

RUN apt-get -y install \
    r-base \
    r-base-dev \
    r-cran-rjava

RUN pip3 install jupyter

COPY install-irkernel.R /tmp

RUN (adduser --disabled-password --gecos "" jupyter)

RUN mkdir -p /home/jupyter/.jupyter && chown jupyter /home/jupyter/.jupyter
RUN mkdir -p /data/jupyter && chown jupyter /data/jupyter

COPY conf/jupyter_notebook_config.py /home/jupyter/.jupyter
COPY Rprofile /home/jupyter/.Rprofile

USER jupyter
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN mkdir -p ~/R/x86_64-pc-linux-gnu-library/3.2
RUN R -f /tmp/install-irkernel.R
WORKDIR /data/jupyter
