FROM google/golang
MAINTAINER ryanharper007@zer0touch.co.uk

ENV GOGS_CUSTOM /opt/gogs
ADD https://github.com/gogits/gogs/releases/download/v0.9.97/linux_amd64.zip /tmp/gogs.zip
RUN apt-get update && \
    apt-get install -y openssh-server rsync unzip && \
    git clone https://github.com/gogits/gogs.git /gopath/src/github.com/gogits/gogs

RUN unzip -d /opt/ /tmp/gogs.zip

RUN useradd -m -d /home/git --shell /bin/bash --system --comment gogits git

RUN mkdir /var/run/sshd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config

# prepare data
RUN echo "export GOGS_CUSTOM=/opt/gogs" >> /etc/profile
VOLUME /consul-data
VOLUME /etc/consul.d
RUN chown -PR git /opt/gogs
ADD ./start.sh ./start.sh

EXPOSE 22 3000
ENTRYPOINT []
CMD ["./start.sh"]
