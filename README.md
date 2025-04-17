# Dotfiles

## Setup

Install [GNU Stow](https://www.gnu.org/software/stow/)

```
brew install stow
```

Clone in your home directory:

```
cd && git clone git@github.com:tomfran/dotfiles.git
```

Create simlinks: 

```
make stow
```

## ZSH

Required:
- [fzf](https://github.com/junegunn/fzf): history and cd completions;
- [zoxide](https://github.com/ajeetdsouza/zoxide): smart cd.

After stowing, run `source ~/.zshrc` this or restart the shell.

## Mac OS Specific

Remove dock hide delay

```
defaults write com.apple.dock autohide-delay -float 0 && killall Dock
```

Speed up dock hide animation

```
defaults write com.apple.dock autohide-time-modifier -float 0.5 && killall Dock
```

Tiling window manager [AeroSpace](https://github.com/nikitabobko/AeroSpace)

```
brew install --cask nikitabobko/tap/aerospace
```

Replace Caps Lock with Control

```
Settings > Keyboard > Keyboard Shortcuts > Modifier Keys > Caps Lock to Control
```