FROM codespaces/base-centos:6
MAINTAINER Vijayboopathy <vibe@initcron.org>

LABEL env=dev
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm && \
    yum install puppet-agent -y && \
    yum clean all

RUN sed -i -e "s/#PUPPET_SERVER=puppet/PUPPET_SERVER=puppet-server/g" /etc/sysconfig/puppet && \
    sed -i -e "s/#PUPPET_LOG/PUPPET_LOG/g" /etc/sysconfig/puppet 

EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
