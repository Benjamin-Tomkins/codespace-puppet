#!/bin/bash

/etc/init.d/sshd start
/etc/init.d/puppet start
/etc/init.d/sshd stop
/usr/sbin/sshd -D
