FROM wordpress:php7.4

# Set PHP limits
RUN { \
    echo "memory_limit = 256M"; \
    echo "upload_max_filesize = 256M"; \
    echo "post_max_size = 128M"; \
} > /usr/local/etc/php/conf.d/custom-php-limits.ini

RUN chown -R 33:33 wp-content

