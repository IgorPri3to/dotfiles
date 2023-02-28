#!/usr/bin/env sh

sudo apt install -y \
    wget \
    gpg

wget -qO - https://regolith-desktop.org/regolith.key | \
gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg > /dev/null

echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] \
https://regolith-desktop.org/release-ubuntu-kinetic-amd64 kinetic main" | \
sudo tee /etc/apt/sources.list.d/regolith.list

sudo apt update
sudo apt install regolith-desktop regolith-compositor-picom-glx
sudo apt upgrade

sudo apt install -y \
    anacron \
    cargo \
    gnome-tweaks \
    gnome-extensions-app \
    neovim \
    python3-neovim \
    git \
    kitty \
    zsh \
    g++ \
#    lua-devel \
    luarocks \
    php \
    php-bcmath \
    php-mysqlnd \
#    php-pecl-zip \
    php-pgsql \
    php-posix \
    php-soap \
    php-xml \
#    docker-ce \
    docker-ce-cli \
#    containerd.io \
#    docker-compose-plugin \
    bat \
    fzf \
    httpie \
    ripgrep \
    tmux \
    ruby \
    python3 \
    htop \
#    proselint \
#    lm_sensors \
#    discord \
    slack \
    ruby \
    luarocks \
    curl \
    php-curl

sudo gem install lolcat

sudo pip install gitlint

sudo luarocks install luacheck

cargo install stylua

# Composer
./install-composer.sh
composer global require laravel/installer

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node

# Docker setup
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker

echo "Don't forget to copy over your .ssh and .gnupg directories!"

sudo reboot
