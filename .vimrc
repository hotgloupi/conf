call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/indentpython.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/Cpp11-Syntax-Support'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"Plug 'jiangmiao/auto-pairs'
"Plug 'vim-scripts/DfrankUtil'
"Plug 'vim-scripts/FuzzyFinder'
"Plug 'vim-scripts/L9'
"Plug 'vim-scripts/IndentTab'
"Plug 'scrooloose/syntastic'
"Plug 'davidhalter/jedi-vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'junegunn/seoul256.vim'
"Plug 'junegunn/vim-easy-align'
"Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

filetype plugin indent on
syntax on

if has("gui_macvim")
    set macmeta
endif

set hidden

"#############################################################################
" - AutoPairs bundle =========================================================

" -- Global pairs
let g:AutoPairs =  {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

" -- Enable fly mode
let g:AutoPairsFlyMode = 0

"#############################################################################
" - Syntastic bundle =========================================================

" -- Check syntax on open
let g:syntastic_check_on_open = 1

" -- Auto jump to errors
"let g:syntastic_auto_jump = 1

" -- Update location list
let g:syntastic_always_populate_loc_list = 0

" -- Error symbols
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

"#############################################################################
" - YouCompleteMe bundle =====================================================

" -- Do not ask to load extra conf files.
"let g:ycm_confirm_extra_conf = 0
"
"" -- Use home directory default directory
""let g:ycm_global_ycm_extra_conf = $HOME
"
"" -- ...
"let g:ycm_autoclose_preview_window_after_completion = 1
"
"" -- ...
"let g:ycm_autoclose_preview_window_after_insertion = 0

"#############################################################################
" - vim-lsp ==================================================================

imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('/tmp/vim-lsp.log')
"let g:asyncomplete_log_file = expand('/tmp/asyncomplete.log')

" for asyncomplete.vim log
let g:lsp_async_completion = 1

if executable($NVIM_PYLS_BINARY)
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->[$NVIM_PYLS_BINARY]},
        \ 'whitelist': ['python'],
        \ })
endif

if executable($NVIM_CQUERY_BINARY)
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->[$NVIM_CQUERY_BINARY, '--language-server', '--log-file', '/tmp/cquery.log']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/spare/local/rlondeix/cquery-cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
      \ })
endif

"if executable($NVIM_CLANGD_BINARY)
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'clangd',
"        \ 'cmd': {server_info->[$NVIM_CLANGD_BINARY]},
"        \ 'whitelist': ['cpp', 'c'],
"        \ })
"endif

"#############################################################################
" - jedi bundle ==============================================================

" Don't insert first autocomplete result
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0
let g:jedi#force_py_version = 'auto'

"#############################################################################
" - FZF bundle ===============================================================

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'up': '~20%' }
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }
"let g:fzf_layout = { 'window': '10split enew' }
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"#############################################################################
" - NerdTree bundle ==========================================================

" -- Toggle with F3
map <F3> <ESC>:NERDTreeToggle<CR>

" -- Ignore file patterns
let NERDTreeIgnore=['\.swp$', '\~$', '\.o$', '\.pyc$']

"#############################################################################
" - easy-align bundle ========================================================

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"#############################################################################
" - Leader mapping ===========================================================

" -- Map leader key
let mapleader = "."
let g:mapleader = "."

" -- Fast saving with <leader>w
nmap <leader>w :w!<cr>
nnoremap <leader>d :LspDefinition<CR>
nnoremap <leader>r :LspReferences<CR>

" -- Search mappings:
" --- Clear search highlight with <leader>/
nmap <leader>/ :nohlsearch<cr>
" --- Fuzzy mode with <leader>/f
nmap <leader>/f :FzfFiles<cr>
" --- Recent mode <leader>/r
nmap <leader>/r :FzfHistory<cr>

nmap <leader>n :cnext<CR>
nmap <leader>p :cprevious<CR>

"#############################################################################
" - clang-format =============================================================

" -- Map clang format
autocmd FileType c,cpp,objc map <C-K> :pyf $NVIM_CLANG_FORMAT_SCRIPT_PATH<CR>
autocmd FileType c,cpp,objc imap <C-K> <c-o>:pyf $NVIM_CLANG_FORMAT_SCRIPT_PATH<CR>

"#############################################################################
" - Generic options ==========================================================

" -- Conceal feature required by clang_snippets
"set conceallevel=2
"set concealcursor=vin

" -- Complete options
set completeopt=menuone,longest,preview

" -- Limit popup menu height
set pumheight=15

" -- Show column
set colorcolumn=80

" -- Default encoding
set encoding=utf-8

" -- Remove short messages.
set shortmess=atI

" -- Automatically re-read modified files
set autoread

" -- Show whitespaces
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:_

" -- Remove trailing spaces
autocmd BufWrite * silent! %s/[\r \t]\+$//

" -- XXX
set modeline
set wildmenu
set number
set showmatch
set formatoptions=croql
set tabpagemax=200

" -- Do replace TAB with spaces
set expandtab

" -- Size of tabs and indentation are the same
set softtabstop=4
set shiftwidth=4
set tabstop=4

" -- Enable backup files
set backup

" -- History size
set history=5000

" -- Save temporary files elsewhere
set directory=~/.vim/swaps
set backupdir=~/.vim/backups

" -- Report cursor position
set ruler

" -- Remove all sound or visual error bell
if has("gui_macvim")
    " XXX on MacVim activating visual bell disables sound bell.-- ..
    set visualbell
else
    set noerrorbells
    set novisualbell
    set t_vb=
    set tm=500
endif

" At least 3 lines of context.
set scrolloff=3

" Show matching bracket
set showmatch

"#############################################################################
" - Indentation mode =========================================================

