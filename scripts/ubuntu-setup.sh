#!/usr/bin/env sh

apt update
apt install sudo
adduser igorpri3to
usermod -aG sudo igorpri3to
su igorpri3to

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
    lua5.4 \
    luarocks \
    php \
    php-bcmath \
    php-mysqlnd \
    php8.1-zip \
    php-pgsql \
    php-soap \
    php-xml \
    bat \
    fzf \
    httpie \
    ripgrep \
    tmux \
    ruby \
    python3 \
    pip \
    htop \
    lm-sensors \
    curl \
    php-curl \
    ca-certificates \
    lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

RIPGREP_VERSION=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep -Po '"tag_name": "\K[0-9.]+')
curl -Lo ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/latest/download/ripgrep_${RIPGREP_VERSION}_amd64.deb"
sudo apt install -y ./ripgrep.deb
rg --version
rm -rf ripgrep.deb

sudo gem install lolcat
pip install gitlint
pip install proselint
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
