use github.com/champii/elvish-base/utils
use github.com/champii/elvish-base/git

edit:prompt = {
  edit:styled "\n┌─[" red;
  edit:styled (tilde-abbr $pwd) lightyellow;
  edit:styled ']' red;

  put '-';

  edit:styled '[' red;
  edit:styled (date "+%Y-%m-%d %H:%M:%S") yellow;
  edit:styled ']' red;


  if (not (utils:has_failed { git:branch })) {
    put '-';

    edit:styled '[' red;
    edit:styled (git:branch) lightblue;

    put '@';

    edit:styled (put (git:commit_id)[:6]) green;

    if (git:is_dirty) {
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
