#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$1"
LABELS=("browser" "dev" "cli" "comm" "org" "float" "free" "private" "vcs")
CONF_LABEL="conf"
BUILTIN_NAME="Built-in Retina Display"

builtin_uuid=$(jq -r --arg name "$BUILTIN_NAME" '.[] | select(.name == $name) | .uuid' "$STATE_FILE")
all_uuids=($(jq -r '.[].uuid' "$STATE_FILE"))
num_screens=${#all_uuids[@]}

echo "Found ${num_screens} screens:"
for uuid in "${all_uuids[@]}"; do
  echo " - $uuid"
done

# Get display index mapping
uuid_to_index=""
while IFS= read -r line; do
  uuid=$(echo "$line" | jq -r '.uuid')
  index=$(echo "$line" | jq -r '.index')
  if [[ "$uuid" == "$builtin_uuid" ]]; then
    builtin_index="$index"
  fi
  for u in "${all_uuids[@]}"; do
    if [[ "$uuid" == "$u" ]]; then
      last_match_index="$index"
    fi
  done
done < <(yabai -m query --displays | jq -c '.[]')

echo "Primary screen: index=${builtin_index}, uuid=${builtin_uuid}"

# Handle scenarios
if [[ "$num_screens" -eq 1 ]]; then
  for label in "${LABELS[@]}"; do
    echo "Moving space labeled ${label} to display ${last_match_index}"
    yabai -m space --label "$label" --display "$last_match_index" || true
  done

elif [[ "$num_screens" -eq 2 ]]; then
  # determine secondary index
  for uuid in "${all_uuids[@]}"; do
    if [[ "$uuid" != "$builtin_uuid" ]]; then
      secondary_uuid="$uuid"
    fi
  done

  secondary_index=$(yabai -m query --displays | jq -r --arg uuid "$secondary_uuid" '.[] | select(.uuid == $uuid) | .index')
  echo "Secondary screen: index=${secondary_index}, uuid=${secondary_uuid}"

  for label in "${LABELS[@]}"; do
    echo "Moving space labeled ${label} to display ${secondary_index}"
    yabai -m space --label "$label" --display "$secondary_index" || true
  done

  # Create conf space if it doesn't exist
  conf_exists=$(yabai -m query --spaces | jq -e '.[] | select(.label == "conf")' > /dev/null 2>&1 && echo yes || echo no)

  if [[ "$conf_exists" == "no" ]]; then
    yabai -m display --focus "$secondary_index"
    yabai -m space --create
    last_space=$(yabai -m query --spaces | jq '.[].index' | sort -n | tail -n1)
    yabai -m space "$last_space" --label "$CONF_LABEL"
  fi
else
  echo "Unsupported number of screens: $num_screens"
  exit 1
fi
