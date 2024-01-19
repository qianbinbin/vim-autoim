## vim-autoim

这是 macOS 版 vim 自动切换输入法的插件，它只做两件事：

* 进入输入模式时，恢复到上次的输入法。
* 退出输入模式时，切换到英文输入法。

### 前提条件

* 系统配置单独的英文输入法，如“美国”或“ABC”。
* 开启 Ctrl + Space 切换输入法的快捷键。

### 安装

#### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'qianbinbin/vim-autoim'
```

### 配置

#### 默认英文输入法

切换到英文输入法，并运行以下命令获取英文输入法的 ID：

```sh
defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID
```

如结果为 `com.apple.keylayout.US` 则无需配置，否则在 `~/.vimrc` 中加入：

```vim
let g:autoim_en = 'com.apple.keylayout.US'
```

将 `com.apple.keylayout.US` 改为你自己的英文输入法 ID，如 `com.apple.keylayout.ABC`。

#### 允许使用辅助功能

首次使用时，你的终端或 iTerm 等会要求使用辅助功能，允许即可。这是因为插件需要模拟键盘操作。

#### 减小延迟

如果你在退出输入模式时感到延迟，在 `~/.vimrc` 加入：

```vim
set ttimeoutlen=0
```

注意 `ttimeoutlen` 不是 `timeoutlen`，后者会造成组合键映射失效。

### 感谢

* [自动切换 vim 中文输入法](https://taoshu.in/vim/vim-auto-im.html)
* [smartim](https://github.com/ybian/smartim)
* [vimrc - Usage of timeoutlen and ttimeoutlen - Vi and Vim Stack Exchange](https://vi.stackexchange.com/a/24938)
* [Eliminating delays on ESC in vim and zsh - John Hawthorn](https://www.johnhawthorn.com/2012/09/vi-escape-delays/)
* [Delay when entering Insert mode in a terminal buffer · Issue #3743 · neovim/neovim](https://github.com/neovim/neovim/issues/3743#issuecomment-159642147)

### 为什么不使用 smartim

smartim 使用的 im-select 有概率性 bug：在进入输入模式并自动切换输入法后，即使菜单栏已经显示切换成功，输入的仍是英文。
