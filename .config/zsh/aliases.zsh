alias bye="poweroff"
alias ..="cd .."
alias q="exit"
alias Y="sudo yazi"
alias install="sudo pacman -S"
alias editz="nvim ~/.zshrc"
#GIT
alias lgit="lazygit"
alias git.="lazygit -p /home/aechewhy/.dotfiles"
alias g="git"
#EZA
alias l="eza"
alias le='eza --long --icons --classify -a'
alias lt="eza --long --header -a --icons --git --git-repos -B --total-size -U -u -m --time-style=long-iso"
# NEOVIM
ns() {
  # If a session exists for the folder you are currently in, open it.
  # Otherwise, open the last session you had active anywhere.
  nvim -c "lua if vim.fn.filereadable(require('persistence').current()) > 0 then require('persistence').load() else require('persistence').load({ last = true }) end"
}
nr() {
  nvim -c "lua Snacks.picker.recent()"
}
nf() {
  nvim -c "lua Snacks.picker.files()"
}
alias n="nvim"
