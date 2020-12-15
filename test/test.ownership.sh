#!/bin/bash
#
# exercise ownership
#   2 publishers, 1 subscriber
#
source common.source

FLAGS="-d0 -b -Dv -t Shapes"
#FLAGS="$FLAGS -f 1"
script -qf -c "$TOC -S $FLAGS -s 1"         $BASE.toc.$TOC_VER.sub.out &
script -qf -c "$RTI -P $FLAGS -s 10 -c RED" $BASE.rti.$RTI_VER.pub10.out &
sleep 3
# add higher strength publisher
script -qf -c "$RTI -P $FLAGS -s 20 -c RED" $BASE.rti.$RTI_VER.pub20.out &
sleep 5

# TODO - kill just higher strength publisher
#echo ppid =$$
pgrep -P $$
pkill -P $$
ps -ef | grep script

#kill $(list_descendants $$)
echo listing...
$(list_descendants $$)

# now flip roles
script -qf -c "$RTI -S $FLAGS -s 1"         $BASE.rti.$RTI_VER.sub.out &
script -qf -c "$TOC -P $FLAGS -s 10 -c RED" $BASE.toc.$TOC_VER.pub10.out &
sleep 3
script -qf -c "$TOC -P $FLAGS -s 20 -c RED" $BASE.toc.$TOC_VER.pub20.out &
sleep 5

#pgrep -P $$
pkill -P $$
ps -ef | grep script

