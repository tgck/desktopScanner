#!/bin/bash

ADDRESS="127.0.0.1"
PORT="1234"
TAG="/foo/message1"
TYPE=""

function usage() {
    echo "  Usage: echo some_message | ${0} " 
    echo "    or : ${0} << (here document) "
    exit
}

while read l ; do
  args=$l;
  #declare -p args

  for i in $args
  do
    if [[ $i =~ ^[0-9]+$ ]] ; then 
      TYPE=${TYPE}i
    elif [[ $i =~ ^[0-9]+\.[0-9]+$ ]] ; then
      TYPE=${TYPE}f
    elif [[ $i =~ [a-zA-Z] ]] ; then
      TYPE=${TYPE}s
    fi
  done
  echo oscsend $ADDRESS $PORT $TAG $TYPE $l | sh;
  #echo oscsend $ADDRESS $PORT $TAG $TYPE $l;
done;
