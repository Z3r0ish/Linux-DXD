if type "xrandr">/dev/null; then
	echo "Lanching polybar for each screen"
	xrandr --listactivemonitors | grep -oP '(HDMI\-\d+$|eDP\-\d+$)' | xargs -P1 -I{} bash -c "MONITOR={} polybar -q -r tray & MONITOR={} polybar -q -r switcher &"
fi
