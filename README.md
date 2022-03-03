# Inspiring references

- [Awesome dotfiles](https://github.com/webpro/awesome-dotfiles)

# Three potential git approaches to version control your dotfiles

- create a special git bare repo that points to the dotfiles in your `$HOME` directory (the approach I used)
- create a standard git repo with symlinks to your `$HOME` directory (most common approach) 
- turn your `$HOME` directory into a git repo (easiest though riskiest approach)

# What is a git "bare" repo?

In order to get one git repo directory that can point to pre-existing dotfiles that are
spread across your `$HOME` directory we setup a "bare" git repo. 

The "bare" word denotes that the snaphot or “working tree” of the source code is outside the repo.

These are good posts:

- [Using a bare Git repo to get version control for my dotfiles](https://stegosaurusdormant.com/bare-git-repo/).
- [How do you use "git --bare init" repository?](https://stackoverflow.com/questions/7632454/how-do-you-use-git-bare-init-repository)

# The pros of using the git "bare" repo approach?

- avoids the complexity cost of making a symlink for each dotfile in your `$HOME` to your git repo 
- avoids the risk making your `$HOME` directory into a git repo
- intuitive: run your `git commit` and `git push` commands directly from your `$HOME` repo after you edit your dotfiles

# Steps to reproduce on my next laptop


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
then 

```console
dotgit add ~/.gitconfig
dotgit commit -m "Git dotfiles"
dotgit push origin master
```
