#!/bin/bash

STATE_FILE="$HOME/.cache/battery_saver_state"
BRIGHTNESS_FILE="$HOME/.cache/saved_brightness"

DISPLAY_NAME="eDP-1"
RES_60="1920x1080@60"
RES_144="1920x1080@144"

# If the state file doesn't exist or says "off", turn the saver ON
if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" = "off" ]; then

  brightnessctl get >"$BRIGHTNESS_FILE"
  brightnessctl set 15%
  rfkill block bluetooth

  # Drop to 60Hz
  kscreen-doctor output.$DISPLAY_NAME.mode.$RES_60

  echo "on" >"$STATE_FILE"
  notify-send -i battery-040 "Battery Saver: ON" "Display dimmed (60Hz) and radios blocked."
  echo "🔋 Battery Saver enabled (60Hz)."

# Otherwise, turn the saver OFF
else

  if [ -f "$BRIGHTNESS_FILE" ]; then
    brightnessctl set "$(cat "$BRIGHTNESS_FILE")"
  else
    brightnessctl set 50%
  fi
  rfkill unblock bluetooth

  # Restore to 144Hz
  kscreen-doctor output.$DISPLAY_NAME.mode.$RES_144

  echo "off" >"$STATE_FILE"
  notify-send -i battery-100 "Battery Saver: OFF" "Normal hardware state (144Hz) restored."
  echo "⚡ Battery Saver disabled (144Hz)."
fi
