# Version control your dot files in case of a disaster

## Inspiring references

- [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles)

## Three approaches

- Approach 1: create a standard git repo with symlinks to your `$HOME` directory (most common approach) 
- Approach 2: turn your `$HOME` directory into a git repo (easiest though riskiest approach)
- Approach 3: create a special git bare repo that points to the dotfiles in your `$HOME` directory (the approach I used)

## The pros of the git bare approach

- avoids the complexity of Approach 1's requirement of making a symlink for each dotfile in your `$HOME` to your git repo 
- avoids the risk of Approach 2's requirement to make your `$HOME` directory into a git repo
- somewhat intuitive: run your `git commit` and `git push` commands directly from your `$HOME` repo after you edit your dotfiles

## The cons of the git bare approach

- hard to grasp the "bare" repo concept at first
- you must remember to create an alias, or otherwise remember long git commands

## What is a git "bare" repo?

In order to get one git repo directory that can point to pre-existing dotfiles that are
spread across your `$HOME` directory we setup a "bare" git repo. 

The "bare" word denotes that the snaphot or “working tree” of the source code is outside the repo.

These are good posts:

- [Using a bare Git repo to get version control for my dotfiles](https://stegosaurusdormant.com/bare-git-repo/).
- [How do you use "git --bare init" repository?](https://stackoverflow.com/questions/7632454/how-do-you-use-git-bare-init-repository)

## Steps to reproduce on my next laptop

```console
cd ~/workspace
git init --bare dotfiles.git
```

git status should not display all untracked files

```console
git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME config status.showUntrackedFiles no
git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME remote add origin git@github.com:borisdev/dotfiles.git
```

better yet add this alias to your `.bashrc|.zshrc|etc` to avoid typos.

```bash
alias dotgit='git --git-dir=$HOME/workspace/dotfiles.git/ --work-tree=$HOME'
```
then start version controlling your dotfiles 

```console
dotgit add ~/.gitconfig
dotgit commit -m "Git dotfiles"
dotgit push origin master
```
