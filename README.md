# elvish-base
Personal elvish files

# Usage

`~/.elvish/rc.elv`

```
use epm
use re
use readline-binding

epm:install                              \
  &silent-if-installed=$true             \
  github.com/champii/elvish-base         \
  github.com/zzamboni/elvish-completions \
  github.com/zzamboni/elvish-modules

use github.com/champii/elvish-base/git
use github.com/champii/elvish-base/fs
use github.com/champii/elvish-base/env
use github.com/champii/elvish-base/alias
use github.com/champii/elvish-base/git
use github.com/champii/elvish-base/prompt
use github.com/champii/elvish-base/bindings
use github.com/champii/elvish-base/util

use github.com/zzamboni/elvish-completions:git
use github.com/zzamboni/elvish-modules/long-running-notifications
use github.com/zzamboni/elvish-modules/util

-exports- = (alias:alias:export)
```

# Api

## fs

- exists[path] => bool

  This method checks safely if the file exists

  ```
  ~> fs:exists /tmp/foo
  ▶ $true
  ```

- size[path] => number

  Fail if the path does not exists

  Returns the size in bytes

  ```
  ~> fs:size /tmp/foo
  ▶ 1024
  ```

- zero[path] => bool

  Fail if the path does not exists

  Returns true if the size is 0

  ```
  ~> fs:zero /tmp/foo
  ▶ $false
  ```

- zero_or_null[path] => bool

  Does not fail

  Returns true if the file doesn't exists or if the size is 0

  ```
  ~> fs:zero_or_null /i_dont_exist
  ▶ $true
  ```

## util

- null_out[func] => func

  Returns a function with stdout and stderr discarded

  ```
  ~> util:null_out { cat /tmp/foo }
  ```
  ```
  ~> new_cat = { util:null_out { cat } }
  ~> $new_cat /tmp/foo
  ~>
  ```

- has_failed[func] => bool

  Return true if the function has failed

  ```
  ~> util:has_failed { stat /tmp/foo }
  ▶ $true
  ```
