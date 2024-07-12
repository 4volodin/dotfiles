#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title nas
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🗄

tell application "Finder"
    try
        mount volume "smb://voale@10.100.1.2/backup"
        mount volume "smb://voale@10.100.1.2/users"
        mount volume "smb://voale@10.100.1.2/media"
        mount volume "smb://voale@10.100.1.2/Backend"
        mount volume "smb://voale@10.100.1.2/Frontend"
#       mount volume "smb://voale@10.100.1.2/timemachine"
#       mount volume "https://voale@cloudd.truedev.ru/remote.php/dav/files/voale/"
        mount volume "smb://a.volodin@10.10.0.3/usbshare1"
    end try
end tell


