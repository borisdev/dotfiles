# gh codespace is not using ubuntu

# copy over my personal neovim editor customizations
cp -r /workspaces/.codespaces/.persistedshare/dotfiles/.config/nvim .config/


# catch syntax errors
pip install pyright

# bash to zsh
sudo chsh "$(id -un)" --shell "/usr/bin/zsh" 

# correct neovim depends on brew https://docs.brew.sh/Homebrew-on-Linux
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" < /dev/null
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
brew install neovim

# source .zshrc since we changed it above
exec /bin/zsh

# auto-install vim plugins
zsh -c nvim -es -u .config/nvim/lua/plugins.lua -i NONE -c "PlugInstall" -c "qa"
