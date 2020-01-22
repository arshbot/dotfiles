#!/bin/bash

#################################
#				#
#	  setup_popos.sh	#
#	  arshbot style		#
#				#
#           run with:		#
#  $ sudo bash setup_popos.sh	#
#				#
#################################

# Create folders
mkdir ~/Projects
mkdir ~/Limbo

# Install snap
apt install -y snapd
PATH=$PATH:/snap/bin

# Install pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
rm get-pip.py

# Mark apt install
apt install -y firefox 
apt install -y gnupg2
apt install -y gnome-tweak-tool
apt install -y neofetch
apt install -y zsh
apt install -y git-core
apt install -y --assume-yes vim
apt install -y jq
apt install -y tmux
apt install -y bash-completion
apt install -y python3.6
apt install -y vim-gtk
apt install -y xclip
apt install -y nomacs

# Mark snap installs
snap install spotify 
snap install telegram-desktop
snap install mailspring
snap install slack --classic
snap install microk8s --classic
snap install kubectl --classic
snap install helm --classic
snap install code --classic

# Disable microk8s
snap disable microk8s

# Skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
chmod +x skaffold
mv skaffold /usr/local/bin

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

# Nordvpn install
wget -O $HOME/Downloads/nordvpn-release_1.0.0_all.deb https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
dpkg -i nordvpn-release_1.0.0_all.deb
apt update
apt install nordvpn

# Construct zshrc
cat bash_aliases.sh >> ~/.zshrc
cat fold_aliases.sh >> ~/.zshrc
echo "source /usr/share/bash-completion/bash_completion" >> ~/.zshrc
echo "source <(kubectl completion bash)" >> ~/.zshrc
echo "clear" >> ~/.zshrc
source ~/.zshrc

# Enable bash_completion
kubectl completion bash >/etc/bash_completion.d/kubectl

# vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp vimrc ~/.vimrc
vim +PluginInstall +qall

# Install gnome-extensions
# 
# Assumes extensions are predownloaded and zipped in gnome-extensions within dotfiles repo
for zipfile in gnome-extensions/*.zip; do 
      UUID=unzip -p "$zipfile" metadata.json | grep uuid | cut -d \" -f4;
      mkdir -p ~/.local/share/gnome-shell/extensions/"$UUID";
      unzip -q "$zipfile" -d ~/.local/share/gnome-shell/extensions/"$UUID";
      gnome-shell-extension-tool -e "$UUID";
done

# git setup
git config --global user.name "Harsha Goli"
git config --global user.email "harshagoli@gmail.com"
git config --global core.editor vim
git config --global credential.helper store
git config --global commit.gpgsign true

# Docker install ( https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04 )
apt update
apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update # Important to update package db with Docker packages
apt install docker-ce -y
usermod -a -G docker $USER
printf "##############################\n# A reboot is required\n#\n# run $ reboot\n#\n##############################\n"
