FROM centos:6
MAINTAINER babu <babu@initcron.org>

LABEL env=dev
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm && \
    yum -y install openssh-server shadow-utils sudo && \ 
    yum install puppet-agent -y && \
    yum clean all && \
    chkconfig puppet on

RUN sed -i -e "s/#PUPPET_SERVER=puppet/PUPPET_SERVER=puppet-server/g" /etc/sysconfig/puppet && \
    sed -i -e "s/#PUPPET_LOG/PUPPET_LOG/g" /etc/sysconfig/puppet 

COPY motd.sh /opt/

RUN chmod +x /opt/motd.sh && \
    sh /opt/motd.sh && \
    rm -rf /opt/motd.sh && \
    useradd devops && \
    echo 'devops:codespaces' | chpasswd

RUN echo -e "service sshd start && service sshd stop && \
    /usr/sbin/sshd -D" > /bootstrap.sh

RUN echo 'devops ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir -p /home/devops/.ssh

ADD authorized_keys /home/devops/.ssh/authorized_keys

RUN chown -R devops. /home/devops/.ssh

EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
