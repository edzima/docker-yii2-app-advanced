ARG PHP_BASE_IMAGE_VERSION
FROM ${PHP_BASE_IMAGE_VERSION}
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions decimal
