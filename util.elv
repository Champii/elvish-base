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
