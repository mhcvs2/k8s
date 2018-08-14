#!/usr/bin/env bash

test -d /root/.ssh_config && test -f /root/.ssh_config/authorized_keys && cp /root/.ssh_config/authorized_keys /root/.ssh/authorized_keys

/usr/sbin/sshd -D

