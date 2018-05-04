# elvish-base
Personal elvish files

# Usage

You just have to put file in `~/.elvish/rc.elv` and `-source ~/.elvish/rc.elv`

It will download every dependencies, no need to install them yourself

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
use github.com/champii/elvish-base/env
use github.com/champii/elvish-base/alias
use github.com/champii/elvish-base/prompt
use github.com/champii/elvish-base/bindings
use github.com/champii/elvish-base/fs
use github.com/champii/elvish-base/utils

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

- pretty_size[path] => number

  Same as `size`

  Returns the approximative size in corresponding bytes order

  ```
  ~> fs:size /tmp/foo
  ▶ 733Mo
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

- list_empty[] => arr

  Returns all files in current directory that are empty

  ```
  ~> fs:list_empty
  ▶ foo
  ▶ bar
  ```

- list_gt[number] => arr

  Returns all files in current directory that greater than given size in bytes

  ```
  ~> fs:list_gt (fs:mega 10)
  ▶ foo
  ▶ bar
  ```

- kilo[number] => number

  Returns the number of kilo in bytes

  ```
  ~> fs:kilo 10
  ▶ 102400
  ```

- mega[number] => number

  Returns the number of mega in bytes

  ```
  ~> fs:mega 10
  ▶ 1.048576e+07
  ```

- giga[number] => number

  Returns the number of giga in bytes

  ```
  ~> fs:giga 10
  ▶ 1.073741824e+10
  ```

## utils

- null_out[func] => func

  Returns a function with stdout and stderr discarded

  ```
  ~> utils:null_out { cat /tmp/foo }
  ~>
  ```
  ```
  ~> new_cat = { util:null_out { cat } }
  ~> $new_cat /tmp/foo
  ~>
  ```

- has_failed[func] => bool

  Return true if the function has failed

  ```
  ~> utils:has_failed { stat /tmp/foo }
  ▶ $true
  ```

- json[path] => map

  Return the parsed json map

  ```
  ~> put (utils:json somefile.json)[somekey]
  ▶ someValue
  ```

- filter[func arr] => arr

  Filter the array with the predicate

  ```
  ~> utils:filter $fs:exists~ [/tmp/foo /tmp/bar]
  ▶ /tmp/foo
  ```

- map[func arr] => arr

  Map the predicate over the array

  ```
  ~> utils:map $fs:exists~ [/tmp/foo /tmp/bar]
  ▶ $true
  ▶ $false
  ```

- floor[number|string] => number

  Floor the number

  ```
  ~> utils:floor (/ 100 3)
  ▶ 33
  ```

- zipMap[func arr] => arr

  Takes an array (1 dimension) and produces an array of array (2 dimensions)

  For each item, the callback can return as many elements as wanted, that will be added with the original element into an array.

  ```
  ~> @list = (fs:list_gt (fs:mega 100))
  ~> utils:zipMap $fs:pretty_size~ $list | fs:table_print (all)
  file1.ext        2Go
  file13334.ext    133Mo
  file23.ext       101Mo
  file12332223.ext 633Mo
  ```

- table_print[arr] => void

  Pretty print a 2D array
