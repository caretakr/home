#
# ZSH environment
#

#
# XDG base directories
#

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_DIRS="$XDG_DATA_HOME/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

#
# XDG user directories
#

export XDG_DESKTOP_HOME="$HOME/Desktop"
export XDG_DOWNLOADS_HOME="$HOME/Downloads"
export XDG_TEMPLATES_HOME="$HOME/Templates"
export XDG_PUBLIC_HOME="$HOME/Public"
export XDG_DOCUMENTS_HOME="$HOME/Documents"
export XDG_MUSIC_HOME="$HOME/Music"
export XDG_PICTURES_HOME="$HOME/Pictures"
export XDG_VIDEOS_HOME="$HOME/Videos"

#
# ZSH
#

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/compdump"

#
# Defaults
#

export EDITOR="vim"
export PAGER="less"
export TERMINAL="kitty"
export VISUAL="vim"

# Ensure that a non-login, non-interactive shell has a environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s ".zprofile" ]]; then
    source ".zprofile"
fi
