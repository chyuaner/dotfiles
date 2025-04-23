Yuan dotfile
================================================================================

安裝 (個人用途)
--------------------------------------------------------------------------------
### Linux / macOS
#### 安裝主dotfiles包
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init https://git.yuaner.tw/yuan/dotfiles-private.git --apply
```

<details>
  <summary>私人用安裝方式</summary>
##### 1. 放置自己的金鑰（若是其他人要用，請直接跳過）
將 `id_rsa` sshkey金鑰檔放到 `~/.ssh/id_rsa`

##### 2. 安裝主dotfiles包
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init ssh://git@git.yuaner.tw:10022/yuan/dotfiles.git --apply
```

##### 3. 安裝私人用的dotfiles包（若是其他人要用，請直接跳過）
```
chezmoi init --source ~/.local/share/chezmoi-private --config ~/.config/chezmoi-private/chezmoi.toml ssh://git@git.yuaner.tw:10022/yuan/dotfiles-private.git --apply
chezmoi apply
```
</details>

#### 若需要刪掉重來
```
rm -rf ~/.local/share/chezmoi
rm -rf ~/.local/share/chezmoi-private
```

可能會需要刪掉相關設定
```
rm ~/.ssh/known_hosts
rm -rf ~/.vimrc ~/.vim ~/.gvimrc
rm ~/.zshrc
rm -rf ~/.config/alacritty ~/.config/zellij 
```

<details>
  <summary>依照chezmoi官方教學</summary>
  #### Quick start
  With chezmoi, pronounced /ʃeɪ mwa/ (shay-mwa), you can install chezmoi and your dotfiles from your GitHub dotfiles repo on a new, empty machine with asingle command:

  ```
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ssh://git@git.yuaner.tw:10022/yuan/dotfiles.git
  ```

  As well as the curl | sh installation, you can install chezmoi with your favorite package manager.

  Updating your dotfiles on any machine is a single command:

  ```
  chezmoi update
  ```

  chezmoi runs on all popular operating systems, is distributed as a single statically-linked binary with no dependencies, and does not require root access.

  #### Set up a new machine with a single command

  You can install your dotfiles on new machine with a single command:

  ```
  chezmoi init --apply ssh://git@git.yuaner.tw:10022/yuan/dotfiles.git
  ```

  #### To force a refresh the downloaded archives
  use the --refresh-externals flag to chezmoi apply:

  ```
  chezmoi --refresh-externals apply
  ```

  `--refresh-externals` can be shortened to `-R`:

  ```
  chezmoi -R apply
  ```

</details>


chezmoi基本用法
--------------------------------------------------------------------------------
### 進入資料夾
```
chezmoi cd
```

### 加入檔案 (或從家目錄裡實際運作檔案內容更新)
```
chezmoi add ~/.zshrc
```

### 編輯檔案
```
EDITOR="code" chezmoi edit ~/.zshrc
chezmoi apply ~/.zshrc
```

#### 套用全部
```
chezmoi apply
```

zsh
--------------------------------------------------------------------------------

### 有用到的套件
* colorls
* eza
* sixel

### 基本快速鍵
* `alt+e`: 🪄開啟檔案總管快速鍵
* `ctrl+l`: 清空螢幕
* `ctrl+u`: 刪除一整行
* `ctrl+w`: 刪除一個單字


### zinit 套件管理程式

#### 更新所有套件
```
# Self update
zinit self-update

# Plugin update
zinit update
```

vim
--------------------------------------------------------------------------------

### 第一次啟動請先下以下指令

#### macOS
```
sudo ln -sfn $(brew --prefix java)/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
vim +PlugInstall  +qall
```

#### Windows (PowerShell)
```
winget install -e GoLang.Go OpenJS.NodeJS
mkdir -p vimfiles\autoload
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" -OutFile "vimfiles\autoload\plug.vim"
```