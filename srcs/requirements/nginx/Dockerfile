FROM debian:bullseye

RUN apt update && apt install -y \
        nginx \
        openssl \
       && rm -rf /var/lib/apt/lists/*; \
     openssl req -x509 -nodes -days 365 \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=iren.42.fr/UID=iren" \
    -newkey rsa:4096 -sha256 \
    -keyout /etc/ssl/private/inception.key \
    -out /etc/ssl/certs/inception.crt; \
    mkdir -p /var/www/wordpress \
    && chmod 755 /var/www/wordpress \
    && chown -R www-data:www-data /var/www/wordpress
# Create self-signed certificate
# Give permissions to nginx

COPY ./conf/default.conf /etc/nginx/conf.d/

# Create directory for nginx files
RUN mkdir -p /var/run/nginx

CMD ["nginx", "-g", "daemon off;"]
