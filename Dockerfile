FROM piwik

RUN  buildDeps=" \
      git \
    " \
    && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
    && docker-php-ext-install redis

RUN git clone -b "0.3.2" https://github.com/piwik/plugin-QueuedTracking/ /usr/src/piwik/plugins/QueuedTracking/ \
    && php /usr/src/piwik/console plugin:activate QueuedTracking
