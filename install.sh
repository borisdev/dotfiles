# use zsh instead of bash to take advantage of oh-my-zsh CLI plugins
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# ubuntu packages needed for my workflow
apt-get clean
apt-get update \
&& apt-get upgrade -y \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends
    neovim \
    fzf


# oh-my-zsh plugins that require git clone installation
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# TODO: pip install requirements.txt
pip install openai
pip install ipdb
