#!/bin/sh

port=$1

exec socat pty,link=/run/radio/pty$port,raw,echo=0 pty,link=/run/radio/kiss$port,raw,echo=0
