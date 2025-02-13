FROM php:8.3-apache

# ตั้งค่า Document Root
WORKDIR /var/www/html

# คัดลอกไฟล์ Config
COPY docker/php-extensions.sh /usr/local/bin/
COPY docker/php.ini /usr/local/etc/php/
COPY docker/apache-config.conf /etc/apache2/sites-available/000-default.conf

# ติดตั้ง PHP Extensions ที่จำเป็น
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip intl curl soap mbstring fileinfo opcache

# เปิดใช้งาน mod_rewrite
RUN a2enmod rewrite

# คัดลอก **เฉพาะโค้ดจาก `src/`**
COPY src/ /var/www/html/

# ตั้งค่า Permissions
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# เปิดพอร์ต 80
EXPOSE 80

# รีสตาร์ท Apache
CMD ["apache2-foreground"]
