FROM ubuntu:14.04
MAINTAINER Babu <babu@initcron.org>

RUN apt-get update

ADD https://apt.puppetlabs.com/puppetlabs-release-trusty.deb /opt

RUN dpkg -i /opt/puppetlabs-release-trusty.deb && \
    rm -rf /opt/puppetlabs-release-trusty.deb && \
    apt-get update && \
    apt-get install -y puppet sysv-rc-conf && \
    sysv-rc-conf puppet on
    

RUN sed -i 's/templatedir/#templatedir/g' /etc/puppet/puppet.conf && \
    sed -i 's/ssl_client_header/#ssl_client_header/g' etc/puppet/puppet.conf && \
    sed -i 's/ssl_client_verify_header/#ssl_client_verify_header/g' etc/puppet/puppet.conf && \
    sed -i '$a [agent] ' /etc/puppet/puppet.conf && \
    sed -i '$a server = puppet-server' /etc/puppet/puppet.conf && \
    sed -i 's/START=no/START=yes/g' /etc/default/puppet

RUN apt-get install -y openssh-server sudo vim python python-apt python-pip
RUN mkdir /var/run/sshd

COPY motd.sh /opt/

RUN chmod +x /opt/motd.sh && \
    sh /opt/motd.sh && \
    rm -rf motd.sh

#RUN useradd -ms /bin/bash devops && echo 'devops:123456' |chpasswd

#RUN echo 'devops ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo -e "service sshd start && service sshd stop && \
    useradd devops && \
    echo 'devops:codespaces' | chpasswd && \
    /usr/sbin/sshd -D" > /bootstrap.sh

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY authorized_keys /home/devops/.ssh/authorized_keys

EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
