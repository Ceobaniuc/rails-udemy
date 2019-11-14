FROM ruby:2.6.5-alpine

# Default configuration
ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true \
    DB_PORT=5432 \
    DB_HOSTNAME=localhost \
    DB_DATABASE=rails_udemy \
    DB_USERNAME=root \
    DB_PASSWORD=root \
    HOME=/opt/app \
    REDIS_URL=redis://172.17.0.1:6379/1

COPY Gemfile Gemfile.lock /opt/app/
WORKDIR /opt/app

RUN buildDeps=' \
    build-base \
    postgresql-dev \
		git \
    curl \
	' \
	&& apk add $buildDeps tzdata postgresql-libs postgresql-client \
  && gem install --no-document bundler \
  && echo "gem: --no-document" > .gemrc \
	&& bundle install --without development test \
  && apk del $buildDeps \
	&& rm -rf /tmp/*

ADD . /opt/app/

RUN mv docker-entrypoint.sh /usr/local/bin/ \
  && chmod +x /usr/local/bin/docker-entrypoint.sh \
  && bundle exec rails assets:precompile RAILS_RELATIVE_URL_ROOT='/agendas' DB_ADAPTER=nulldb \
  && chown -R nobody:nogroup /opt/app

USER nobody

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rails", "server", "-p", "3000","-b","0.0.0.0", "-e", "$RAILS_ENV"]

EXPOSE 3000
