# go
E:GOROOT = /usr/local/go
E:GOPATH = $E:HOME"/go"

# nvm
E:NVM_DIR = $E:HOME"/.nvm"
default_node = (cat $E:NVM_DIR"/alias/default")

# path
paths = [
  $E:HOME"/.cabal/bin"
  $E:GOROOT"/bin"
  $E:GOPATH"/bin"
  $E:HOME"/chromium-latest-linux/latest"
  /snap/bin
  $E:HOME"/.bin"
  /usr/local/sbin
  /usr/local/bin
  /usr/sbin
  /usr/bin
  /sbin
  /bin
  /home/champii/.local/bin
  $E:NVM_DIR"/versions/node/"$default_node"/bin"
]
