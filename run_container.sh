#!/bin/sh
htpasswd -b -c /etc/nginx/htpasswd $USERNAME $PASSWORD
nginx
cd /code
mkdir logs
mkdir eggs
logparser -dir /code/logs -t 10 --delete_json_files --scrapyd_server 127.0.0.1:6800 & scrapyd