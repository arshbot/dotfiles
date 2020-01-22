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
