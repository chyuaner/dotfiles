Yuan dotfile
===
安裝
---
With chezmoi, pronounced /ʃeɪ mwa/ (shay-mwa), you can install chezmoi and your dotfiles from your GitHub dotfiles repo on a new, empty machine with a single command:
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ssh://git@git.yuaner.tw:10022/yuan/dotfiles.git
```

As well as the curl | sh installation, you can install chezmoi with your favorite package manager.

Updating your dotfiles on any machine is a single command:
```
chezmoi update
```

chezmoi runs on all popular operating systems, is distributed as a single statically-linked binary with no dependencies, and does not require root access.

### Set up a new machine with a single command

You can install your dotfiles on new machine with a single command:

```
chezmoi init --apply ssh://git@git.yuaner.tw:10022/yuan/dotfiles.git
```

zsh
---
### 基本快速鍵
* `ctrl+l`: 清空螢幕
* `ctrl+u`: 刪除一整行


### .zshrc
使用 zinit 作為套件管理程式

#### 更新所有套件
```
# Self update
zinit self-update

# Plugin update
zinit update
```
