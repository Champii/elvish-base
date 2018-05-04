fn null_out [f]{
  { $f 2>&- > /dev/null }
}

fn has_failed [p]{
  eq (bool ?(null_out $p)) $false
}

fn json [file]{
  cat $file | from-json
}

fn optional_in [rest]{
  arr = []

  if (not (eq (count $rest) 1)) {
    arr = (all)
  } else {
    arr = $rest[0]
  }

  put $arr
}

fn filter [f @rest]{
  a = (optional_in $rest)

  @res = (for x $a {
    if ($f $x) {
      put $x
    }
  })

  put $res
}

fn map [f @rest]{
  a = (optional_in $rest)

  @res = (for x $a {
    put ($f $x)
  })

  put $res
}

#fn reduce [f arr acc]{
#  for x $arr {
#    acc = ($f $acc $x)
#  }
#  put $acc
#}

fn floor [x]{
  @r = (splits . $x)
  put $r[0]
}

fn zipMap [f @rest]{
  arr = (optional_in $rest)

  res = (map [x]{
    @in = ($f $x)

    put [$x $@in]
  } $arr)

  put $res
}

fn _table_tab_size [arr]{
  if (eq (count $arr) 0) {
    put []
    return
  }

  @max = (repeat (count $arr[0]) 0)

  each [line]{
    i = 0

    each [item]{
      size = (count $item)

      if (> $size $max[$i]) {
        max[$i] = $size
      }

      i = (+ $i 1)
    } $line
  } $arr

  put $max
}

fn table_print [@rest]{
  arr = (optional_in $rest)

  tab_size = (_table_tab_size $arr)

  each [line]{
    i = 0

    each [item]{
      printf "%-"$tab_size[$i]"s " $item

      i = (+ $i 1)
    } $line

    printf "\n"
  } $arr
}
