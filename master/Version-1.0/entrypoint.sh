#!/bin/bash

/etc/init.d/puppetserver start

exec "$@"
