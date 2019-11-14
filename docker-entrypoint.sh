#!/bin/sh
set -e

rm -rf /opt/app/tmp/*

if [ ${RAILS_ENV} = "production" ] && ! [ "${RAILS_RELATIVE_URL_ROOT}" = "/portfolio" ]
then
  rails assets:precompile RAILS_ENV=production
fi

exec "$@"
