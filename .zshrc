alias vim=nvim
alias python=python3
alias pip=pip3
alias rm="echo use: trash"

export PYTHONBREAKPOINT=ipdb.set_trace
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
    git 
)
source $ZSH/oh-my-zsh.sh

# POWERLEVEL9K_MODE="git"


if [[ "$(uname)" == "Linux" ]]; then
  echo "Running on Linux"
  # PS1='linux$(__git_ps1 "(%s)") > '
  # unset PS1
  export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
    plugins=(
        git
    )
    alias ls="ls -aGFhl --color"
fi



#### ONLY FOR MAC LAPTOP ####
if [[ $(uname) == "Darwin" ]]; then
  echo "This command will only run on macOS"
    export DOCKER_SCAN_SUGGEST=false
    alias dotgit='git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME'

    plugins=(
        jsontools
        zsh-syntax-highlighting
        zsh-autosuggestions
        copybuffer
        git 
        fzf
        zsh_codex
    )
    bindkey '^X' create_completion
    source $ZSH/oh-my-zsh.sh
    alias ls='ls -aGFhl'

    ## oh-my-zsh plugins that require git clone installation
    # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

    # To activate completions for zsh you need to have bashcompinit enabled in zsh:
    autoload -U bashcompinit
    bashcompinit


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
    #
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
