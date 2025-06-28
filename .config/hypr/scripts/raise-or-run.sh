#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <program> <window_class>"
  exit 1
fi

PROGRAM="$1"
WINDOW_CLASS="$2"

WINDOWS=$(hyprctl -j clients)
WINDOW=$(echo "$WINDOWS" | jq --arg class "$WINDOW_CLASS" '.[] | select(.class | contains($class))')

if [ -n "$WINDOW" ]; then
  hyprctl dispatch focuswindow class:$WINDOW_CLASS
else
  "$PROGRAM" &
fi
