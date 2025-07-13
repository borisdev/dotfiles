alias vim=nvim
alias python=/opt/homebrew/bin/python3.13
alias python3=/opt/homebrew/bin/python3.13
alias rm="echo use: trash"
alias dotgit='git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME'
# /opt/homebrew/bin/python3.10 -m pip install black --break-system-packages

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
    zsh_codex
    git-prompt
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

# jekyll github pages -- https://jekyllrb.com/docs/installation/macos/
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3


# this has to be below something above to work
# alias ls='ls -aGFhl'
# alias ls='ls -GFhl'
alias ls='lsd -alh' 

# >>> conda initialize >>> (DISABLED)
# Conda/miniforge disabled to prevent Python version conflicts
# Use Homebrew Python and Poetry/uv for package management
# <<< conda initialize <<<



# stuff like sound alerts, and list images files using the actual images
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
alias pip="python3.13 -m pip"
alias pip3="python3.13 -m pip"

# Ensure Homebrew paths take priority (no conda interference)
export PATH="/opt/homebrew/bin:$PATH"

# Force use of Homebrew uv (not miniforge remnants)
alias uv="/opt/homebrew/bin/uv"
