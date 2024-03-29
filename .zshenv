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
export XDG_DATA_DIRS="$XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

#
# XDG user directories
#

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

#
# ZSH
#

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/compdump"

#
# Defaults
#

export EDITOR="nvim"
export PAGER="less"
export TERMINAL="kitty"
export VISUAL="nvim"

# Ensure that a non-login, non-interactive shell has a environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s ".zprofile" ]]; then
  source ".zprofile"
fi
