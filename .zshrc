export TERM=xterm-256color
export EDITOR=nvim
export VISUAL=nvim
alias vim=nvim
alias rm="echo use: trash"
alias dotgit='git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME'
# /opt/homebrew/bin/python3.10 -m pip install black --break-system-packages
#
# Make sure python3 points to Homebrew python@3.14
unalias python3 2>/dev/null || true
# alias python3="/opt/homebrew/opt/python@3.14/bin/python3"
alias python3='/opt/homebrew/bin/python3'
alias pip3="/opt/homebrew/bin/python3/bin/pip3"

export PYTHONBREAKPOINT=ipdb.set_trace
export ZSH="$HOME/.oh-my-zsh"
export DOCKER_SCAN_SUGGEST=false
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
ZSH_THEME="robbyrussell"


plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf  # fuzzy file and dir finder with ctrl-t 
    git-prompt
    zsh-vi-mode
)
source $ZSH/oh-my-zsh.sh
# fuzzy file and dir finder with ctrl-t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh


# To activate completions for zsh you need to have bashcompinit enabled in zsh:
autoload -U bashcompinit
bashcompinit
# export PATH="$HOME/.poetry/bin:$PATH"
# Created by `pipx` on 2022-12-20 23:26:31
# export PATH="$PATH:/Users/borisdev/.local/bin"
# languagetool to check grammar in markdown files using neovim
export PATH="$PATH:$HOME/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar"
alias languagetool="java -jar $HOME/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar"

# this has to be below something above to work
# alias ls='ls -aGFhl'
# alias ls='ls -GFhl'
alias ls='lsd -alh' 


# stuff like sound alerts, and list images files using the actual images
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Ensure Homebrew paths take priority (no conda interference)
export PATH="/opt/homebrew/bin:$PATH"

# Force use of Homebrew uv (not miniforge remnants)
alias uv="/opt/homebrew/bin/uv"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH=/Library/TeX/texbin:$PATH
export PATH=/Library/TeX/texbin:$PATH

export PATH=/Library/TeX/texbin:$PATH
# export ANTHROPIC_API_KEY="$(cat ~/ANTHROPIC_API_KEY)"
    export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
    [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
