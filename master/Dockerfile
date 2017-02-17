FROM ubuntu:14.04
MAINTAINER Babu R <babu@initcron.org>

WORKDIR /workspace
VOLUME /workspace

RUN apt-get update && \
	apt-get install -y make g++ python git curl && \
	curl -sL https://deb.nodesource.com/setup | sudo bash - && \
	apt-get install -y nodejs && \
	npm -g install node-gyp akurath && \
	cd /usr/lib/node_modules/akurath/node_modules/shux/node_modules/pty.js && \
	make clean && \
	make

ADD https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb /opt

RUN dpkg -i /opt/puppetlabs-release-pc1-trusty.deb && \
    rm -rf /opt/puppetlabs-release-pc1-trusty.deb && \
    apt-get update && \
    apt-get install -y puppet-agent puppetserver && \
    sed -i "s/^JAVA_ARGS.*/JAVA_ARGS=\"${JAVA_ARGS}\"/g" /etc/default/puppetserver && \
    echo "export PATH=$PATH:/opt/puppetlabs/bin" >> /root/.bashrc && \
    apt-get install -y openssh-server sudo vim && \
    mkdir /var/run/sshd

COPY motd.sh /opt/

RUN chmod +x /opt/motd.sh && \
    sh /opt/motd.sh && \
    rm -rf motd.sh

RUN useradd -ms /bin/bash devops && \
    echo 'devops:codespaces' |chpasswd && \
    adduser devops sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config

COPY insecure_key.pem /root/.ssh/id_rsa

EXPOSE 22 8000

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/bin/akurath run
