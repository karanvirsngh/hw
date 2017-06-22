#!/bin/bash

is_up(){
				local service=$1
				local port=$2
				local name=$3

				./wait-for-it $service:$port
				if [[ $? != 0 ]];then
        				echo "Timed out waiting for $name to come up, .: exiting"
								exit -1
        else
        				echo "$name	| is up"
        fi

}

is_up cache 6379 'Django Cache: Redis>'
is_up db 5432 'Django DB: postgres'


python3 manage.py migrate


echo "from django.contrib.auth.models import User
if not User.objects.filter(username='admin').count():
	User.objects.create_superuser('admin', 'admin@example.com', 'pass')
" | python3 manage.py shell

python3 manage.py runserver 0.0.0.0:8000
