FROM geraudster/dockerjupyter
MAINTAINER geraudster

USER root
RUN echo 'deb http://ftp.igh.cnrs.fr/pub/CRAN/bin/linux/debian jessie-cran3/' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480

RUN apt-get -y update && \
      apt-get -y --no-install-recommends install \
      build-essential \
      libssl-dev \
      r-base \
      r-base-dev \
      libcurl4-gnutls-dev \
      libzmq3-dev \
      && \
    rm -rf /var/lib/apt/lists/*

#RUN apt-get -y update && \
#    apt-get -y --no-install-recommends -t jessie-backports install r-cran-stringi \
#    && \
#    rm -rf /var/lib/apt/lists/*

RUN R CMD javareconf JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 JAVA=/usr/bin/java && \
    curl -o rJava_0.9-9.tar.gz http://www.rforge.net/rJava/snapshot/rJava_0.9-9.tar.gz && \
    R CMD INSTALL --configure-args="--disable-Xrs" rJava_0.9-9.tar.gz

COPY install-irkernel.R /home/jupyter/
COPY Rprofile /home/jupyter/.Rprofile

USER jupyter
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN mkdir -p ~/R/x86_64-pc-linux-gnu-library/3.3
RUN R -e 'if (!require("devtools")) install.packages("devtools", repos="https://cran.rstudio.com/")'
RUN R -f /home/jupyter/install-irkernel.R
WORKDIR /data/jupyter/
