#!/bin/bash

#################################
#				#
#	setup_popos.sh		#
#	arshbot style		#
#				#
#################################

sudo -i

# Create folders
mkdir ~/Projects
mkdir ~/Limbo

# Install snap
apt install -y snapd
PATH=$PATH:/snap/bin


# Mark apt install
apt install -y firefox 
apt install -y gnupg2
apt install -y gnome-tweak-tool
apt install -y neofetch
apt install -y zsh
apt install -y git-core
apt install -y --assume-yes vim
apt install -y jq


# Mark snap installs
snap install spotify 
snap install telegram-desktop
snap install slack --classic
snap install microk8s --classic
snap install kubectl --classic

# oh-my-zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s $(which zsh)
sed -i -e 's/\/bin\/bash\//\/bin\/zsh\//g' /etc/passwd

# zoom install
cd ~/Downloads
wget https://zoom.us/client/latest/zoom_amd64.deb
dpkg -i zoom*.deb
apt-get install -y -f
cd -

# keybase install
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
# if you see an error about missing `libappindicator1` from the next
# command, you can ignore it, as the subsequent command corrects it
apt-get upgrade
apt-get install -y -f
apt-get install -y libappindicator1
dpkg -i keybase_amd64.deb
apt-get install -y -f
# run_keybase to start

# Construct zshrc
cat bash_aliases.sh >> ~/.zshrc
cat fold_aliases.sh >> ~/.zshrc

# vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vimrc ~/.vimrc
vim +PluginInstall +qall

# Install gnome-extensions
# 
# Assumes extensions are predownloaded and zipped in gnome-extensions within dotfiles repo
for zipfile in gnome-extensions/*.zip; do 
      UUID=unzip -c "$zipfile" metadata.json | grep uuid | cut -d \" -f4;
      mkdir -p ~/.local/share/gnome-shell/extensions/"$UUID";
      unzip -q "$zipfile" -d ~/.local/share/gnome-shell/extensions/"$UUID";
      gnome-shell-extension-tool -e "$UUID";
done
