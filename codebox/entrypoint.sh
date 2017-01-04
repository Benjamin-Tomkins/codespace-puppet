#!/bin/bash

/etc/init.d/ssh start
/etc/init.d/puppetserver start
/usr/bin/codebox run -u $CODEBOX_USERNAME:$CODEBOX_PASSWORD
