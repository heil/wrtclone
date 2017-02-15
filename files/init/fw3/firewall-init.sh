#!/bin/bash

LOAD_INIT="ipt_rpfilter iptable_filter iptable_mangle iptable_nat iptable_raw iptable_security"
LOAD_PATH=/lib/modules/$(uname -r)/./kernel/net/ipv4/netfilter

echo "LOADING Core Modules"
for mod in $LOAD_INIT; do echo "Loading $mod"; modprobe $mod; done
sleep 1
echo "LOADING ADDON Modules"

pushd  $LOAD_PATH >/dev/null
ls | grep -v nft | while read line; do mod=`basename $line .ko`; echo "Loading $mod"; modprobe $mod; done
popd >/dev/null
