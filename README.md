docker
===========
[![Build Status](https://drone.service.consul/api/badge/gogs.service.consul/docker/gogs/status.svg?branch=master)](https://drone.service.consul/gogs.service.consul/docker/gogs)
Dockerfile for [gogs](http://gogs.io) server(a self-hosted git service).

## Usage
```
docker pull registry.service.consul/gogs

mkdir /var/gogs
docker run -d -p 22:22 -p 3000:3000 -v /var/gogs:/data registry.service.consul/gogs
```

Open bowser and naviage to

```
http://youhost:3000
```

* Config file in /var/gogs/gogs/conf/app.ini
* git repo in /var/gogs/git

It's ok to change /var/gogs to other directory.

This docker image has sqlite installed

