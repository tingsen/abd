FROM php:5.6-apache

# 修复 Debian 9 (stretch) 归档源，跳过 GPG 验证和失效源
RUN echo 'deb [trusted=yes] http://archive.debian.org/debian stretch main' > /etc/apt/sources.list \
    && echo 'deb [trusted=yes] http://archive.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list \
    && rm -rf /etc/apt/sources.list.d/* \
    && apt-get update -o Acquire::Check-Valid-Until=false

# 安装系统依赖和 PHP 扩展
RUN apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libmcrypt-dev \
    zlib1g-dev \
    git \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysql mysqli pdo pdo_mysql mbstring mcrypt zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 启用 Apache mod_rewrite
RUN a2enmod rewrite

# 线上环境变量：区分本地/线上配置
ENV APP_ENV=deploy
ENV MYSQL_HOST=sh-cynosdbmysql-grp-24pqwrao.sql.tencentcdb.com
ENV MYSQL_PORT=25464

# 强制重新拉取代码，避免 Docker 缓存
RUN echo "cache-bust-20260704-1705" > /tmp/cache-bust

# 从 GitHub 拉取项目代码
RUN rm -rf /var/www/html/* \
    && git clone --depth 1 https://github.com/tingsen/abd.git /tmp/repo \
    && cp -r /tmp/repo/abd/* /var/www/html/ \
    && rm -rf /tmp/repo

# 注入线上数据库配置（覆盖 getenv，兼容 mod_php 环境变量继承问题）
RUN sed -i "s/getenv('MYSQL_HOST') ?: '172\.17\.0\.15'/'sh-cynosdbmysql-grp-24pqwrao.sql.tencentcdb.com'/" /var/www/html/Application/Common/Conf/config.php \
    && sed -i "s/getenv('MYSQL_PORT') ?: '3306'/'25464'/" /var/www/html/Application/Common/Conf/config.php \
    && sed -i "s/getenv('APP_ENV') ?: 'debug'/'deploy'/" /var/www/html/Application/Common/Conf/config.php \
    && sed -i "s/getenv('APP_ENV') !== 'deploy'/false/" /var/www/html/index.php

# 配置 Apache 支持 ThinkPHP URL 重写
RUN echo '<Directory /var/www/html/>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/thinkphp.conf \
    && a2enconf thinkphp

# 设置 Runtime 目录权限
RUN chown -R www-data:www-data /var/www/html \
    && mkdir -p /var/www/html/Application/Runtime \
    && chmod -R 777 /var/www/html/Application/Runtime

EXPOSE 80

CMD ["apache2-foreground"]
