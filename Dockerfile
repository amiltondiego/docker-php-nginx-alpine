FROM alpine:3.14

LABEL maintainer="Amilton Diego <amiltondiego@gmail.com>"
LABEL description="Image Alpine with NGINX, SUPERRVISOR, GIT, CURL, PHP_FPM [mysqli, pdo_mysql, sqlite3, pdo_pgsql, bcmath, odbc, pdo_sqlite, json, openssl, curl, zlib, session, xml, phar, intl, dom, xmlreader, ctype, mbstring, gd, pcntl, opcache, xdebug, mongodb, redis]."

ENV TIMEZONE America/Sao_Paulo

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main"  >> /etc/apk/repositories

RUN apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk upgrade && \
    apk add --update tzdata

RUN apk --no-cache \
    add php8 \
    php8-fpm \
    php8-mysqli \
    php8-pdo_mysql \
    php8-sqlite3 \
    php8-pdo_pgsql \
    php8-bcmath \
    php8-odbc \
    php8-pdo_sqlite  \
    php8-json \
    php8-openssl \
    php8-curl \
    php8-zlib \
    php8-session \
    php8-xml \
    php8-phar \
    php8-intl \
    php8-dom \
    php8-xmlreader \
    php8-ctype \
    php8-mbstring \
    php8-gd \
    php8-pcntl \
    php8-opcache \
    php8-pecl-xdebug \
    php8-pecl-mongodb \
    php8-pecl-redis \
    nginx \
    supervisor \
    curl \
    git \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/

RUN apk del tzdata && \
    curl -sS https://getcomposer.org/installer | php8 -- --install-dir=/usr/bin --filename=composer \
    composer global require hirak/prestissimo

RUN sed -i "s|;date.timezone =.*|date.timezone=${TIMEZONE}|" /etc/php8/php.ini

RUN ln -s /usr/bin/php8 /usr/bin/php

COPY config/nginx.conf /etc/nginx/nginx.conf

COPY config/fpm-pool.conf /etc/php8/php-fpm.d/custom.conf

COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY config/xdebug.conf /etc/php8/conf.d/50_xdebug.ini

RUN mkdir -p /app/public
RUN mkdir -p /var/log/supervisord && chmod -Rf 777 /var/log/supervisord
WORKDIR /app

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]