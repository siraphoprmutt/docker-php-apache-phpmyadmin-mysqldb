#!/bin/bash

# อัปเดตและติดตั้งแพ็กเกจที่จำเป็น
apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip unzip \
    libxml2-dev &&
    docker-php-ext-configure gd --with-freetype --with-jpeg &&
    docker-php-ext-install gd zip pdo pdo_mysql mysqli soap

# ล้างแคชเพื่อลดขนาดของ Docker Image
apt-get clean && rm -rf /var/lib/apt/lists/*
