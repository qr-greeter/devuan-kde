#!/usr/bin/env bash
set -ex
dpkg --add-architecture i386
apt update
apt install wine wine32 -y
