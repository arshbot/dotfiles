# Install brew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install favorite applications
brew cask install iterm2 google-chrome slack postman sublime-text spotify ngrok 1password docker virtualbox

# Set up aliases
mkdir ~/.aliases
cp fold_aliases ~/.aliases
cp bash_aliases ~/.aliases

# Set up Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
printf "############# IMPORTANT #############\n#\n# Launch vim and run :PluginInstall\n#\n############# IMPORTANT #############\n"

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Construct zshrc
echo source ~/.aliases/fold_aliases >> ~/.zshrc
echo source ~/.aliases/bash_aliases >> ~/.zshrc
