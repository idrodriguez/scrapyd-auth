FROM python:3-alpine

WORKDIR /code
VOLUME ["/etc/scrapyd/", "/var/lib/scrapyd/", "/var/log/scrapyd/"]

RUN apk add --update \
  gcc \
  musl-dev \
  libffi-dev \
  libxml2-dev \
  libxslt-dev \
  openssl-dev \
  python-dev \
  musl-dev

# scrapyd install & Setup
RUN pip3 install scrapyd 
COPY ./scrapyd.conf /etc/scrapyd/scrapyd.conf
COPY ./requirements.txt .

# scrapy/postgresql client/fake-useragent dependencies for the spiders
RUN pip3 install -r requirements.txt

# nginx install and setup to use it instead of scrapy daemon directly
RUN apk add nginx \
  apache2-utils

RUN adduser -D -g 'www' www

RUN mkdir /www \ 
  && chown -R www:www /var/lib/nginx \
  && chown -R www:www /www \
  && chown -R www:www /code \
  && mkdir /tmp/nginx \
  && chmod 1777 /tmp/nginx \
  && mkdir /run/nginx

COPY nginx.conf /etc/nginx/nginx.conf

RUN pip3 install logparser

# Run container
COPY ./run_container.sh /usr/local/bin/run_container.sh
RUN ["chmod", "777", "/usr/local/bin/run_container.sh"]
CMD /usr/local/bin/run_container.sh
