#!/bin/sh

# .xinitrc
# dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

#extend
# xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 -r 120.00 --rotate normal --output DP-3 --mode 1920x1080 --left-of eDP-1 -r 75.00 --rotate normal
# xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 -r 120.00 --rotate normal --output DP-3 --mode 1920x1080 --right-of eDP-1 -r 75.00 --rotate normal
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 -r 120.00 --rotate normal --output DP-2 --left-of eDP-1 -r 75.00 --rotate normal

#mirror
# xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 -r 120.00 --rotate normal --output DP-3 --mode 1920x1080 --same-as eDP-1 -r 60.00 --rotate normal
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

export QT_QPA_PLATFORMTHEME="qt5ct"
xrdb $HOME/.Xresources
xsetroot -cursor_name left_ptr
xsetroot -solid '#80a0af'
# if we have private ssh key(s), start ssh-agent and add the key(s)
id1=$HOME/.ssh/identity
id2=$HOME/.ssh/id_dsa
xinput set-prop 10 "libinput Tapping Enabled" 1
xinput set-prop 10 "libinput Natural Scrolling Enabled" 1
id3=$HOME/.ssh/id_rsa
if [ -x /usr/bin/ssh-agent ] && [ -f $id1 -o -f $id2 -o -f $id3 ];
then
	eval `ssh-agent -s`
	ssh-add < /dev/null
fi

xset fp+ /usr/local/lib/X11/fonts/terminus
xset fp+ /usr/local/lib/X11/fonts/ghostscript
xset fp+ /usr/X11R6/lib/X11/fonts/TTF/

# xset fp rehash

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# launch the external 60 second clock, and launch the workspace status bar
FG='#a8a3f7'
BG='#3f3c6d'


# xrautolock -time 2 -locker slock -detectsleep &

# xmonad &
# setxkbmap us -variant colemak_dh
exec leftwm
