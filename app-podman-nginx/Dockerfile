# Base image for the web application deployed with Podman
FROM docker.io/library/nginx:alpine

# Install tools required to generate the TLS certificate and credentials
RUN apk add --no-cache openssl apache2-utils

# Copy the web content and Nginx configuration into the image
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Generate a self-signed x.509 certificate and HTTP Basic Authentication credentials
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=CO/ST=Santander/O=UNIR/OU=DevOps/CN=casopractico2" && \
    htpasswd -cb /etc/nginx/.htpasswd alumno unir2026

# HTTPS port exposed by the container
EXPOSE 443
