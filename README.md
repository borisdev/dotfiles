# Version control your development environment

## Why?

- setup a new laptop
- share your development environment with others
- revert a failed PDE experiment

## Approach

- One repo consolidates all config and dot files - outside its .git directory location.
- No symlinks 

## References

- [Using a bare Git repo to get version control for my dotfiles](https://stegosaurusdormant.com/bare-git-repo/).
- [How do you use "git --bare init" repository?](https://stackoverflow.com/questions/7632454/how-do-you-use-git-bare-init-repository)
- [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles)


## Setup

```console
cd ~/workspace
git init --bare dotfiles.git
```

git status should not display all untracked files

```console
git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME config status.showUntrackedFiles no
git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME remote add origin git@github.com:borisdev/dotfiles.git
```

add this alias to your `.bashrc` or `.zshrc`...

```bash
alias dotgit='git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME'
```

...then source your `.bashrc` or `.zshrc`...

...remember to replace `dotgit` with `git` in the following commands...

```console
dotgit add ~/.gitconfig
dotgit commit -m "Git dotfiles"
dotgit push origin master
```
