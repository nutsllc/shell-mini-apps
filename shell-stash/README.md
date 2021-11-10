# Shell Stash

This script provides a temporary file / directory stash in the shell.
Files / directories can be moved in and out of this stash from any directory.

## Getting Started
Clone this repository at anywhere you want.
```bash
$ git clone
```

Add line below in ``.bash_profile`` for Bash or ``.zprofile`` for zsh.
```bash
source path/to/ShellStash/shell-stash
```

finish!

## Usage
Put files or directories in stash.
```bash
$ stash [file/directory]
```

Extract files / directories from stash
```bash
$ stash pop [file/directory] [directory where to take out]
```

List the contents of stash
```bash
$ stash
```

Empty the contents of stash (contents will be deleted)
```bash
$ stash drop
```
