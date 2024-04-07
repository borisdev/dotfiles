# git bare approach to version your dot files

This `bare` repo is based on file purpose, not file location.

One git repo will contain dot files spread all across many directories in your file system.

Your dot files (custom tooling configs) are foundational for you to quickly
write code that is contained across many other repo directories.

## Why version control dot files?

- you get a faster setup of a development environment on your new laptop after your old one is stolen
- you get a faster revert of big experimental screw up to your development environment

## What's special about the git bare approach compared to other approaches?

### Two competing approaches

- Approach 1: create a standard git repo with symlinks to your `$HOME` directory (most common approach) 
- Approach 2: turn your `$HOME` directory into a git repo (easiest though riskiest approach)

### The pros of this git bare approach

- avoids the complexity of Approach 1's requirement of making a symlink for each dotfile in your `$HOME` to your git repo 
- avoids the risk of Approach 2's requirement to make your `$HOME` directory into a git repo
- somewhat intuitive: run your `git commit` and `git push` commands directly from your `$HOME` repo after you edit your dot files

### The cons of this git bare approach

- hard to grasp the "bare" repo concept at first
- you must remember to create an alias, or otherwise remember long git commands

### What is a git "bare" repo?

In order to get one git repo directory that can point to pre-existing dotfiles that are
spread across your `$HOME` directory we setup a "bare" git repo. 

The "bare" word denotes that the snaphot or “working tree” of the source code is outside the repo.

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
