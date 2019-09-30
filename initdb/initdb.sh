#!/bin/sh

createuser -D -R -S lxrng
createuser -D -R -S www-data

createdb ltp
createdb linux
createdb u-boot
createdb glibc
createdb gcc
createdb binutils
createdb busybox

