# go
E:GOROOT = /usr/local/go
E:GOPATH = $E:HOME"/go"

# path
E:PATH = $E:PATH":"$E:HOME"/.cabal/bin:"$E:GOROOT"/bin:"$E:GOPATH"/bin:"$E:HOME"/chromium-latest-linux/latest:/snap/bin:"$E:HOME"/.bin"
E:PATH = $E:PATH":/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/champii/.local/bin"

# nvm
E:NVM_DIR = $E:HOME"/.nvm"

default_node = (cat $E:NVM_DIR"/alias/default")
E:PATH = $E:PATH":"$E:NVM_DIR"/versions/node/"$default_node"/bin"
