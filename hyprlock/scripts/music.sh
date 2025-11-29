#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 --title | --arturl | --artist | --length | --album | --status | --source"
    exit 1
fi

# Get list of active players and choose one by priority
get_preferred_player() {
    players_raw=$(playerctl -l 2>/dev/null)
    # remove empty lines
    players=$(printf "%s" "$players_raw" | sed '/^\s*$/d')

    if [ -z "$players" ]; then
        # no players available
        echo ""
        return
    fi

    # read into array
    IFS=$'\n' read -r -d '' -a player_arr <<< "${players}" || true

    # priority patterns (first match wins)
    priority=("spotify" "spotify_player")

    for pat in "${priority[@]}"; do
        for p in "${player_arr[@]}"; do
            if [[ "$p" == *"$pat"* ]]; then
                echo "$p"
                return
            fi
        done
    done

    # fallback to first player in list
    echo "${player_arr[0]}"
}

# selected player (may be empty)
PLAYER=$(get_preferred_player)

# helper to query metadata for the selected player
get_metadata() {
    key=$1
    if [ -z "$PLAYER" ]; then
        echo ""
        return
    fi
    playerctl -p "$PLAYER" metadata --format "{{ $key }}" 2>/dev/null
}

get_status() {
    if [ -z "$PLAYER" ]; then
        echo ""
        return
    fi
    playerctl -p "$PLAYER" status 2>/dev/null
}

get_source_info() {
    trackid=$(get_metadata "mpris:trackid")
    # prefer trackid clues, fallback to PLAYER name
    lookup="$trackid"
    if [ -z "$lookup" ]; then
        lookup="$PLAYER"
    fi

    if [[ "$lookup" == *"firefox"* ]]; then
        echo -e "Firefox 󰈹"
    elif [[ "$lookup" == *"spotify"* ]]; then
        echo -e "Spotify "
    elif [[ "$lookup" == *"chromium"* || "$lookup" == *"chrome"* ]]; then
        echo -e "Chrome "
    else
        echo ""
    fi
}

case "$1" in
--title)
    title=$(get_metadata "xesam:title")
    if [ -z "$title" ]; then
        echo ""
    else
        echo "${title:0:40}"
    fi
    ;;
--arturl)
    url=$(get_metadata "mpris:artUrl")
    if [ -z "$url" ]; then
        echo ""
    else
        if [[ "$url" == file://* ]]; then
            url=${url#file://}
        fi
        echo "$url"
    fi
    ;;
--artist)
    artist=$(get_metadata "xesam:artist")
    if [ -z "$artist" ]; then
        echo ""
    else
        echo "${artist:0:30}"
    fi
    ;;
--length)
    length=$(get_metadata "mpris:length")
    if [ -z "$length" ]; then
        echo ""
    else
        # length is in microseconds; convert to minutes with 2 decimal places
        # guard against non-numeric
        if [[ "$length" =~ ^[0-9]+$ ]]; then
            echo "$(echo "scale=2; $length / 1000000 / 60" | bc) m"
        else
            echo ""
        fi
    fi
    ;;
--status)
    status=$(get_status)
    if [[ $status == "Playing" ]]; then
        echo "󰎆"
    elif [[ $status == "Paused" ]]; then
        echo "󱑽"
    else
        echo ""
    fi
    ;;
--album)
    album=$(get_metadata "xesam:album")
    if [[ -n $album ]]; then
        echo "$album"
    else
        status=$(get_status)
        if [[ -n $status ]]; then
            echo "Not album"
        else
            echo ""
        fi
    fi
    ;;
--source)
    get_source_info
    ;;
*)
    echo "Invalid option: $1"
    echo "Usage: $0 --title | --arturl | --artist | --length | --album | --status | --source"
    exit 1
    ;;
esac
