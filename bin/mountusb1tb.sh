#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title usb1tb
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🗄

tell application "Finder"
    try
        mount volume "smb://a.volodin@10.10.0.3/usbshare1"
    end try
end tell


