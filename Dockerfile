FROM google/golang
MAINTAINER ryanharper007@zer0touch.co.uk

RUN apt-get install -y openssh-server

# grab but do not build gogs
RUN git clone https://github.com/gogits/gogs.git /gopath/src/github.com/gogits/gogs

## set the working directory and add current stuff
#WORKDIR /gopath/src/github.com/gogits/gogs
#RUN git checkout master
#RUN go get -v -tags sqlite
#RUN go build -tags sqlite
RUN apt-get install -y rsync unzip

ADD https://github.com/gogits/gogs/releases/download/v0.5.11/linux_amd64.zip /tmp/gogs.zip
RUN unzip -d /opt/ /tmp/gogs.zip

RUN useradd -m -d /home/git --shell /bin/bash --system --comment gogits git

RUN mkdir /var/run/sshd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config

# prepare data
ENV GOGS_CUSTOM /opt/gogs
RUN echo "export GOGS_CUSTOM=/opt/gogs" >> /etc/profile


#ADD . /gopath/src/github.com/gogits/gogs

VOLUME /consul-data
VOLUME /etc/consul.d
ADD https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip /consul.zip
ADD https://dl.bintray.com/mitchellh/consul/0.4.1_web_ui.zip /consul-ui.zip
RUN unzip -d /usr/local/bin/ /consul.zip
ADD ./services/gogs.json /etc/consul.d/gogs.json
RUN chown -PR git /opt/gogs
ADD ./start.sh ./start.sh

EXPOSE 22 3000
ENTRYPOINT []
CMD ["./start.sh"]
