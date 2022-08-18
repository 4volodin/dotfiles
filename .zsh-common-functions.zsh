# Custom plugin for zsh
#
# Common functions
#
# Author: Thomas Bendler <code@thbe.org>
# Date:   Wed Jan  1 23:54:03 CET 2020
#
#
# https://gist.githubusercontent.com/thbe/5612c721f2630debb1d991033e0ec932/raw/94166323de60a0025e0191bf5f670d3d7e7251b9/functions.plugin.zsh

### Command enhancement functions ###
.1() { cd ../ ; }                                  # Go back 1 directory level
.2() { cd ../../ ; }                               # Go back 2 directory levels
.3() { cd ../../../ ; }                            # Go back 3 directory levels
.4() { cd ../../../../ ; }                         # Go back 4 directory levels
.5() { cd ../../../../../ ; }                      # Go back 5 directory levels
.6() { cd ../../../../../../ ; }                   # Go back 6 directory levels
root() { sudo su - ; }                             # root:         Switch to root user using sudo
f() { open -a Finder ./ ; }                        # f:            Opens current directory in MacOS Finder
c() { clear ; }                                    # c:            Clear terminal display
path() { echo -e ${PATH//:/\\n} ; }                # path:         Echo all executable Paths
show_options() { shopt ; }                         # Show_options: display bash options settings
fix_stty() { stty sane ; }                         # fix_stty:     Restore terminal settings when screwed up
mount() { sudo mount | column -t ; }               # mount:        Human readable mount
fastping() { \ping -c 100 -s 1 "$@" ; }            # fastping:     Send 100 one byte packages plus header
cowdate() { LANG=C date | cowsay ; }               # cowdate:      Show date announced by cow


#-u in diff means: unified diff
#-R in less means: show raw escape codes (so we can see the colour)
#-F in less means: quit if entire output fits on one screen
function diff { colordiff -u "$@" | less -RF ; }

### Functions (network) ###
myip() { curl ip.appspot.com ; }                   # myip:         Public facing IP Address
netCons() { lsof -i ; }                            # netCons:      Show all open TCP/IP sockets
flushDNS() { dscacheutil -flushcache ; }           # flushDNS:     Flush out the DNS Cache
lsock() { sudo /usr/sbin/lsof -i -P ; }            # lsock:        Display open sockets
lsockU() { sudo /usr/sbin/lsof -nP | grep UDP ; }  # lsockU:       Display only open UDP sockets
lsockT() { sudo /usr/sbin/lsof -nP | grep TCP ; }  # lsockT:       Display only open TCP sockets
ipInfo0() { ipconfig getpacket en0 ; }             # ipInfo0:      Get info on connections for en0
ipInfo1() { ipconfig getpacket en1 ; }             # ipInfo1:      Get info on connections for en1
openPorts() { sudo lsof -i | grep LISTEN ; }       # openPorts:    All listening connections
showBlocked() { sudo ipfw list ; }                 # showBlocked:  All ipfw rules inc/ blocked IPs
httpHeaders() { /usr/bin/curl -I -L $@ ; }         # httpHeaders:  Grabs headers from web page
httpDebug() { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }
ipLocal() {
  for i in $(ifconfig -l); do
    case $i in
      (lo0) ;;
      (*)   set -- $(ifconfig $i | grep "inet [1-9]")
            if test $# -gt 1; then echo $i: $2; fi  ;;
    esac
  done
}

### Functions (system) ###
mountReadWrite() { /sbin/mount -uw / ; }
findPid() { lsof -t -c "$@" ; }
memHogsTop() { top -l 1 -o rsize | head -20 ; }
memHogsPs() { ps wwaxm -o pid,stat,vsize,rss,time,command | head -10 ; }
topForever() { top -l 9999999 -s 10 -o cpu ; }
ttop() { top -R -F -s 10 -o rsize ; }
cpu_hogs() { ps wwaxr -o pid,stat,%cpu,time,command | head -10 ; }
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }
ii() {
  echo -e "\nYou are logged on ${HOSTNAME}"
  echo -e "\nAdditionnal information:   " ; uname -a
  echo -e "\nUsers logged on:           " ; w -h
  echo -e "\nCurrent date:              " ; date
  echo -e "\nMachine stats:             " ; uptime
  echo -e "\nPublic facing IP Address:  " ; myip
  echo
}

### Functions (filemanagement) ###
dush() { du -sm * | sort -n | tail ; }
numFiles() { echo $(ls -1 | wc -l) ; }             # numFiles:     Count of non-hidden files in current dir
cleanupDS() { find . -type f -name '*.DS_Store' -ls -delete ; }
mcd() { mkdir -p "$1" && cd "$1" ; }               # mcd:          Makes new Dir and jumps inside
ql() { qlmanage -p "$*" >& /dev/null ; }           # ql:           Opens any file in MacOS Quicklook Preview
zipf() { zip -r "$1".zip "$1" ; }                  # zipf:         To create a ZIP archive of a folder
trash() { command mv "$@" ~/.Trash ; }             # trash:        Moves a file to the MacOS trash
spotlight() { mdfind "kMDItemDisplayName == '$@'wc" ; }
makefile_1mb() { mkfile 1m ./1MB.dat ; }           # makefile_1mb:      Creates a file of 1mb size (all zeros)
makefile_5mb() { mkfile 5m ./5MB.dat ; }           # makefile_5mb:      Creates a file of 5mb size (all zeros)
makefile_10mb() { mkfile 10m ./10MB.dat ; }        # makefile_10mb:     Creates a file of 10mbsize (all zeros)

#Downloads a .mp3 file
dlmp3 () { youtube-dl --extract-audio --audio-format mp3 $1 }
dlmp4 () { youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $1 }

