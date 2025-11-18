#!/usr/bin/env bash
# polybar-battery-acpi.sh
# Requires: acpi, notify-send (optional)


# Configuration (edit if you want)
BATTERY_INDEX=0 # 0 means Battery 0; if you have more than one, change or iterate.
UPDATE_INTERVAL=30 # (seconds) used by polybar's interval, not by this script directly
CRITICAL=8 # <= CRITICAL -> urgent (notification)
LOW=20 # <= LOW -> low color


# Icons (font: powerline/nerd-fonts recommended; fallbacks are ascii)
ICON_CHARGING="" # bolt
ICON_FULL="" # full
ICON_75=""
ICON_50=""
ICON_25=""
ICON_EMPTY=""
ICON_UNKNOWN="⚡"


# Colors (hex)
COLOR_NORMAL="#98c379"
COLOR_LOW="#E5C07B"
COLOR_CRIT="#FF6B6B"
COLOR_CHARGE="#61AFEF"


# persistent guard for single notify
STATE_FILE="/tmp/polybar_battery_last_warn"


# parse acpi
raw=$(acpi -b 2>/dev/null) || raw=""
if [[ -z "$raw" ]]; then
echo "%{F$COLOR_CRIT}No battery%{F-}"
exit 0
fi


# take first battery line
line=$(echo "$raw" | head -n1)
# sample line: "Battery 0: Discharging, 54%, 01:23:45 remaining"
# extract state (Charging/Discharging/Full/Unknown)
state=$(echo "$line" | awk -F": " '{print $2}' | awk -F"," '{print $1}' | tr -d '[:space:]')
# extract percentage
percent=$(echo "$line" | grep -oP '\d+(?=%)')
# extract time (if any)
time_str=$(echo "$line" | awk -F", " '{print $3}')
if [[ "$time_str" == "" ]]; then
time_str=""
fi


# choose icon by percentage
icon=$ICON_UNKNOWN
if [[ "$state" =~ "Charging" ]]; then
icon=$ICON_CHARGING
elif [[ "$state" =~ "Full" ]]; then
icon=$ICON_FULL
else
if (( percent >= 75 )); then icon=$ICON_FULL
elif (( percent >= 50 )); then icon=$ICON_75
elif (( percent >= 25 )); then icon=$ICON_50
elif (( percent > 0 )); then icon=$ICON_25
else icon=$ICON_EMPTY
fi
fi


# choose color
color=$COLOR_NORMAL
if [[ "$state" =~ "Charging" ]]; then
color=$COLOR_CHARGE
elif (( percent <= CRITICAL )); then
color=$COLOR_CRIT
elif (( percent <= LOW )); then
color=$COLOR_LOW
fi


# build output for polybar (use polybar's formatting tags)
# build output for polybar (use polybar's formatting tags)
# example output: %{F#61AFEF} 87% %{F-}01:12
if [[ -n "$time_str" && "$time_str" != "" ]]; then
    # shorten time like 01:23:45 remaining -> 01:23
    short_time=$(echo "$time_str" | grep -oP '\d{1,2}:\d{2}' | head -n1)
    printf "%%{F%s}%s %s%%%% %%{F-}%s\n" "$color" "$icon" "$percent" "$short_time"
else
    printf "%%{F%s}%s %s%%%% %%{F-}\n" "$color" "$icon" "$percent"
fi
# example output: %{F#61AFEF} 87% %{F-}01:12
