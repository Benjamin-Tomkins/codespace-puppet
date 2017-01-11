FROM centos:6
MAINTAINER babu <babu@initcron.org>

LABEL env=dev
RUN yum -y install http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm && \
    yum -y update && \
    yum -y install openssh-server shadow-utils sudo && \ 
    sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/puppetlabs.repo && \
    yum --enablerepo=puppetlabs-products,puppetlabs-deps -y install puppet && \
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
