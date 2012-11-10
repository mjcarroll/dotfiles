xrdb -merge ~/.Xdefaults
xsetroot -solid black

xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Control_L"
xmodmap -e "add Control = Control_L"

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --transparent true --width 10 --tint 0x456030 --height 20 &

jupiter &
nautilus --no-desktop &

eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID
export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

if [ -x /usr/bin/nm-applet ]; then
    nm-applet --sm-disable &
fi

/usr/bin/xmonad
