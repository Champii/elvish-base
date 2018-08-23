use github.com/champii/elvish-base/utils

# fs utils
fn isFile [x]{
  not (utils:has_failed { test -f $x })
}

fn isDir [x]{
  not (utils:has_failed { test -d $x })
}

fn type [x]{
  if (isFile $x) {
    put 'file'
  } else {
    put 'dir'
  }
}

fn kilo [x]{
  * $x 1024
}

fn mega [x]{
  * (kilo $x) 1024
}

fn giga [x]{
  * (mega $x) 1024
}

# files
fn exists [filename]{
  not (utils:has_failed { stat $filename })
}

fn size [filename]{
  os=(uname -s)
  if (==s $os "Linux") {
    put (stat --printf="%s" $filename)
  } else {
    put (stat -f %z $filename)
  }
}

fn pretty_size [filename]{
  i = 0
  x = (size $filename)

  while (>= $x 1024) {
    i = (+ $i 1)
    x = (/ $x 1024)
  }

  x = (utils:floor $x)

  if (eq $i 1) {
    put $x"Ko"
  } elif (eq $i 2) {
    put $x"Mo"
  } elif (eq $i 3) {
    put $x"Go"
  } else {
    put $x
  }
}

fn zero [filename]{
  == (size $filename) 0
}

fn zero_or_null [filename]{
  not (and (exists $filename) (not (zero $filename)))
}

fn list_empty {
  @list = (e:ls)

  utils:filter [x]{ eq (size $x) 0 } $list
}

fn list_gt [s]{
  @list = (e:ls)

  utils:filter [x]{ >= (size $x) $s } $list
}

fn File [path]{
  fileObj = [
    &path=(path-abs $path)
    &type=(type (path-abs $path))

    &cat~={ e:cat $fileObj[path] }
    &size~={ pretty_size $fileObj[path]}
    &infos~={
      echo Path: $fileObj[path]
      echo Type: $fileObj[type]
      echo Size: ($fileObj[size~])
    }
  ]

  put $fileObj
}