set cindent
set cino=(0,W4

"set smartindent
"set preserveindent
"set copyindent
"set autoindent

"#############################################################################
" - Navigation ===============================================================

" -- Force backspace to go backward, all the time.
set backspace=indent,eol,start
set backspace=2

" -- More natural vertical line move (when wrapped)
nnoremap <down> gj
nnoremap <up> gk

" -- Try to keep current column
"set nostartofline

"#############################################################################
" - Search options ===========================================================

" -- Highlight search terms...
set hlsearch
set incsearch " ...dynamically as they are typed.

" -- When both set, it's case insensitive unless a capital is found.
set ignorecase
set smartcase

"#############################################################################
" - Mouse options ============================================================

" -- Enable mouse
set mouse=a

" -- Hide the mouse pointer while typing
set mousehide

"#############################################################################
" - Tabs =====================================================================

" -- Open a new tab
nmap <C-t> :tabnew<CR>

" -- Go to next/previus tab with Shift + Left/Right
nmap <S-Right> <Esc>:tabnext<CR>
nmap <S-Left> <Esc>:tabprevious<CR>

nmap <S-h> <Esc>:silent! tabprevious<CR>
nmap <S-l> <Esc>:silent! tabnext<CR>

" -- Tab is an alias for next tab
nmap <Tab> <Esc>:tabnext<CR>

"#############################################################################
" - Gui options ==============================================================

" -- Enable toolbars and menus
set guioptions=
"set guioptions+=m
"set guioptions+=e
"set guioptions+=T
"set guioptions+=l "add left scrollbars
"set guioptions+=r "add left scrollbars
"set guioptions+=b "add bottom? scrollbars


" -- Font & colors
" Enable term with 256 colors
" For xterm, compile with flag --enable-256-color
" and add in ~/.profile :
"   set TERM xterm-256color; export TERM
if has("gui")
    " Make shift-insert work like in Xterm
    map! <S-Insert> <MiddleMouse>
    "map! <S-Insert> <MiddleMouse>
    if has("win32")
        set guifont=Lucida_Console:h10:cANSI
    elseif has("gui_macvim")
        set guifont=Monaco:h14
        "set noantialias
        " Start Full Screen
        set fuoptions=maxvert,maxhorz
        au GUIEnter * set fullscreen
    else
        "set guifont=Ubuntu\ Mono\ 12
        "set guifont=Monaco\ 10
        set guifont=Mono
    endif
    set t_Co=256
    set guitablabel=%M\ %t
else
    set t_Co=256
endif

" Only redraw at the end of the macro
set lazyredraw

" -- Color scheme
"colorscheme trivial256
"colorscheme charged-256
"colorscheme ir_black
if has("gvim")
    set background=dark
    colorscheme darkbone
    "colorscheme solarized
    "colorscheme seoul256
else
    "	colorscheme gardener
    "colorscheme seoul256
    colorscheme Monokai
endif

" -- Darken whitespaces chars
hi SpecialKey ctermfg=darkgrey guifg=#222244 ctermbg=none gui=none cterm=none

" -- Highlight extra spaces and the end of line
hi clear RedundantSpaces
hi RedundantSpaces  ctermbg=Grey guibg=DarkBlue
match RedundantSpaces /\(\s\+$\| \+\ze\t\|\t\zs \+\)\(\%#\)\@!/

" -- Status line
"set statusline=%1*%F%m%r%h%w\ [%{&ff}][%Y]\ %=\ (%04l,\ %02v)\ [%p%%]\ %<
"set statusline=%1*%F%m%r%h%w\ [%{&ff}][%Y]\ %{fugitive#statusline()}\ %=\ (%04l,\ %02v)\ [%p%%]\ %<
set laststatus=2

hi clear User1
hi User1 cterm=none gui=none
hi User1 ctermbg=Black ctermfg=white guibg=#121288 guifg=#8888ee

hi clear StatusLine
hi StatusLine cterm=bold gui=bold ctermfg=Black guifg=Black ctermbg=red guibg=#882200

hi clear StatusLineNC
hi StatusLineNC cterm=reverse,underline gui=reverse,underline
"hi StatusLineNC guibg=Black ctermbg=Black guifg=LightGray ctermfg=LightGray

" -- Highlight characters when their column position is greater than 80 col
"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" -- Highlight current line
set cursorline
"highlight clear CursorLine
"hi CursorLine cterm=bold term=bold gui=bold

" -- Tabs colors
hi clear TabLine TabLineSel TabLineFill
hi TabLine ctermbg=LightBlue ctermfg=Black guibg=LightBlue guifg=Black
hi TabLineSel cterm=reverse ctermbg=DarkBlue cterm=bold gui=bold,reverse guibg=DarkBlue
hi TabLineFill cterm=none term=none gui=None guibg= LightBlue ctermbg=LightBlue


" -- Map F5 to make command
map <F5> :make<CR><CR>:cw<CR>

" -- Next/Previous error with Shift + Up/Down
nmap <S-Down> :cn<cr>
nmap <S-Up> :cp<cr>

" -- Auto append bracket :
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" -- Save with sudo permissions with !!w
cmap !!w w !sudo tee % >/dev/null

if has("win32")
    source c:\Program\ Files\ (x86)\Vim\_vimrc
endif

set clipboard+=unnamedplus


" C++ filetype
au FileType cpp,objcpp set syntax=cpp11
au BufNewFile,BufRead *
\ if expand('%:e') =~ '^\(py++\|h\|hh\|hxx\|hpp\|ii\|ixx\|ipp\|inl\|txx\|tpp\|tpl\|cc\|cxx\|cpp\)$' |
\   if &ft != 'cpp'                                                                                 |
\     set ft=cpp                                                                                    |
\   endif                                                                                           |
\ endif                                                                                             |

if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif

set termguicolors
"set guicursor=

