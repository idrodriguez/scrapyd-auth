# Scrapyd with nginx authentication

[Scrapy](https://scrapyd.readthedocs.io/en/stable/) daemon is not developed as a daemon that allows authentication for access. Therefore, to protect your daemon, you need to serve scrapyd through a web server like [nginx](https://www.nginx.org/). Bypassing the request to scrapyd internally and returning the output to nginx.

In this setup, nginx is working on port 80 and scrapyd in port 6800; externally, you will need to map only the port 80 as is mentioned in the [docker-compose.yml](docker-compose.yml) file.

[logparser](https://github.com/my8100/logparser) is needed if you are using [ScrapydWeb](https://github.com/my8100/scrapydweb) for managing your projects. It is included and running in the docker instance, communicating directly with scrapyd.

# .env file

You must setup your .env file accordingly to what your spider is requesting. For authentication purposes only, use:

```sh
USERNAME="USERNAME"
PASSWORD="PASSWORD"
````

After the setup you can reference in the [docker-compose.yml](docker-compose.yml) file.