#!/usr/bin/env bash
#
# twitch-chat.sh
# Launch Twitch popout chat as a standalone Chromium app window.
#
# Prereq:
#   sudo apt install chromium
#
# Usage:
#   ./twitch-chat.sh                 # uses DEFAULT_CHANNEL below
#   ./twitch-chat.sh your_channel    # explicit channel
#
# After launch: right-click the chat window -> More Actions -> Keep Above Others.
 
DEFAULT_CHANNEL="your_channel_name"
CHANNEL="${1:-$DEFAULT_CHANNEL}"
 
chromium \
    --app="https://www.twitch.tv/popout/${CHANNEL}/chat" \
    --window-size=420,700 \
    --window-position=1480,80 &
 
