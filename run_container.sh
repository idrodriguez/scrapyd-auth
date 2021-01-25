#!/bin/sh
htpasswd -b -c /etc/nginx/htpasswd $USERNAME $PASSWORD
nginx

SCRAPY_LOGS="/code/logs"
SCRAPY_EGGS="/code/eggs"

if [ ! -d $SCRAPY_LOGS ] 
then
        mkdir $SCRAPY_LOGS
        echo "Creating logs folder"
fi

if [ ! -d $SCRAPY_EGGS ] 
then
        mkdir $SCRAPY_EGGS
        echo "Creating eggs folder"
fi

logparser -dir $SCRAPY_LOGS -t 10 --delete_json_files --scrapyd_server 127.0.0.1:6800 & scrapyd
