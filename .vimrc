" ============================================================
" Final Vim Configuration
" Target:
" - No plugin dependency
" - Server friendly
" - Backend / Java / config file editing
" - Stable, lightweight, maintainable
" ============================================================

" ============================================================
" Basic
" ============================================================

set nocompatible
filetype off

let mapleader = " "
let maplocalleader = ","

" ============================================================
" Encoding
" ============================================================

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,gbk,gb2312,gb18030,latin1

" ============================================================
" Filetype / Syntax / Indent
" ============================================================

syntax enable
filetype plugin indent on

" ============================================================
" UI
" ============================================================

set number
set relativenumber
set cursorline
set showcmd
set showmode
set ruler
set laststatus=2
set cmdheight=1
set signcolumn=yes
set scrolloff=6
set sidescrolloff=8

" Do not show intro message
set shortmess+=I

" Show invisible characters by default.
" Server/config editing friendly. Toggle with <leader>ul.
set list
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:+

" Highlight matching bracket
set showmatch
set matchtime=2

" Long line hint
set colorcolumn=120

" ============================================================
" Search
" ============================================================

set ignorecase
set smartcase
set incsearch
set hlsearch

" ============================================================
" Edit Behavior
" ============================================================

set hidden
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set virtualedit=block

" Do not wrap long lines by default
set nowrap

" Enable mouse
set mouse=a

" ============================================================
" Indent
" ============================================================

set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" ============================================================
" Backup / Swap / Undo
" ============================================================

set nobackup
set nowritebackup

" Personal server / container friendly.
" Trade-off:
" - Cleaner filesystem
" - But weaker recovery after SSH disconnect / crash
set noswapfile

" Persistent undo
if has("persistent_undo")
  if !isdirectory(expand("~/.vim/undo"))
    call mkdir(expand("~/.vim/undo"), "p")
  endif
  set undofile
  set undodir=~/.vim/undo
endif

" ============================================================
" Completion
" ============================================================

set completeopt=menu,menuone,noselect
set wildmenu
set wildmode=longest:full,full

