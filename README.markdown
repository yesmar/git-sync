# git-update

Copyright © 2018–2019 Ramsey Dow. All rights reserved.

[![](https://img.shields.io/badge/license-GPL%20v3-blue.svg?maxAge=2592000)](https://www.gnu.org/licenses/gpl-3.0.en.html)
![Platforms](https://img.shields.io/badge/platform-Linux%20|%20macOS-lightgrey.svg)

The `git-update` script automates `git` fetching and merging across arbitrarily deep directory hierarchies. Non-option arguments passed on the command line are treated as pathnames. `git-update` will operate on the current working directory if no pathnames were specified at runtime.

`git-update` recursively walks the specified directory pathnames, descending into `git` repos and performing fetch and merge operations. You can force a `git` repo to be skipped by creating an empty `.skip` file in the repo directory, alongside its `.git` subdirectory.

`git-update` is tolerant of errors and will keep running if at all possible. Note that authentication errors usually show up as `error 128`. In such cases, load the appropriate ssh keys into `ssh-agent` and run `git-update` again.

The following options are available:

| Option | Description |
| --- | --- |
| -h | Display usage information |
| -n | Disable color output (useful when redirecting to a log file) |

## Examples

Update all the repos in the current directory:

```bash
git-update
```

Update all of the repos under `~/src`:

```bash
git-update ~/src
```

## Diagnostics

The `git-update` utility exits 0 on success, and >0 if an error occurs.

## Environment

If you want colorized output, make my [colors.bash](https://gist.github.com/yesmar/17311d0aa7f39d954d31503aab4775f1) script available as `~/.local/etc/colors`.

## Installation

A `Makefile` has been included to ease the process of installing and uninstalling the software. Run `make install` (or just `make`) to install into `/usr`. To install into an alternate location, specify an installation prefix like this:

```bash
PREFIX=/opt make install
```

That will install the script to `/opt/bin` and the man page to `/opt/share/man/man1`.

Use the `uninstall` target to remove the software. Be sure to specify the appropriate `PREFIX` if you installed the software to a non-standard location, e.g.:

```bash
PREFIX=/opt uninstall
```

## Bugs

`Bash` may segfault when recursing massive directory hierarchies, an example being out-of-source llvm build directories. In such cases, create an empty `.skip` file within and the offending directory will be skipped.

## License

`git-update` is released under the [GNU General Public License, Version 3](https://www.gnu.org/licenses/gpl-3.0.en.html). A copy of the license is included in the distribution.
