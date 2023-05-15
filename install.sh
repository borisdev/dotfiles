# use zsh instead of bash so that we can take advantage of oh-my-zsh CLI plugins
sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

# install my snowflake ubuntu libraries
apt-get clean
apt-get update \
&& apt-get upgrade -y \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends
    neovim \
    fzf


# custom oh-my-zsh plugins for fast CLI work (I think)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# one day replace this wit pip install requirements.txt
pip install openai
pip install ipdb
