# syntax = nexus.cd.sac.int.threatmetrix.com:18450/docker/dockerfile:1
FROM quay.io/centos/centos:stream9

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked <<EOT
dnf install -y \
    gcc-toolset-15 \
    gdb
EOT

ADD files /files/.

WORKDIR /files

RUN <<EOT
. /opt/rh/gcc-toolset-15/enable
g++ -std=c++23 -g test.cpp
EOT
