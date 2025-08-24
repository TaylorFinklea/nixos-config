if [ $(brightnessctl get) \> 0 ] ; then brightnessctl set 0%; else brightnessctl set 100%; fi > /dev/null
