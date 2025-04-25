#!/bin/sh

if [ "$POSTGRES_DB" = "store" ]
then
    echo "Ждем postgres..."

    while ! nc -z "db" $POSTGRES_PORT; do
      sleep 0.5
    done

    echo "PostgreSQL запущен"
fi

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --noinput
python manage.py loaddata fixtures/goods/categories.json
python manage.py loaddata fixtures/goods/products.json

exec "$@"