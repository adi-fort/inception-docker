FROM debian:bookworm

RUN apt-get update && apt-get install -y curl
RUN apt update
RUN apt upgrade -y
RUN apt install wget php php-fpm php-mysql mariadb-client -y

RUN curl -o /var/www/wordpress-6.4.tar.gz -SL https://wordpress.org/wordpress-6.4.tar.gz
RUN cd /var/www && tar -xzf wordpress-6.4.tar.gz && rm -rf wordpress-6.4.tar.gz
RUN chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /usr/local/bin 

COPY ./tools/setup.sh /tmp/setup.sh
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "/tmp/setup.sh"]

