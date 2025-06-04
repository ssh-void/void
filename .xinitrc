xset -dpms && xset s off &
xset s noblank &
xset fp rehash && xset r rate 225 75 &
xset mouse 5 1 &
echo "Xft.dpi: 107" | xrdb -merge &
while true; do numlockx on ; sleep 1 ; done &
while true; do sxhkd ; sleep 1 ; done &
st &
exec dbus-run-session dwm &
