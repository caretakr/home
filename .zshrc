#
# ZSH config
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Create cache directory if not exists
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Create data directory if not exists
[[ -d "$XDG_DATA_HOME/zsh" ]] || mkdir -p "$XDG_DATA_HOME/zsh"

# Initialize completions
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"

#
# Sources
#

# Oh My ZSH plugins
source "$XDG_CONFIG_HOME/zsh/plugins/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/ohmyzsh/ohmyzsh/plugins/gpg-agent/gpg-agent.plugin.zsh"
source "$XDG_CONFIG_HOME/zsh/plugins/ohmyzsh/ohmyzsh/plugins/sudo/sudo.plugin.zsh"

# Autosuggestions plugin
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Powerlevel10k theme
source "$XDG_CONFIG_HOME/zsh/plugins/romkatv/powerlevel10k/powerlevel10k.zsh-theme"

# Node Version Manager
[[ ! -r /usr/share/nvm/init-nvm.sh ]] || source /usr/share/nvm/init-nvm.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#
# Keybinds
#

# Reset to GNU Emacs-like standard 
bindkey -e

# Bind history substring search plugin keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#
# Customization
#

# Remove extra space on right side
ZLE_RPROMPT_INDENT=0

# Set history
HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE="9999"
SAVEHIST="$HISTSIZE"

# Append into history as soon as possible
setopt INC_APPEND_HISTORY

# Ignore dups on history
setopt HIST_IGNORE_DUPS

#
# Paths
#

# Set Android SDK
export ANDROID_PATH="$HOME/.sdk/Google/Android"

# Add Android SDK to PATH
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Add Flutter SDK to PATH
export PATH="$PATH:$HOME/.sdk/Google/Flutter/bin"

# Add Cargo to PATH
export PATH="$PATH:$HOME/.cargo/bin"

#
# Aliases
#

alias v="vim"
alias vi="vim"
alias rm="trash"

# Source alias reminder after alias
source "$XDG_CONFIG_HOME/zsh/plugins/MichaelAquilina/zsh-you-should-use/you-should-use.plugin.zsh"

# Source syntax highlight plugin at end of everything
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Source history substring search plugin after syntax highlight
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh"
