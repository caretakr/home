#
# ZSH config
#

# Create cache directory if not exists
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Create data directory if not exists
[[ -d "$XDG_DATA_HOME/zsh" ]] || mkdir -p "$XDG_DATA_HOME/zsh"

# Remove extra space on right side
ZLE_RPROMPT_INDENT=0

#
# History
#

HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE="999999999"
SAVEHIST="$HISTSIZE"

# ISO 8601 timestamp format
HIST_STAMPS="%Y-%m-%dT%H:%M:%S.%f%z"

# Append into history as soon as possible
setopt INC_APPEND_HISTORY

# Expand history with timestamp
setopt EXTENDED_HISTORY

# Ignore dups on history
setopt HIST_IGNORE_DUPS

#
# Oh My ZSH
#

export ZSH="$HOME/.oh-my-zsh"

# Prevent automatic update
zstyle ':omz:update' mode disabled

ZSH_CUSTOM="$HOME/.zsh"
ZSH_THEME="romkatv/powerlevel10k/powerlevel10k"

plugins=(
  git
  gpg-agent
  sudo
)

[[ ! -r "$ZSH/oh-my-zsh.sh" ]] || source "$ZSH/oh-my-zsh.sh"

#
# Rust
#

# Add to PATH
export PATH="$PATH:$HOME/.cargo/bin"

#
# Node
#

# Load Node Version Manager
[[ ! -r /usr/share/nvm/init-nvm.sh ]] || source /usr/share/nvm/init-nvm.sh

#
# Android
#

export ANDROID_HOME="$HOME/.android/sdk"

# Add to PATH
export PATH="$PATH:$ANDROID_HOME/platform-tools"

#
# Aliases
#

alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias rm="trash"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load alias reminder after alias if ex
[[ ! -r "$ZSH_CUSTOM/plugins/MichaelAquilina/zsh-you-should-use/you-should-use.plugin.zsh" ]] \
    || source "$ZSH_CUSTOM/plugins/MichaelAquilina/zsh-you-should-use/you-should-use.plugin.zsh"

# Load autosuggestions plugin
[[ ! -r "$ZSH_CUSTOM/plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
    || source "$ZSH_CUSTOM/plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Load syntax highlight plugin at end of everything
[[ ! -r "$ZSH_CUSTOM/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
    || source "$ZSH_CUSTOM/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Load history substring search plugin after syntax highlight
[[ ! -r "$ZSH_CUSTOM/plugins/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh" ]] \
    || source "$ZSH_CUSTOM/plugins/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
