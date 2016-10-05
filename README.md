Gogs Docker Container
===========
[![Build Status](https://travis-ci.org/zer0touch/gogs.svg?branch=master)](https://travis-ci.org/zer0touch/gogs)
Dockerfile for [gogs](http://gogs.io) server(a self-hosted git service).

## Usage
```
docker pull zer0touch/gogs

mkdir /var/gogs
docker run -d -p 22:22 -p 3000:3000 -v /var/gogs:/data zer0touch/gogs
```

Open bowser and naviage to

```
http://youhost:3000
```

* Config file in /var/gogs/gogs/conf/app.ini
* git repo in /var/gogs/git

It's ok to change /var/gogs to other directory.

This docker image has sqlite installed

