FROM debian:bookworm

EXPOSE 80

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx vim openssl curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html && \
    mkdir -p /var/run/nginx && \
    chmod 775 /var/www/html && \
    chown -R www-data:www-data /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/private.key -out /etc/nginx/ssl/certificate.crt -subj "/C=IT/ST=Lazio/L=Rome/O=42/OU=42/CN=adi-fort.42.fr/UID=root"

ENV MYSQL_PASSWORD="" \
    MYSQL_ROOT_PASSWORD="" \
    WP_ADMIN_PASSWORD="" \
    WP_USER_PASSWORD=""

ENTRYPOINT ["nginx", "-g", "daemon off;"]

