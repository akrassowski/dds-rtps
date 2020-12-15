#!/bin/bash
#
# exercise deadline matching
#
source common.source

FLAGS="-d0 -b -Dv -t Shapes"
FLAGS="$FLAGS -f 1"
script -qf -c "$TOC -S $FLAGS " $BASE.toc.$TOC_VER.sub.out &
script -qf -c "$RTI -P $FLAGS -c RED" $BASE.rti.$RTI_VER.pub.out &

sleep 5

#echo ppid =$$
pgrep -P $$
pkill -P $$
ps -ef

# now flip roles
script -qf -c "$RTI -S $FLAGS " $BASE.rti.$RTI_VER.sub.out &
script -qf -c "$TOC -P $FLAGS -c RED" $BASE.toc.$TOC_VER.pub.out &

sleep 5

#echo ppid =$$
pgrep -P $$
pkill -P $$
ps -ef

