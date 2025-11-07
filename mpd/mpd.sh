#!/usr/bin/env bash
set -euo pipefail

MPDSCRIBBLE_CONF="${HOME}/.config/mpd/mpdscribble.conf"
MUSIC_DIR="${HOME}/Music"

PROCS=(mpd mpdscribble mpd-notification mpd-mpris)

start() {
    echo "Starting mpd and related apps..."
    if ! pgrep -x mpd >/dev/null; then
        setsid mpd >/dev/null 2>&1 || mpd >/dev/null 2>&1 &
        sleep 2
    fi

    if command -v mpdscribble >/dev/null; then
        setsid mpdscribble --conf "$MPDSCRIBBLE_CONF" >/dev/null 2>&1 &
    fi

    if command -v mpd-notification >/dev/null; then
        setsid mpd-notification -m "$MUSIC_DIR" >/dev/null 2>&1 &
    fi

    if command -v mpd-mpris >/dev/null; then
        setsid mpd-mpris >/dev/null 2>&1 &
    fi
    echo "Started."
}

stop() {
    echo "Stopping mpd and related apps..."
    # Pause the music playback before stopping mpd
    rmpc pause || true

    for p in "${PROCS[@]}"; do
        if pgrep -x "$p" >/dev/null; then
            pkill -TERM -x "$p" || true
        fi
    done

    sleep 0.5

    for p in "${PROCS[@]}"; do
        if pgrep -x "$p" >/dev/null; then
            pkill -KILL -x "$p" || true
        fi
    done
    echo "Stopped."
}

if pgrep -x mpd >/dev/null; then
    notify-send "Restarting mpd..." "Restarting the MPD Daemon and related applications."
    stop
    start
else
    start
fi

exit 0