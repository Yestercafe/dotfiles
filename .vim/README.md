# 极简 Vim/Neovim 配置（跨 macOS/Linux/Windows）

这个仓库里的 `.vim/` 目录包含一套“极简 + 共享”的配置：

- Vim（经典）与 Neovim 共享同一份 `.vim/vimrc`
- 插件不使用 `vim-plug`，改用 `git submodule`
- 插件通过 Vim/Neovim 内建的 `pack/*/start/` 机制自动加载

## 目录结构（你在各平台需要保证）

建议把本仓库的 `.vim/` 链到用户目录下的 `~/.vim`（这样 `packpath` 才能统一指向同一个位置）：

- `~/.vim/vimrc`
- `~/.vim/init.vim`（Neovim 使用）
- `~/.vim/pack/bundle/start/*`（submodule 插件）

## macOS / Linux 安装

1. 创建符号链接（把 `/path/to/dotfiles` 替换成你的实际路径）

```bash
ln -s /path/to/dotfiles/.vim ~/.vim
mkdir -p ~/.config/nvim
ln -s /path/to/dotfiles/.vim/init.vim ~/.config/nvim/init.vim
```

2. 首次拉取子模块

```bash
cd /path/to/dotfiles
git submodule update --init --recursive
```

## Windows 安装（推荐 Git Bash / WSL）

1. 确保你能在 Windows 上拿到 `~/.vim` 路径（以下任意一种即可）：

- 如果你用 Git Bash/WSL：按 macOS/Linux 的方式做 `ln -s ... ~/.vim`
- 如果你用 Windows 原生 Vim：请让 `C:\Users\<you>\.vim` 指向本仓库的 `.vim`（例如用符号链接）

2. Neovim：

- 确保 `init.vim` 被指到 `~/.vim/init.vim`（通常是 `%USERPROFILE%\.config\nvim\init.vim` 或对应目录）

3. 依赖确认：

- 本方案的 fzf 功能依赖两个插件：`junegunn/fzf` + `junegunn/fzf.vim`。
- 还需要本机安装 `fzf` 二进制（你已确认 Windows 可装，因此不会降级）。

## 插件清单（由 submodule 管理）

放在 `.vim/pack/bundle/start/` 下，Vim/Neovim 会自动加载：

- `tpope/vim-surround`
- `tpope/vim-commentary`
- `tpope/vim-repeat`
- `tpope/vim-fugitive`
- `airblade/vim-gitgutter`
- `preservim/nerdtree`
- `junegunn/fzf`
- `junegunn/fzf.vim`
- `vim-airline/vim-airline`

## 更新子模块

子模块通常是“固定到某个提交”。你可以按需更新：

```bash
cd /path/to/dotfiles
git submodule update --init --recursive
git submodule update --remote --merge
```

## ctags 使用（可选自动触发）

本配置不依赖额外插件，直接基于 `ctags` + `fzf.vim` 的 `:Tags` 工作。

建议安装 Universal Ctags（含 `readtags`，可提升 `:Tags PREFIX` 体验）：

```bash
brew install universal-ctags
```

配置会优先使用 `uctags`，找不到时回退到 `ctags`（兼容多版本并存环境）。

### 日常用法

- 手动重建 tags：`<leader>ct` 或 `:CtagsUpdate`
- 打开 tags 检索（fzf）：`:Tags`
- 开关自动更新（默认关闭）：`<leader>cT` 或 `:CtagsAutoToggle`
  - 开启后会在 `VimEnter` 和 `BufWritePost` 触发更新，并带节流避免频繁重建
- 原生跳转：`<C-]>` 跳到定义，`<C-t>` 返回

### 忽略目录策略

默认会忽略常见大目录，减少噪音和索引耗时：`.git`、`node_modules`、`dist`、`build`、`target`、`.next`、`.cache`、`__pycache__`、`.venv`、`vendor`。

### 故障排查

- 提示 `ctags not found`：确认 `ctags` 在 `PATH` 中（`ctags --version`）。
- `:Tags` 无结果：先执行一次 `<leader>ct`，并确认当前项目根目录下存在 `tags` 文件。
- 索引过慢：保持自动更新关闭，仅在需要时手动更新，或继续精简忽略目录。

## 默认快捷键（leader = 空格）

- `<leader>w` 保存
- `<leader>q` 退出
- `<leader>fe` 切换 NERDTree
- `<leader><space>` 文件搜索（`:Files`）
- `<leader>,` Buffer 搜索（`:Buffers`）
- `<leader>sg` 在当前工程的 Git 跟踪文件中搜索（弹出 `GitGrep>` 输入后执行 `git grep`）
- `<leader>/` 当前文件内容搜索（`:BLines`）
- `<leader>sG` 全局内容搜索（`:Rg`，需要本机有 `rg`）
- `<leader>st` tags 检索（`:Tags`，需要本机有 `ctags`）
- `<leader>ct` 手动重建 tags（`:CtagsUpdate`）
- `<leader>cT` 切换 tags 自动更新（`:CtagsAutoToggle`，默认关闭）
- `<leader>F` 文件搜索（`:Files`，兼容保留）

