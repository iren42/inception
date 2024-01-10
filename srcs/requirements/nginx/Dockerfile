FROM debian:bullseye

RUN apt update && apt upgrade -y

# Install nginx and openssl
RUN apt install -y nginx openssl

# for debugging purpose
#RUN apt install -y curl vim tmux net-tools

# Copy config
COPY ./conf/default.conf /etc/nginx/conf.d/


# Create self-signed certificate
RUN openssl req -x509 -nodes -days 365 \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=iren.42.fr/UID=iren" \
    -newkey rsa:4096 -sha256 \
    -keyout /etc/ssl/private/inception.key \
    -out /etc/ssl/certs/inception.crt

# Give permissions to nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Create directory for nginx files
RUN mkdir -p /var/run/nginx

CMD ["nginx", "-g", "daemon off;"]
