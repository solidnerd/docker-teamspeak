FROM  debian:jessie

ENV   DEBIAN_FRONTEND noninteractive
ENV   TS_VERSION 3.0.11.2

ENV   TS3_MARIADB_DB TS3_DB_9987
ENV   TS3_MARIADB_USER root
ENV   TS3_MARIADB_PASS password

RUN   apt-get update && apt-get install wget mysql-common -y
RUN   wget "http://dl.4players.de/ts/releases/$TS_VERSION/teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz" \
      -O teamspeak3-server_linux-amd64-$TS_VERSION.tar.gz \
      ; tar -zxf teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz \
      ; mv teamspeak3-server_linux-amd64 /opt/teamspeak \
      ; rm teamspeak3-server_linux-amd64-${TS_VERSION}.tar.gz


RUN  cp "/opt/teamspeak/redist/libmariadb.so.2" /opt/teamspeak

ADD ini/ts3server.ini /opt/teamspeak/ts3server.ini
ADD ini/ts3db_mariadb.ini /opt/teamspeak/ts3db_mariadb.ini

ADD scripts/start /start

RUN chmod +x /start

#Make Image smaller
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9987/udp
EXPOSE 10011
EXPOSE 30033

ENTRYPOINT ["/start"]
