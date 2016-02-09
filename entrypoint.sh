#!/bin/bash

echo "Modifying ts3db_mariadb.ini with following info:
Host=$TS3DB_PORT_3306_TCP_ADDR,
Port=$TS3DB_PORT_3306_TCP_PORT,
Database=$TS3_MARIADB_DB,
Username=$TS3_MARIADB_USER,
Password=$TS3_MARIADB_PASS"

#Create MariaDB Config
sed -i -e "s/host=.*/host=$TS3DB_PORT_3306_TCP_ADDR/g" ts3db_mariadb.ini
sed -i -e "s/port=.*/port=$TS3DB_PORT_3306_TCP_PORT/g" ts3db_mariadb.ini
sed -i -e "s/username=.*/username=$TS3_MARIADB_USER/g" ts3db_mariadb.ini
sed -i -e "s/password=.*/password=$TS3_MARIADB_PASS/g" ts3db_mariadb.ini
sed -i -e "s/database=.*/database=$TS3_MARIADB_DB/g"   ts3db_mariadb.ini

# Run Teamspeak server
ls -al
cat ts3server_minimal_runscript.sh
exec ./ts3server inifile=ts3server.ini
