FROM centos:6
MAINTAINER babu <babu@initcron.org>

LABEL env=dev
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm && \
    yum -y install openssh-server shadow-utils sudo && \ 
    yum install puppet-agent -y && \
    yum clean all

RUN sed -i -e "s/#PUPPET_SERVER=puppet/PUPPET_SERVER=puppet-server/g" /etc/sysconfig/puppet && \
    sed -i -e "s/#PUPPET_LOG/PUPPET_LOG/g" /etc/sysconfig/puppet

COPY motd.sh /opt/

RUN chmod +x /opt/motd.sh && \
    sh /opt/motd.sh && \
    rm -rf /opt/motd.sh && \
    useradd devops && echo 'devops:codespaces' |chpasswd && \
    echo 'devops ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ADD ./entrypoint.sh /entrypoint.sh

EXPOSE 22

CMD ["/bin/bash","/entrypoint.sh"]
