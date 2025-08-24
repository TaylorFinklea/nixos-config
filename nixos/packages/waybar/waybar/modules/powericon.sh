#!/usr/bin/env bash

me=`whoami`
me_name=`getent passwd ${me} | cut -d ':' -f 5 | cut -d ',' -f 1`
icon=""
class=powermenu

echo -e "{\"text\":\""$icon"\", \"class\":\""$class"\"}"
