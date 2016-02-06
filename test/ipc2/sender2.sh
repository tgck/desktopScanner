#!/bin/bash

ADDRESS="127.0.0.1"
PORT="1234"
TAG="/foo/message1"
TYPE=""

# bash $B$G@55,I=8=(B
# $B0z?t0l8D(B

function usage() {
    echo "  Usage: echo message | ${0} " 
    echo "    or : ${0} << (here document) "
    exit
}

while read l ; do
  if [[ $l =~ ^[0-9]+$ ]] ; then 
    TYPE=i
  elif [[ $l =~ ^[0-9]+\.[0-9]+$ ]] ; then
    TYPE=f
  elif [[ $l =~ [a-zA-Z] ]] ; then
    TYPE=s
  fi
  #echo oscsend $ADDRESS $PORT $TAG $l | sh;
  echo oscsend $ADDRESS $PORT $TAG $TYPE $l;
done;
