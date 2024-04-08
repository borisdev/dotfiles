# dotfiles

Dot files are custom tooling configurations that you use to customize your development environment.

## Problem rationale

You want to version control your dot files so that you can:

- quickly reproduce your development environment on your new laptop
- quickly revert a failed experimental development environment change

## Approach rationale

A git bare approach avoids the complexity of creating symlinks for each dot file.

The "bare" word denotes that the snapshot or “working tree” of the source code
is outside the repo. A git bare approach allows you to have one repo contain
all your dot files that are spread across many different directories.


### References

- [Using a bare Git repo to get version control for my dotfiles](https://stegosaurusdormant.com/bare-git-repo/).
- [How do you use "git --bare init" repository?](https://stackoverflow.com/questions/7632454/how-do-you-use-git-bare-init-repository)
- [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles)


## Steps to setup a development environment on my next laptop

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
