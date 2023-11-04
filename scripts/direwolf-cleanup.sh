#!/bin/sh

# Ensure we remove kiss pty symlink when the service stops
rm -f /tmp/kisstnc

# The ax0 interface often gets wedged during service restarts, which
# ultimately prevents direwolf from restarting properly. This is an
# ugly hack to reboot the Pi if direwolf fails to restart.
[ "$SERVICE_RESULT" = "timeout" ] && systemctl reboot
