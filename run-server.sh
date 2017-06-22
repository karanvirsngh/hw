#!/bin/bash

./wait-for-it db:5432 -- echo "Postgres:DB is up"

python3 manage.py migrate


echo "from django.contrib.auth.models import User
if not User.objects.filter(username='admin').count():
	User.objects.create_superuser('admin', 'admin@example.com', 'pass')
" | python3 manage.py shell

python3 manage.py runserver 0.0.0.0:8000
