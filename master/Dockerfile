FROM codespaces/base-ubuntu-akurath:v0.1.0
MAINTAINER Vijayboopathy E <vibe@initcron.org>

ADD https://apt.puppetlabs.com/puppetlabs-release-pc1-trusty.deb /opt

RUN dpkg -i /opt/puppetlabs-release-pc1-trusty.deb && \
    rm -rf /opt/puppetlabs-release-pc1-trusty.deb && \
    apt-get update && \
    apt-get install -y puppet-agent puppetserver && \
    sed -i "s/^JAVA_ARGS.*/JAVA_ARGS=\"${JAVA_ARGS}\"/g" /etc/default/puppetserver && \
    echo "export PATH=$PATH:/opt/puppetlabs/bin" >> /root/.bashrc

EXPOSE 22 8000

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD /usr/bin/akurath run
