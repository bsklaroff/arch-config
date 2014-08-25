#!/bin/bash

state=$(acpi -b)
percent=$(echo $state | sed 's/^.* \([0-9]\+%\).*$/\1/')
if [[ $percent == '100%' ]]
then
  printf "AC 100%%"
else
  timestr=$(echo $state | sed 's/^.* 0*\([0-9]\+\):\([0-9]\+\).*$/\1h\2m/')
  timestr=$(echo $timestr | sed 's/^0h//')
  charging="Bat"
  if [[ $(echo $state | grep Discharging) == '' ]]
  then
    charging="AC"
  fi
  printf "%s %s (%s)" "$charging" "$percent" "$timestr"
fi
