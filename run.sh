#!/usr/bin/with-contenv bashio

echo "Matterflow API backend running!"

source /matterflow/api/venv/bin/activate

cd /matterflow/api/mf

pipenv run python3 manage.py runserver 

