# dotfiles

dotfiles manegered by [chezmoi](https://github.com/twpayne/chezmoi)

Most dotfiles or setting files I prefer using [mackup](https://github.com/lra/mackup) because I have more than two personal mac computers.

But... I don't want my Dropbox linked too many machines especially VPS.

Here I pick out a minimum dotfiles set to organize my cross platform machine's environment.

And below will describe how I make them work together.

**First, add symbolic link and physical file both into chezmoi**

For example:
```bash
chezmoi add ~/.zshrc $(readlink ~/.zshrc)
```

**And then I sed all symbolic link paths from absolute path to relative path like this**

```bash
chezmoi cd
find . -name 'symlink*' -print0 | xargs -0 sed -i "" "s|${HOME//\//\\/}|\$HOME|g"
```

**Finally, use this script relink to the real home path on apply target**
> Because chezmoi not support `$HOME` env virable as I think so I need relink it.

```bash
#!/bin/bash
# Proper header for a Bash script.
for filename in $(find . -type l ! -exec test -e {} \; -print) ; do
  path=$(ls -l $filename | sed "s/.*>\ \(.*\)/\1/")
  new=$(echo $path | sed "s|\$HOME|${HOME}|g")
  ln -sf $new $filename
done
```


> If you have any better workflow fit the situation. Please create an issue and advise me : )  
> I will appreciate your help very much.