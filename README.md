docker-teamspeak
==================

[![](https://images.microbadger.com/badges/image/solidnerd/teamspeak.svg)](http://microbadger.com/images/solidnerd/teamspeak "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/solidnerd/teamspeak.svg)](https://microbadger.com/images/solidnerd/teamspeak "Get your own commit badge on microbadger.com")

## Current Version: [3.0.13.6](https://github.com/SolidNerd/docker-teamspeak/blob/master/Dockerfile)

## Introduction

A docker container to running a teamspeak server with a SQLite database or a MySQL/MariaDB Database.

## Quickstart

Run the Teamspeak Server with a SQLite Database.

```
docker run -d --name="teamspeak_server" -p "9987:9987/udp" -p 10011:10011 -p 30033:30033 solidnerd/teamspeak:3.0.13.6
```

### Receiving Admin Token and Server Query Admin

To receive this information you need only to run:
```
docker logs teamspeak_server
```
Now you should see information like this:

```
------------------------------------------------------------------
                      I M P O R T A N T
------------------------------------------------------------------
               Server Query Admin Account created
         loginname= "serveradmin", password= "superSecret"
------------------------------------------------------------------

------------------------------------------------------------------
                      I M P O R T A N T
------------------------------------------------------------------
      ServerAdmin privilege key created, please use it to gain
      serveradmin rights for your virtualserver. please
      also check the doc/privilegekey_guide.txt for details.

       token=superSecret
------------------------------------------------------------------

```

## Start the teamspeak server with a Database

### Docker < v1.9

1. MariaDB Container:
```
docker run -d --name="teamspeak-mysql" -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=teamspeak -e MYSQL_USER=teamspeak -e MYSQL_PASSWORD=secret mariadb
```
2. Teamspeak Server Container :
```
docker run -d --name="teamspeak_server"  --env-file=.envfile -p "9987:9987/udp" -p 10011:10011 -p 30033:30033  --link teamspeak-mysql:mysql solidnerd/teamspeak:3.0.13.6
```

### Docker 1.9+
1. Create a shared network: `docker network create teamspeak_nw`
2. MariaDB container :

   ```
   docker run -d --net teamspeak_nw  \
   -e MYSQL_ROOT_PASSWORD=secret \
   -e MYSQL_DATABASE=teamspeak \
   -e MYSQL_USER=teamspeak \
   -e MYSQL_PASSWORD=secret \
   --name="teamspeak-mysql" \
   mariadb
   ```
3. Create Teamspeak Server Container :

   ```
   docker run -d --net teamspeak_nw --name="teamspeak_server" -p "9987:9987/udp" -p 10011:10011 -p 30033:30033 solidnerd/teamspeak:3.0.13.6
   ```

## Available Environment Variables

*Please refer the docker run command options for the `--env-file` flag where you can specify all required environment variables in a single file. This will save you from writing a potentially long docker run command. Alternatively you can use docker-compose.*

Below is the complete list of available options that can be used to customize your TeamSpeak container.

| Environment Variable | Description |
|-----------|-------------|
| `TS_USER` | User which owns the teamspeak_server pid. Defaults to `teamspeak`|
| `TS_HOME` |  Directory of the containing teamspeak file. Defaults to `/teamspeak` |
| `LOG_QUERY_COMMANDS` |Directory of the containing teamspeak file. Defaults to `0`  |
| `MACHINE_ID` | Optional name of this server process to identify a group of servers with the same ID. This can be useful when running multiple TeamSpeak 3 Server instances on the same database. Please note that we strongly recommend that you do NOT run multiple server instances on the same SQLite database. Default is `not used`. |
| `TS3_LICENSE_PATH` |  The physical path where your license file is located. Default is `Empty`.  |
| `DEFAULT_VOICE_PORT` |  UDP port open for clients to connect to. This port is used by the first  virtual server, subsequently  started virtual servers will open on increasing  port numbers Defautls to `9987`  |
| `VOICE_IP` |   IP on which the server instance will listen for incoming voice connections. Defaults to `0.0.0.0`  |
| `FILE_TRANSFER_PORT` |  TCP Port opened for file transfers. If you specify this parameter, you also  need to specify the `FILE_TRANSFER_IP` envoirment variable! Defautls to `30033` |
| `FILE_TRANSFER_IP` |  IP on which the file transfers are bound to. If you specify this parameter,  you also need to specify the `FILE_TRANSFER_PORT` envoirment variable! Defaults to `0.0.0.0`  |
| `QUERY_PORT` |TCP Port opened for file transfers. If you specify this parameter, you also  need to specify the `QUERY_IP` envoirment variable! Defautls to `10011` |
| `QUERY_IP` | IP bound for incoming ServerQuery connections. If you specify this parameter,  you also need to specify the `QUERY_PORT` envoirment variable! Defaults to `0.0.0.0`  |
| `QUERY_IP_WHITELIST` |  The file containing whitelisted IP addresses for the ServerQuery interface. All hosts listed in this file will be ignored by the ServerQuery flood protection. Defaults to `query_ip_whitelist.txt`  |
| `QUERY_IP_BLACKLIST` |  The file containing backlisted IP addresses for the ServerQuery interface. All hosts listed in this file will be ignored by the ServerQuery flood protection. Defaults to `query_ip_blacklist.txt` |
| `LOG_PATH` |   The physical path where the server will create logfiles. Defaults to `logs/`  |
| `LOG_QUERY_COMMAND` |  If set to "1", the server will log every ServerQuery command executed by clients. This can  be useful while trying to diagnose several different issues. Defaults to `0`  |
| `DB_CLIENT_KEEP_DAYS` |  Defines how many days to keep unused client identities. Auto-pruning is triggered on every  start and on every new month while the server is running. Defaults to `30`.  |
| `LOG_APPEND` |  If set to "1", the server will not create a new logfile on every start. Instead, the log output will be appended to the previous logfile. The logfile name will only contain the ID of the virtual server. Defaults to `0`.  |
| `QUERY_SKIP_BRUTEFORCE_CHECK` | Defaults to `0`.  |
| `TS3_MARIADB_DB` | Name of the Database. Default to  `Not Set`.  |
| `TS3_MARIADB_USER` | Database User. Default to  `Not Set`.  |
| `TS3_MARIADB_PASS` | Database User Password. Default to  `Not Set`. |
| `TS3_MARIADB_HOST` | Hostname of the DatabaseServer like localhost Default to  `Not Set`. |
| `TS3_MARIADB_PORT` | DatabaseServer Port. Default to  `Not Set`.  |

# LICENSE
The MIT License (MIT)

Copyright (c) 2016 Niclas Mietz
