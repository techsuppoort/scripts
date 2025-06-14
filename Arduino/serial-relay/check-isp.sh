#!/bin/sh
IP="192.168.1.1" #change this
PORT="56000" #change this as well
check_net() {
	if ping 8.8.8.8 -c 10 -q > /dev/null; then 
		return 0
	else
		return 1
	fi
}

toggle_relay() {
	#create socat vty
	( timeout 10 socat pty,link=/tmp/relay-terminal,raw,echo=0 TCP:${IP}:${PORT} )& 
	sleep 3
	echo off > /tmp/relay-terminal
}

if check_net; then
	exit 0
else
	toggle_relay
	sleep 300
fi
