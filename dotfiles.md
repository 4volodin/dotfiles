# Dotfiles in git bare repo
## Configs .dotfiles

> Public repository

```
git init --bare $HOME/.dotfiles.git
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
dotfiles config --local status.showUntrackedFiles no
```

```
dotfiles status
dotfiles add .zshrc
dotfiles commit -m "Add zshrc"
dotfiles remote add origin   git@github.com:4volodin/dotfiles.git
dotfiles push -u origin main
```

## Installing dotfiles to another system

```
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo ".dotfiles.git" >> .gitignore
git clone --bare https://www.github.com/4volodin/dotfiles.git $HOME/.dotfiles.git


#backup origin configs
mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

dotfiles config --local status.showUntrackedFiles no

# force overwriting
dotfiles checkout -f

```
