FROM centos:6
MAINTAINER babu <babu@initcron.org>

LABEL env=dev
RUN rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm && \
    yum -y install openssh-server shadow-utils sudo && \ 
    yum install puppet-agent -y && \
    yum clean all && \
    chkconfig puppet on

RUN sed -i -e "s/#PUPPET_SERVER=puppet/PUPPET_SERVER=puppet-server/g" /etc/sysconfig/puppet && \
    sed -i -e "s/#PUPPET_LOG/PUPPET_LOG/g" /etc/sysconfig/puppet && \ 
    echo "export PATH=$PATH:/opt/puppetlabs/bin" >> /home/devops/.bashrc

COPY motd.sh /opt/

RUN chmod +x /opt/motd.sh && \
    sh /opt/motd.sh && \
    rm -rf motd.sh

RUN echo -e "service sshd start && service sshd stop && \
    useradd devops && \
    echo 'devops:codespaces' | chpasswd && \
    /usr/sbin/sshd -D" > /bootstrap.sh

RUN echo 'devops ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY authorized_keys /home/devops/.ssh/authorized_keys

EXPOSE 22

CMD ["/bin/bash","/bootstrap.sh"]
