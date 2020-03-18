# Mark personal bash aliases
alias whatsmyip="curl ifconfig.me"
alias lnc="lncli --network=testnet"
alias k="kubectl"
alias c="clear"
alias xclip="xclip -selection c"
alias ffF="firefox -p Fold &"
alias ffP="firefox -p Personal &"

# Mark personal functions
fm() {
	nautilus $1 &
}

resetresolve() {
        sudo rm /etc/resolv.conf && sudo ln -s /run/resolvconf/resolv.conf /etc/resolv.conf
}

# Mark exports
export PATH=$PATH:/snap/bin
