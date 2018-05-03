edit:prompt = {
  edit:styled "\n┌─[" red;
  edit:styled (tilde-abbr $pwd) lightyellow;
  edit:styled ']' red;

  put '-';

  edit:styled '[' red;
  edit:styled (date "+%Y-%m-%d %H:%M:%S") yellow;
  edit:styled ']' red;


  if ?(git rev-parse --abbrev-ref HEAD 2>&- > /dev/null) {
    put '-';

    edit:styled '[' red;
    edit:styled (put (git rev-parse --abbrev-ref HEAD)) lightblue;

    put '@';

    edit:styled (put (put (git rev-parse HEAD))[:6]) green;

    if (not ?(git diff-index --quiet HEAD 2>&- > /dev/null)) {
      edit:styled '*' yellow;
    }

    edit:styled ']' red;
  }

  put "\n"

  edit:styled "└─[" red
  edit:styled (whoami) lightgreen
  edit:styled "@" gray
  edit:styled (hostname) lightcyan
  edit:styled "]> " red
}

edit:rprompt = {  }
