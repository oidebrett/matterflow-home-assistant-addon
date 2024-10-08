#!/usr/bin/with-contenv bashio

echo "==> Starting Matterflow API backend"

source /matterflow/api/venv/bin/activate

cd /matterflow/api/mf

#Migrate the sql database
python3 manage.py migrate

#Start the server
python3 manage.py runserver &
echo "Matterflow API backend started!"

echo "==> Starting Matterflow Web application"

cd /matterflow/web
npm run dev
echo "Matterflow Web application started!"
