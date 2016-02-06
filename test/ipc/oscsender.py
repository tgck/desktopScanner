#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Usage: echo "/path/to/file" | ./oscsender.py
# An oscsend (pyliblo) wrapper.
# echo で出力したメッセージをパイプで受けて送信する

import sys, liblo

message = sys.stdin.read()

target = liblo.Address(1234)
liblo.send(target, "/foo/message1", message)

