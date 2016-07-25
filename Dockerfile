# Pull base image.
FROM bigboards/cdh-base-__arch__

MAINTAINER bigboards
USER root 

RUN apt-get update \
    && apt-get install -y flume-ng flume-ng-agent \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

ADD docker_files/run.sh /apps/run.sh
RUN chmod a+x /apps/run.sh

# declare the volumes
RUN mkdir -p /etc/hadoop/conf.bb && \
    update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.bb 1 && \
    update-alternatives --set hadoop-conf /etc/hadoop/conf.bb
VOLUME /etc/hadoop/conf.bb

RUN mkdir -p /etc/flume-ng/conf.bb && \
    update-alternatives --install /etc/flume-ng/conf flume-ng-conf /etc/flume-ng/conf.bb 1 && \
    update-alternatives --set flume-ng-conf /etc/flume-ng/conf.bb
VOLUME /etc/flume-ng/conf.bb

# external ports
EXPOSE 41414 

CMD ["/apps/run.sh"]
