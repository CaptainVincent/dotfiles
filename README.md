# dotfiles

dotfiles manegered by [chezmoi](https://github.com/twpayne/chezmoi)

Most dotfiles or setting files I prefer using [mackup](https://github.com/lra/mackup) because I have more than two personal mac computers.

But... I don't want my Dropbox linked too many machines especially VPS.

Here I pick out a minimum dotfiles set to organize my cross platform machine's environment.

And below will describe how I make them work together.

**First, I add symbolic link and physical file both into chezmoi**

For example:
```bash
chezmoi add ~/.zshrc $(readlink ~/.zshrc)
```

**And then I sed all symbolic link paths from absolute path to relative path like this**

```bash
find . -name 'symlink*' -print0 | xargs -0 sed -i "" "s|${HOME//\//\\/}|\$HOME|g"
```


> If you have any better workflow fit the situation. Please create an issue and advise me : )  
> I will appreciate your help very much.