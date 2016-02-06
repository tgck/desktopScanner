#!/bin/bash

ADDRESS="127.0.0.1"
PORT="1234"
TAG="/foo/message1"

function usage() {
    echo "  Usage: echo message | ${0} " 
    echo "    or : ${0} << (here document) "
    exit
}

#if [ $# -ne 0 ] ; then  
#  usage;
#else
  while read l ; do
    echo oscsend $ADDRESS $PORT $TAG $l | sh;
  done;
#fi
