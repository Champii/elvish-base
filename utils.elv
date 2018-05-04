fn null_out [f]{
  { $f 2>&- > /dev/null }
}

fn has_failed [p]{
  eq (bool ?(null_out $p)) $false
}

fn json [file]{
  cat $file | from-json
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

fn zipMap [f arr]{
  @res = (map [x]{
    @in = ($f $x)
    put [$x $@in]
  } $arr)
  put $res
}

fn _table_tab_size [arr]{
  @max = (repeat (count $arr[0]) 0)

  utils:map [line]{
    i = 0

    utils:map [item]{
      size = (count $item)

      if (> $size $max[$i]) {
        max[$i] = $size
      }

      i = (+ $i 1)
    } $line
  } $arr

  put $max
}

fn table_print [arr]{
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
