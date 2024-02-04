## Quickstart

Install chezmoi: https://www.chezmoi.io/install/

Initialize this repository to apply the config:
```
GITHUB_USERNAME='oysteinje'
chezmoi init https://github.com/$GITHUB_USERNAME/dotfiles.git
```

Check what will be changed:
```
chezmoi diff
```

Apply the changes: 
```
chezmoi apply -v
```
