FROM geraudster/dockerjupyter
MAINTAINER geraudster

USER root
RUN echo 'deb http://ftp.igh.cnrs.fr/pub/CRAN/bin/linux/debian jessie-cran3/' >> /etc/apt/sources.list
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install \
    r-base \
    r-base-dev \
    r-cran-rjava

COPY install-irkernel.R /home/jupyter/
COPY Rprofile /home/jupyter/.Rprofile

USER jupyter
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN mkdir -p ~/R/x86_64-pc-linux-gnu-library/3.2
RUN R -f /home/jupyter/install-irkernel.R
WORKDIR /data/jupyter/
