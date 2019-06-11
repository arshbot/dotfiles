#!/bin/bash

#################################
#				#
#	setup_ubuntu.sh		#
#	arshbot style		#
#				#
#################################

sudo -i

# Create folders
mkdir ~/Projects
mkdir ~/Limbo

# Install snap
apt install snapd

# Mark apt installs
apt install firefox 
apt install gnupg2
apt install gnome-tweak-tool
apt install neofetch
apt install zsh
apt install git-core
apt install --assume-yes vim

# Mark snap installs
snap install spotify 
snap install telegram-desktop
snap install slack --classic
snap install microk8s --classic
snap install kubectl --classic

# oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s `which zsh`

# zoom install
cd ~/Downloads
wget https://zoom.us/client/latest/zoom_amd64.deb
dpkg -i zoom*.deb
apt-get -f install
cd -

# keybase install
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
# if you see an error about missing `libappindicator1` from the next
# command, you can ignore it, as the subsequent command corrects it
apt-get upgrade
apt-get -f install
apt-get install libappindicator1
dpkg -i keybase_amd64.deb
apt-get install -f
# run_keybase to start

# Construct zshrc
cat bash_aliases.sh >> ~/.zshrc
cat fold_aliases.sh >> ~/.zshrc

# vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vimrc ~/.vimrc
vim +PluginInstall +qall
