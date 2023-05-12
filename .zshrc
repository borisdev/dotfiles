## TOP PART: FOR GITHUB CODE SPACES AND MY MAC LAPTOP ##
## BOTTOM PART: JUST MY MAC LAPTOP ##

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
#
plugins=(
    git 
)
# Learn about these plugins some other day...
#
#    fzf
#    web-search
#    zsh-syntax-highlighting
#    zsh-autosuggestions,
#    zsh-syntax-highlighting,
#    zsh-completions,
#
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Load AWS CREDENTIALS env variables
# zsh aws_credentials.sh
ZSH_THEME="robbyrussell"
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"



source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi


alias vi=nvim
alias vim=nvim
alias dotgit='git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME'
# alias ls='ls -GFh' # Colorize output, add file type indicator, and put sizes in human readable format
alias ls='ls -aGFhl' # Same as above, but in long listing format

# To activate completions for zsh you need to have bashcompinit enabled in zsh:
autoload -U bashcompinit
bashcompinit

alias python=python3
alias pip=pip3


## JUST FOR MY MAC LAPTOP ##

if [[ "$OSTYPE" == "darwin"* ]]; then

    export PATH="$HOME/.poetry/bin:$PATH"
    # Created by `pipx` on 2022-12-20 23:26:31
    export PATH="$PATH:/Users/borisdev/.local/bin"

    # no clue why this is needed
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda ...ENVS)

    # jekyll github pages -- https://jekyllrb.com/docs/installation/macos/
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-3.1.3

    # languagetool to check grammar in markdown files using neovim
    export PATH="$PATH:$HOME/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar"
    alias languagetool="java -jar $HOME/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar"

    # pyenv
    export PATH="$HOME/.pyenv/bin:$PATH"
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"

    # Enables auto-activiation of virtualenvs based on .python-version files right
    # when you cd into a directory
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/borisdev/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/borisdev/opt/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/borisdev/opt/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/borisdev/opt/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

fi
