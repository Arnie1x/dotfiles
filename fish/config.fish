if status is-interactive
    # Commands to run in interactive sessions can go here
    # Starship Init
    starship init fish | source

    # Pyenv Init
    pyenv init - fish | source

    # fuck
    thefuck --alias | source
end

set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x SHELL /usr/bin/fish

# Use bat for man pages
set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -xU MANROFFOPT "-c"

## Export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

## Advanced command-not-found hook (Disabled in favor of using the `fuck` package)
# source /usr/share/doc/find-the-command/ftc.fish askfirst

# Aliases

# Replace ls with eza
alias ls 'eza -al --color=always --total-size --group-directories-first --icons' # preferred listing
alias la 'eza -a --color=always --total-size --group-directories-first --icons'  # all files and dirs
alias ll 'eza -l --color=always --total-size --group-directories-first --icons'  # long format
alias lt 'eza -aT --color=always --group-directories-first --icons' # tree listing
alias l. 'eza -ald --color=always --total-size --group-directories-first --icons .*' # show only dotfiles

# Replace cat with bat
alias cat 'bat --style="plain" --decorations=always --color=always'

# Common use
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias big 'expac -H M "%m\t%n" | sort -h | nl'     # Sort installed packages according to size in MB (expac must be installed)
alias dir 'dir --color=auto'
alias fixpacman 'sudo rm /var/lib/pacman/db.lck'
alias gitpkg 'pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias grep 'ugrep --color=auto'
alias egrep 'ugrep -E --color=auto'
alias fgrep 'ugrep -F --color=auto'
alias grubup 'sudo update-grub'
alias hw 'hwinfo --short'                          # Hardware Info
alias ip 'ip -color'
alias psmem 'ps auxf | sort -nr -k 4'
alias psmem10 'ps auxf | sort -nr -k 4 | head -10'
alias rmpkg 'sudo pacman -Rdd'
alias tarnow 'tar -acf '
alias untar 'tar -zxvf '
alias vdir 'vdir --color=auto'
alias wget 'wget -c '

# Get fastest mirrors
alias mirror 'sudo reflector -f 30 -l 30 --number 10 --protocol https --verbose --save /etc/pacman.d/mirrorlist'
alias mirrora 'sudo reflector --latest 50 --number 20 --protocol https --sort age --save /etc/pacman.d/mirrorlist'
alias mirrord 'sudo reflector --latest 50 --number 20 --protocol https --sort delay --save /etc/pacman.d/mirrorlist'
alias mirrors 'sudo reflector --latest 50 --number 20 --protocol https --sort score --save /etc/pacman.d/mirrorlist'

# fastfetch
alias ff 'fastfetch'

# Brightnessctl aliases
alias b 'brightnessctl'
alias bup 'brightnessctl set +10%'
alias bdown 'brightnessctl set 10%-'

# pnpm
alias pn pnpm
set -gx PNPM_HOME "/home/arnie/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Android Tools
set -gx ANDROID_HOME "/home/arnie/Android/Sdk"
set -gx JAVA_HOME "/usr/lib/jvm/java-17-openjdk"
set -gx PATH $PATH /home/arnie/Android/Sdk/platform-tools/

# Flutter
set -gx FLUTTER_HOME "/opt/flutter"
set -gx PATH $PATH $FLUTTER_HOME/bin
set -gx CHROME_EXECUTABLE "/usr/bin/google-chrome-stable"

# SWWW
set -gx SWWW_TRANSITION_BEZIER ".54,0,.12,.98"

# clock-rs
alias clock 'clock-rs'

# niri share screen
alias share-screen 'niri msg action set-dynamic-cast-monitor'

# PyWal
cat ~/.cache/wal/sequences
clear
# source ~/.cache/wal/colors-tty.sh

fish_add_path /home/arnie/.spicetify
