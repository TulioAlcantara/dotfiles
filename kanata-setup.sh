#!/usr/bin/env bash
#
# kanata-setup.sh — install & load the Karabiner driver LaunchDaemon (root,
# system-wide) and the kanata LaunchAgent (per-user session) on macOS. Run
# AFTER setup.sh has placed configs in ~/.config/kanata.
#
# Why a LaunchAgent (not a LaunchDaemon) for kanata: macOS's TCC can only
# grant Input Monitoring / Accessibility to a process attributed to a real
# login session (an "audit session id"). A system LaunchDaemon spawned at
# boot has no such session and gets stuck at "Unknown"/denied forever, no
# matter what the toggle in System Settings shows. kanata also needs root to
# reach the Karabiner virtual-HID daemon's socket. The combination that
# works is: run as root, but as a child of a process inside the user's GUI
# session — i.e. a LaunchAgent that execs `sudo kanata`, backed by a scoped
# passwordless-sudo rule for that exact binary+args.
#
# Prerequisites (see README "Keyboard — kanata"):
#   - brew install kanata
#   - Karabiner-DriverKit-VirtualHIDDevice v6.2.0 installed & activated
#
set -e

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "kanata-setup.sh is macOS only — skipping."
  exit 0
fi

SRC="$HOME/.config/kanata"

echo "Installing org.pqrs.karabiner-vhid-daemon.plist (system LaunchDaemon) ..."
sudo cp "$SRC/org.pqrs.karabiner-vhid-daemon.plist" /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/org.pqrs.karabiner-vhid-daemon.plist
sudo chmod 644 /Library/LaunchDaemons/org.pqrs.karabiner-vhid-daemon.plist
sudo launchctl bootout system/org.pqrs.karabiner-vhid-daemon 2>/dev/null || true
sudo launchctl bootstrap system /Library/LaunchDaemons/org.pqrs.karabiner-vhid-daemon.plist

echo "Installing kanata-sudoers (passwordless sudo, scoped to the kanata binary) ..."
visudo -cf "$SRC/kanata-sudoers"
sudo install -m 0440 -o root -g wheel "$SRC/kanata-sudoers" /etc/sudoers.d/kanata

echo "Installing com.kanata.agent.plist (per-user LaunchAgent) ..."
mkdir -p "$HOME/Library/LaunchAgents"
cp "$SRC/com.kanata.agent.plist" "$HOME/Library/LaunchAgents/"
launchctl bootout "gui/$(id -u)/com.kanata.agent" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.kanata.agent.plist"
launchctl kickstart -k "gui/$(id -u)/com.kanata.agent"

echo
echo "Loaded:"
launchctl print "system/org.pqrs.karabiner-vhid-daemon" >/dev/null 2>&1 && echo "  org.pqrs.karabiner-vhid-daemon: running"
launchctl print "gui/$(id -u)/com.kanata.agent" >/dev/null 2>&1 && echo "  com.kanata.agent: running"
echo
echo "Done. Check ~/Library/Logs/kanata.log for 'keyboard grabbed, entering"
echo "event processing loop' and no Input Monitoring errors."
echo
echo "If it's still stuck asking for Input Monitoring: open System Settings ->"
echo "Privacy & Security -> Input Monitoring, remove any existing kanata entry"
echo "with '-', then kickstart again so it re-registers fresh:"
echo "  sudo launchctl kickstart -k system/org.pqrs.karabiner-vhid-daemon"
echo "  launchctl kickstart -k gui/\$(id -u)/com.kanata.agent"
