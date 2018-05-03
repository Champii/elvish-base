use github.com/champii/elvish-base/utils

fn exists [filename]{
  not (utils:has_failed { stat $filename })
}

fn size [filename]{
  put (stat --printf="%s" $filename)
}

fn zero [filename]{
  == (size $filename) 0
}

fn zero_or_null [filename]{
  not (and (exists $filename) (not (zero $filename)))
}
