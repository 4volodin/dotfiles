#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title dark
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌒︎

log "Dark Mode enabled"

tell application "System Events" to tell appearance preferences to set dark mode to dark mode
do shell script "/Users/voale/bin/theme dark"
