export TERM=xterm-256color

# ==============================================================================
# UV .env FILE AUTO-DISCOVERY
# ==============================================================================
# Problem: Hard-coding UV_ENV_FILE to a specific repo breaks when working in
#          multiple projects. Each repo has its own .env at the project root.
#
# Solution: Automatically find the nearest .env file by walking up the directory
#           tree from wherever you run `uv`. This works across all repos without
#           manual configuration.
#
# How it works:
#   1. Start from current directory ($PWD)
#   2. Check if .env exists in current dir
#   3. If not, check parent directories up to filesystem root (/)
#   4. Stop early if we hit a git root (don't search outside the repo)
#   5. Export UV_ENV_FILE if found, otherwise uv uses its defaults
#
# Why this is better than static path:
#   - Works in nobsmed-v2, future repos, and any project with .env at root
#   - Run `uv` from any subdirectory and it finds the project .env
#   - No manual updates needed when switching repos
# ==============================================================================

find_project_env() {
    local dir="$PWD"

    # Walk up directory tree looking for .env file
    while [[ "$dir" != "/" ]]; do
        # Found .env in current directory
        if [[ -f "$dir/.env" ]]; then
            echo "$dir/.env"
            return 0
        fi

        # If we hit git root, check there and stop searching
        # (don't search outside the repository boundary)
        if [[ -d "$dir/.git" ]]; then
            if [[ -f "$dir/.env" ]]; then
                echo "$dir/.env"
                return 0
            fi
            # No .env at git root, give up
            break
        fi

        # Move up one directory
        dir="$(dirname "$dir")"
    done

    # No .env found - uv will use its default behavior
    return 1
}

# Set UV_ENV_FILE dynamically based on current location
# This runs every time a new shell starts or when you cd to a new directory
if env_file=$(find_project_env); then
    export UV_ENV_FILE="$env_file"
else
    # No .env found - unset so uv uses defaults
    unset UV_ENV_FILE
fi

export GITHUB_PERSONAL_ACCESS_TOKEN="$(cat ~/GITHUB_PERSONAL_ACCESS_TOKEN)"
export EDITOR=nvim
export VISUAL=nvim
export GOOSE_DISABLE_KEYRING=1
export GOOSE_TELEMETRY_ENABLED=false
export GOOSE_MODE=approve
export GOOSE_PROVIDER=azure_openai
export AZURE_OPENAI_API_KEY="$(cat ~/AZURE_OPENAI_API_KEY)"
export AZURE_API_KEY="$(cat ~/AZURE_OPENAI_API_KEY)"
export AZURE_OPENAI_ENDPOINT="https://boris-m3ndov9n-eastus2.cognitiveservices.azure.com/"
export AZURE_OPENAI_DEPLOYMENT_NAME="gpt-5.2-chat"
export AZURE_OPENAI_API_VERSION="2025-04-01-preview"
export GOOSE_LEAD_MODEL="gpt-5.2-chat"
export GOOSE_MODEL="gpt-4.1"
# Enhanced editing (Azure OpenAI v1-compatible endpoint)
export GOOSE_EDITOR_API_KEY="$AZURE_OPENAI_API_KEY"
export GOOSE_EDITOR_HOST="https://boris-m3ndov9n-eastus2.openai.azure.com/openai/v1"
export GOOSE_EDITOR_MODEL="gpt-5.2-chat"   # or whatever model/deployment id Azure expects
export GOOSE_LEAD_TURNS=5
export GOOSE_LEAD_FAILURE_THRESHOLD=1
export GOOSE_LEAD_FALLBACK_TURNS=2
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
)
source $ZSH/oh-my-zsh.sh
# fuzzy file and dir finder with ctrl-t
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


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
export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
    [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && . "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
