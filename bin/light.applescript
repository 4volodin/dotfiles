#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title light
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💡

log "Light Mode enabled"

tell application "System Events" to tell appearance preferences to set dark mode to not dark mode
do shell script "/Users/voale/bin/theme light"
