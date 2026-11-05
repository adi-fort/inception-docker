FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["bin/bash", "/tmp/setup.sh"]
