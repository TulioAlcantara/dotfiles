#!/usr/bin/env bash
#
# kanata-setup.sh — install & load the kanata + Karabiner driver LaunchDaemons
# (macOS only). Run AFTER setup.sh has placed configs in ~/.config/kanata.
#
# Prerequisites (see README "Keyboard — kanata"):
#   - brew install kanata
#   - Karabiner-DriverKit-VirtualHIDDevice v6.2.0 installed & activated
#   - kanata granted Input Monitoring permission
#
set -e

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "kanata-setup.sh is macOS only — skipping."
  exit 0
fi

SRC="$HOME/.config/kanata"
DEST="/Library/LaunchDaemons"
PLISTS=(org.pqrs.karabiner-vhid-daemon.plist com.kanata.daemon.plist)

for plist in "${PLISTS[@]}"; do
  echo "Installing $plist ..."
  sudo cp "$SRC/$plist" "$DEST/$plist"
  sudo chown root:wheel "$DEST/$plist"
  sudo chmod 644 "$DEST/$plist"

  label="${plist%.plist}"
  # Reload cleanly whether or not it's already loaded.
  sudo launchctl bootout "system/$label" 2>/dev/null || true
  sudo launchctl bootstrap system "$DEST/$plist"
done

echo
echo "Loaded daemons:"
sudo launchctl list | grep -E "kanata|pqrs" || true
echo
echo "Done. Check /var/log/kanata.log for 'driver connected: true' and no"
echo "'IOHIDDeviceOpen ... not permitted' errors. If you see those, grant"
echo "Input Monitoring to kanata (see README) and run:"
echo "  sudo launchctl kickstart -k system/com.kanata.daemon"
