#!/usr/bin/env bash

if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo "Usage: $0 <program> <window_class>"
  exit 1
fi

PROGRAM=$1
WINDOW_CLASS=$2

WINDOWS=$(hyprctl -j clients)

ACTIVE_WINDOW=$(hyprctl activewindow -j)
ACTIVE_WINDOW_CLASS=$(echo $ACTIVE_WINDOW | jq -r '.class')
ACTIVE_WINDOW_ADDRESS=$(echo $ACTIVE_WINDOW | jq -r '.address')

# If we're already in a window of the program to switch to, then switch to its next window
if [[ $ACTIVE_WINDOW_CLASS == $WINDOW_CLASS ]]; then
  NEXT_WINDOW_ADDRESS=$(
    echo $WINDOWS |
      jq --raw-output --arg class $WINDOW_CLASS --arg address $ACTIVE_WINDOW_ADDRESS \
        'map(
          select(.class == $class and .address != $address)
        ) | sort_by(.focusHistoryID) | .[0] | .address'
  )

  if [[ -n $NEXT_WINDOW_ADDRESS ]] && [[ $NEXT_WINDOW_ADDRESS != "null" ]]; then
    hyprctl dispatch focuswindow address:$NEXT_WINDOW_ADDRESS
  fi

  exit
fi

WINDOW_ADDRESS=$(echo $WINDOWS | jq --raw-output --arg class $WINDOW_CLASS \
  'map(select(.class | contains($class))) | sort_by(.focusHistoryID) | .[0] | .address')
if [[ -n $WINDOW_ADDRESS ]] && [[ $WINDOW_ADDRESS != "null" ]]; then
  hyprctl dispatch focuswindow address:$WINDOW_ADDRESS
else
  $PROGRAM &
fi
