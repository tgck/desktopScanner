#!/bin/bash

ADDRESS="127.0.0.1"
PORT="1234"
TAG="/foo/message1"
TYPE=""

# bash で正規表現
# 引数一個

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
