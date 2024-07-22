# dotfiles

My personal dotfiles.


# Installation

```bash
mkdir --parents "${HOME}"/.dotfiles
echo ".dotfiles" >> "${HOME}"/.gitignore
git clone --bare "https://github.com/Erymer/dotfiles" "${HOME}"/.dotfiles
git --git-dir="${HOME}"/.dotfiles --work-tree="${HOME}" checkout -f
git --git-dir="${HOME}"/.dotfiles --work-tree="${HOME}" config --local status.showUntrackedFiles no
```