set wildignore+=*.o,*.obj,*.class
set wildignore+=*.pyc
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.webp
set wildignore+=*.zip,*.tar.gz,*.rar,*.7z
set wildignore+=*/node_modules/*
set wildignore+=*/target/*
set wildignore+=*/build/*
set wildignore+=*/dist/*
set wildignore+=*/.git/*
set wildignore+=*/.idea/*

" ============================================================
" Performance
" ============================================================

set lazyredraw
set ttyfast
set updatetime=300
set timeoutlen=500
set ttimeoutlen=10

" ============================================================
" Clipboard
" ============================================================

if has("clipboard")
  if has("unnamedplus")
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" ============================================================
" Split
" ============================================================

set splitbelow
set splitright

" ============================================================
" Folding
" ============================================================

" Folding is useful, but default enabled folding often disturbs editing.
set foldmethod=indent
set foldlevel=99
set nofoldenable

" ============================================================
" Color
" ============================================================

set background=dark

try
  colorscheme desert
catch
endtry

" ============================================================
" Status Line
" ============================================================

set statusline=
set statusline+=%f
set statusline+=\ 
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=%=
set statusline+=%y
set statusline+=\ 
set statusline+=%{&fileencoding}
set statusline+=\ 
set statusline+=%{&fileformat}
set statusline+=\ 
set statusline+=%p%%
set statusline+=\ 
set statusline+=%l:%c

" ============================================================
" Keymaps: Basic
" ============================================================

" Save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>x :x<CR>

" Clear search highlight
nnoremap <leader>nh :nohlsearch<CR>

" Reload / edit vimrc
nnoremap <leader>sr :source ~/.vimrc<CR>
nnoremap <leader>ev :edit ~/.vimrc<CR>

" Toggle list chars
nnoremap <leader>ul :set list!<CR>

" Toggle wrap
nnoremap <leader>uw :set wrap!<CR>

" Toggle fold
nnoremap <leader>uf :set foldenable!<CR>

" ============================================================
" Keymaps: Better Movement
" ============================================================

" Jump to first non-blank / end of line
nnoremap H ^
nnoremap L $

" Keep search results centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv

" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Fast escape in insert mode.
" Only keep jk. Avoid jj because it is easier to mistype.
inoremap jk <Esc>

" ============================================================
" Keymaps: Window
" ============================================================

" Split
nnoremap <leader>sh :split<CR>
nnoremap <leader>vv :vsplit<CR>

" Move between windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Resize windows
nnoremap <leader>= <C-w>=
nnoremap <leader>+ :resize +5<CR>
nnoremap <leader>- :resize -5<CR>
nnoremap <leader>< :vertical resize -5<CR>
nnoremap <leader>> :vertical resize +5<CR>

" Close current window
nnoremap <leader>c :close<CR>

" ============================================================
" Keymaps: Buffer
" ============================================================

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader>bb :buffer<Space>

" ============================================================
" Keymaps: Tabs
" ============================================================

nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabprevious<CR>

" ============================================================
" Keymaps: Editing
" ============================================================

" Keep visual selection after indent
vnoremap < <gv
vnoremap > >gv

" Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Move current line up/down.
" <A-j>/<A-k> may not work in every terminal.
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi

" Terminal-stable fallback
nnoremap <leader>mj :m .+1<CR>==
nnoremap <leader>mk :m .-2<CR>==
vnoremap <leader>mj :m '>+1<CR>gv=gv
vnoremap <leader>mk :m '<-2<CR>gv=gv

" Delete without polluting default register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Paste over selection without overwriting register
xnoremap <leader>p "_dP

" ============================================================
" Keymaps: Quickfix / Location List
" ============================================================

nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>

nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>

" ============================================================
" Grep / Search Helpers
" ============================================================

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --glob\ '!{.git,target,build,dist,node_modules}/*'
  set grepformat=%f:%l:%c:%m

  " Fuzzy-ish project search for word under cursor
  nnoremap <leader>gw :silent grep! <C-r><C-w><CR>:copen<CR>

  " Exact word project search for word under cursor
  nnoremap <leader>gW :silent grep! -w <C-r><C-w><CR>:copen<CR>
else
  " Built-in fallback. Slower on large projects.
  nnoremap <leader>gw :vimgrep /\<<C-r><C-w>\>/gj **/*<CR>:copen<CR>
  nnoremap <leader>gW :vimgrep /\<<C-r><C-w>\>/gj **/*<CR>:copen<CR>
endif

" Replace word under cursor in whole file
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//g<Left><Left>

" ============================================================
" Command Abbreviations
" ============================================================

cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev QA qa

" ============================================================
" Filetype Specific
" ============================================================

augroup filetype_settings
  autocmd!

  " Java
  autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType java setlocal colorcolumn=120

  " Properties / env / config files
  autocmd FileType properties setlocal iskeyword+=-
  autocmd BufRead,BufNewFile *.properties setlocal iskeyword+=-
  autocmd BufRead,BufNewFile *.env setlocal iskeyword+=-

  " YAML / Dockerfile
  autocmd FileType yaml,dockerfile setlocal iskeyword+=-

  " XML / HTML
  autocmd FileType xml,html setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " JavaScript / TypeScript / JSON
  autocmd FileType javascript,typescript,javascriptreact,typescriptreact,json,jsonc setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " YAML
  autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " Markdown
  autocmd FileType markdown setlocal wrap linebreak
  " Enable spell manually when needed:
  " :set spell

  " Shell
  autocmd FileType sh,zsh,bash setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " SQL
  autocmd FileType sql setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

  " Dockerfile
  autocmd FileType dockerfile setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

augroup END

" ============================================================
" Large File Protection
" ============================================================

augroup large_file
  autocmd!
  autocmd BufReadPre * if getfsize(expand("%")) > 1024 * 1024 |
        \ setlocal norelativenumber nocursorline nolist |
        \ endif
augroup END

" ============================================================
" Auto Commands
" ============================================================

augroup general
  autocmd!

  " Return to last edit position
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif

augroup END

" ============================================================
" Native File Explorer: netrw
" ============================================================

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

nnoremap <leader>e :Explore<CR>
nnoremap <leader>E :Vexplore<CR>

" ============================================================
" Useful Commands
" ============================================================

" Delete empty lines
command! DeleteEmptyLines g/^$/d

" Trim trailing whitespace manually
command! TrimTrailingWhitespace %s/\s\+$//e

" Copy current file path/name.
" Use clipboard when available; otherwise echo it for server Vim.
if has("clipboard")
  command! CopyFilePath let @+ = expand('%:p')
  command! CopyFileName let @+ = expand('%:t')
else
  command! CopyFilePath echo expand('%:p')
  command! CopyFileName echo expand('%:t')
endif

" ============================================================
" End
" ============================================================
