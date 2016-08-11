FROM  debian:jessie

ENV   TS_VERSION 3.0.13
ENV   TS_FILENAME teamspeak3-server_linux_amd64

ENV   TS_USER teamspeak
ENV   TS_HOME /teamspeak

LABEL org.label-schema.version=$TS_VERSION

RUN   apt-get update && apt-get install wget mysql-common bzip2 -y \
      && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN   groupadd -r $TS_USER \
      && useradd -r -m \
        -g $TS_USER \
        -d $TS_HOME \
        $TS_USER

WORKDIR ${TS_HOME}

RUN  wget "http://dl.4players.de/ts/releases/${TS_VERSION}/${TS_FILENAME}-${TS_VERSION}.tar.bz2" -O ${TS_FILENAME}-${TS_VERSION}.tar.bz2 \
       && tar -xjf "${TS_FILENAME}-${TS_VERSION}.tar.bz2" \
       && rm ${TS_FILENAME}-${TS_VERSION}.tar.bz2 \
       && mv ${TS_FILENAME}/* . \
       && rm -r ${TS_FILENAME}
RUN  cp "$(pwd)/redist/libmariadb.so.2" $(pwd)

ADD entrypoint.sh ${TS_HOME}/entrypoint.sh

RUN chown -R ${TS_USER}:${TS_USER} ${TS_HOME} && chmod +x entrypoint.sh

USER  ${TS_USER}

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

ENTRYPOINT ["./entrypoint.sh"]
