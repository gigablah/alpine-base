#!/bin/bash
set -ex

SKALIBS_VERSION=2.3.5.1
EXECLINE_VERSION=2.1.2.2
S6_VERSION=2.1.6.0

mkdir -p /tmp/output

## Build skalibs
cd /tmp
curl -ksSL http://skarnet.org/software/skalibs/skalibs-$SKALIBS_VERSION.tar.gz | tar xzf -
cd skalibs-$SKALIBS_VERSION
./configure --enable-shared --enable-static --disable-allstatic --prefix=/usr --libdir=/usr/lib --enable-force-devr
make && make install && make DESTDIR=/tmp/output install

## Build execline
cd /tmp
curl -ksSL http://skarnet.org/software/execline/execline-$EXECLINE_VERSION.tar.gz | tar xzf -
cd execline-$EXECLINE_VERSION
./configure --enable-shared --enable-static --disable-allstatic --prefix=/usr --libdir=/usr/lib
make && make install && make DESTDIR=/tmp/output install

## Build s6
cd /tmp
curl -ksSL http://skarnet.org/software/s6/s6-$S6_VERSION.tar.gz | tar xzf -
cd s6-$S6_VERSION
./configure --enable-shared --enable-static --disable-allstatic --prefix=/usr --libdir=/usr/lib
make && make DESTDIR=/tmp/output install

cd /tmp/output
tar czf /opt/s6-$S6_VERSION.tar.gz *
