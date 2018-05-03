fn size [filename]{
  stat --printf="%s" $filename
}
