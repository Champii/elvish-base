fn null_out [f]{
  { $f 2>&- > /dev/null }
}

fn has_failed [p]{
  eq (bool ?(null_out $p)) $false
}

fn filter [f a]{
  for x $a {
    if ($f $x) {
      put $x
    }
  }
}

fn map [f a]{
  for x $a {
    put ($f $x)
  }
}
