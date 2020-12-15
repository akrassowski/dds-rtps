#!/bin/bash
#
# exercise durability
#
source common.source

FLAGS="-d0 -b -r -t Shapes"
for PUB in "v" "l" "t" "p"; do
  for SUB in "v" "l" "t" "p"; do
    SDFLAGS="$FLAGS -D$SUB"
    PDFLAGS="$FLAGS -D$PUB"
    PAIR=${PUB}${SUB}

    script -qf -c "$TOC -S $SDFLAGS"        $BASE.toc.$TOC_VER.sub.$PAIR.out &
    script -qf -c "$RTI -P $PDFLAGS -c RED" $BASE.rti.$RTI_VER.pub.$PAIR.out &
    sleep 5
    #pgrep -P $$
    pkill -P $$
    ps -ef | grep script

    # flip roles
    script -qf -c "$RTI -S $SDFLAGS"        $BASE.rti.$RTI_VER.sub.$PAIR.out &
    script -qf -c "$TOC -P $PDFLAGS -c RED" $BASE.toc.$TOC_VER.pub.$PAIR.out &
    sleep 5
    #pgrep -P $$
    pkill -P $$
    ps -ef | grep script
  done
done

