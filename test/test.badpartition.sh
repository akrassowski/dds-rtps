#!/bin/bash
#
# exercise partition matching - confirm failure
#
source common.source

FLAGS="-d0 -b -Dv -t Shapes"
#FLAGS="$FLAGS -p MATCHING_PARTITION"
script -qf -c "$TOC -S $FLAGS -p P1" $BASE.toc.$TOC_VER.sub.out &
script -qf -c "$RTI -P $FLAGS -p P2 -c RED" $BASE.rti.$RTI_VER.pub.out &

sleep 5

#echo ppid =$$
pgrep -P $$
pkill -P $$
ps -ef

# now flip roles
script -qf -c "$RTI -S $FLAGS -p P1" $BASE.rti.$RTI_VER.sub.out &
script -qf -c "$TOC -P $FLAGS -p P2 -c RED" $BASE.toc.$TOC_VER.pub.out &

sleep 5

#echo ppid =$$
pgrep -P $$
pkill -P $$
ps -ef

