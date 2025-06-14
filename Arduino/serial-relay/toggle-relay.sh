#!/bin/sh
IP="192.168.1.1" #change this
PORT="56000" #change this as well
#create socat vty
( timeout 10 socat pty,link=/tmp/relay-terminal,raw,echo=0 TCP:${IP}:${PORT} )&
sleep 3
echo off > /tmp/relay-terminal
