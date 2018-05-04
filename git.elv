use github.com/champii/elvish-base/utils

fn branch {
  put (git rev-parse --abbrev-ref HEAD)
}

fn commit_id {
  put (git rev-parse HEAD)
}

fn is_dirty {
  utils:has_failed { git diff-index --quiet HEAD }
}

fn status {
  put (git status --porcelain) | utils:to_list
}

