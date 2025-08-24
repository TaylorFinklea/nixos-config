#!/usr/bin/env bash

function main(){
  STATUS=""

  ETHERNET=$(nmcli --get-values GENERAL.DEVICE,GENERAL.TYPE device show | grep -B 1  "ethernet" | head -1)
  if [[ $ETHERNET ]]; then
  if [[ $(ip link show $ETHERNET | grep -E "state UP") ]]; then
      STATUS+='󰈀 '
      STATUS+="$(ip -4 -o address show dev $ETHERNET | awk '{print $4}') "
      STATUS+=" "
      STATUS+=" "
    fi
  fi

  WIFI=$(nmcli --get-values GENERAL.DEVICE,GENERAL.TYPE device show | grep -B 1  "wifi" | head -1)
  if [[ $WIFI ]]; then
    if [[ $(ip link show $WIFI | grep -E "state UP") ]]; then
      STATUS+='󰖩 '
      STATUS+="$(ip -4 -o address show dev $WIFI | awk '{print $4}') "
      STATUS+=" "
      STATUS+=" "
    fi
  fi

  WAN=$(curl -s ifconfig.me)
  if [[ $WAN ]]; then
    STATUS+='󰖈 '
    STATUS+="$(echo $WAN)"
  fi

  class=network
  echo -e "{\"text\":\""$STATUS"\", \"class\":\""$class"\"}"
}

main
