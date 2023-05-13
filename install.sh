sudo chsh "$(id -un)" --shell "/usr/bin/zsh"

apt-get clean
apt-get update \
&& apt-get upgrade -y \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends
    neovim \
    fzf

pip install openai
pip install ipdb
