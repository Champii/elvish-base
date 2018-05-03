use github.com/zzamboni/elvish-modules/alias

#- ls
alias:new ls e:ls --color
alias:new l  ls -la --color
alias:new sl ls --color

#- api
alias:new install      sudo apt install
alias:new update       sudo apt update
alias:new upgrade      sudo apt upgrade
alias:new dist-upgrade sudo apt dist-upgrade
alias:new search       sudo apt search
alias:new remove       sudo apt remove

#- ping
alias:new pg ping google.fr
alias:new p8 ping 8.8.8.8

#- screen
alias:new detach screen -d -m -S
alias:new attach screen -r
alias:new sls    screen -ls

-exports- = (alias:export)
