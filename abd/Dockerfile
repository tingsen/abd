FROM php:5.6-apache

# Debian 8 (jessie) 已归档，使用 archive 源
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list \
    && sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list \
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

# 从 GitHub 拉取项目代码
RUN rm -rf /var/www/html/* \
    && git clone --depth 1 https://github.com/tingsen/abd.git /tmp/repo \
    && cp -r /tmp/repo/abd/* /var/www/html/ \
    && rm -rf /tmp/repo

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
