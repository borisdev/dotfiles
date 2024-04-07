alias vim=nvim
alias python=/opt/homebrew/bin/python3.10
alias python3=/opt/homebrew/bin/python3.10
### /opt/homebrew/bin/python3.10 -m pip install black --break-system-packages
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

    # jekyll github pages -- https://jekyllrb.com/docs/installation/macos/
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-3.1.3

    # languagetool to check grammar in markdown files using neovim
    export PATH="$PATH:$HOME/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar"
    alias languagetool="java -jar $HOME/workspace/languagetool/languagetool-standalone/target/LanguageTool-6.1-SNAPSHOT/LanguageTool-6.1-SNAPSHOT/languagetool-commandline.jar"

    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
