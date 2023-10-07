killall -q polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    if [[ $m == "DP-0" ]]; then
      export TRAY_POS=right
    fi
    MONITOR=$m polybar --reload top &
  done
else
  polybar --reload top &
fi
unset TRAY_POS
