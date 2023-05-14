sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

apt-get clean
apt-get update \
&& apt-get upgrade -y \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends
    neovim \
    fzf
#
# custom shell 
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
#
# use requirements.txt
pip install openai
pip install ipdb
