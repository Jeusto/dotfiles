# 🐧🔧 Personal dotfiles

My personal dotfiles managed using [GNU Stow](https://www.gnu.org/software/stow/).

(mainly for MacOS but also Linux & Windows to some degree)

## Usage

```sh
./dotfiles.sh install work    # or: perso
./dotfiles.sh install         # reuses the environment saved in ~/.dotfiles-env
./dotfiles.sh uninstall
```

Packages named `~macos` / `~linux` / `~windows` are stowed only on the matching
platform, and `~work` / `~perso` only for the selected environment. Put anything
that differs between the work and personal machine (git identity, ...) in those.
