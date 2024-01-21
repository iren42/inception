FROM debian:bullseye

RUN apt-get update && apt-get install -y \
        nginx \
        openssl \
       && rm -rf /var/lib/apt/lists/*; \
     openssl req -x509 -nodes -days 365 \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=iren.42.fr/UID=iren" \
    -newkey rsa:4096 -sha256 \
    -keyout /etc/ssl/private/inception.key \
    -out /etc/ssl/certs/inception.crt; \
    mkdir -p /var/www/wordpress; \
    mkdir -p /var/run/nginx
# Create self-signed certificate
# Create directory for nginx files

COPY ./conf/default.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]
