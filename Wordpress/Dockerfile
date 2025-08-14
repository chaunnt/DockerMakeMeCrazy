FROM wordpress:6.8.2

# Set PHP limits
RUN { \
    echo "memory_limit = 256M"; \
    echo "upload_max_filesize = 40M"; \
    echo "post_max_size = 42M"; \
} > /usr/local/etc/php/conf.d/custom-php-limits.ini
