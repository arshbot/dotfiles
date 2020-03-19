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

export -f fm

resetresolve() {
        sudo rm /etc/resolv.conf && sudo ln -s /run/resolvconf/resolv.conf /etc/resolv.conf
}

export -f resetresolve

vpn_dip() {
        sudo openvpn --config ~/.vpn/openvpn.conf /etc/openvpn/ovpn_tcp us4952.nordvpn.com.tcp.ovpn
}

export -f vpn_dip

# Mark exports
export PATH=$PATH:/snap/bin
