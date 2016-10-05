#!/bin/bash
#
CONSUL_JOIN=$(ip r g 8.8.8.8 | awk '{ gsub(/\n$/,""); printf("%s", $3); }')
DATACENTRE=${DATACENTRE:-"default"}
ENCRYPT=${ENCRYPT:-"Ka33LTg+OADO9G1W2+4REQ=="}

service ssh start
exec /usr/local/bin/consul agent -data-dir /consul-data -config-dir /etc/consul.d -join $CONSUL_JOIN -dc $DATACENTRE -client 0.0.0.0 -encrypt ${ENCRYPT} &

if ! test -d /opt/gogs
then
	mkdir -p /var/run/sshd
	mkdir -p /opt/gogs/data /opt/gogs/conf /opt/gogs/log /opt/gogs/data/git /opt/gogs/git
fi

#test -d /data/gogs/templates || cp -ar ./templates /data/gogs/

#ln -sf /data/gogs/log ./log
#ln -sf /data/gogs/data ./data
#ln -sf /data/git /home/git

#rsync -rtv /data/gogs/templates/ ./templates/

if ! test -d ~git/.ssh
then
  mkdir ~git/.ssh
  chmod 600 ~git/.ssh
fi

if ! test -f ~git/.ssh/environment
then
  echo "GOGS_CUSTOM=/opt/gogs" > ~git/.ssh/environment
  chown git:git ~git/.ssh/environment
  chown 600 ~git/.ssh/environment
fi

chown -PR git:git /opt/gogs
exec su git -c "cd /opt/gogs ; ./gogs web"
