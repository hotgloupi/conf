set nocompatible               " be iMproved
filetype off                   " required!
if has('neovim')
	let s:python_host_init = 'python -c "import neovim; neovim.start_host()"'
	let &initpython = s:python_host_init
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'jiangmiao/auto-pairs'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/Cpp11-Syntax-Support'
Bundle 'vim-scripts/DfrankUtil'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'vim-scripts/indentpython.vim'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/IndentTab'
Bundle 'vim-scripts/vimprj'

Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'davidhalter/jedi-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wting/rust.vim'
Bundle 'junegunn/seoul256.vim'
Plugin 'bling/vim-airline'

filetype plugin indent on
syntax on

if has("gui_macvim")
	set macmeta
endif

set hidden
let g:racer_cmd = "/home/raph/sandbox/racer/bin/racer"
let $RUST_SRC_PATH="/home/raph/sandbox/rust/src"

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
let g:ycm_confirm_extra_conf = 0

" -- Use home directory default directory
let g:ycm_global_ycm_extra_conf = $HOME

" -- ...
let g:ycm_autoclose_preview_window_after_completion = 1

" -- ...
let g:ycm_autoclose_preview_window_after_insertion = 1


"#############################################################################
" - jedi bundle ==============================================================

" Don't insert first autocomplete result
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0

"#############################################################################
" - FuzzyFinder bundle =======================================================

" -- Enable all modes
let g:fuf_modesDisable = []

" -- Exclude patterns
if has("python")
	python << EOF
patterns = [
    '.*~$',
    '.*\.(o|png|PNG|JPG|class|CLASS|jpg|exe|bak|sw[po])$',
    '_build',
    'deps',
    'build',
    'dependencies'
]
import vim
vim.command("let g:fuf_coveragefile_exclude = '%s'" % '|'.join(patterns))
EOF
let g:fuf_file_exclude = '\v' . g:fuf_coveragefile_exclude
endif



"#############################################################################
" - NerdTree bundle ==========================================================

" -- Toggle with F3
map <F3> <ESC>:NERDTreeToggle<CR>

" -- Ignore file patterns
let NERDTreeIgnore=['\.swp$', '\~$', '\.o$', '\.pyc$']

"#############################################################################
" - Vimprj bundle ============================================================

call vimprj#init()

" -- Do not change working directory
let g:vimprj_changeCurDirIfVimprjFound = 0

" -- Set vim file type
au BufNewFile,BufRead *.vimprj set ft=vim

" -- Called BEFORE sourcing .vimprj and when not sourcing
function! g:vimprj#dHooks['SetDefaultOptions']['main_options'](dParams)
	let g:vimprj_dir = substitute(a:dParams['sVimprjDirName'], '[/\\]\.vimprj$', '', '')

	if &ft == 'c' || &ft == 'cpp'
		":YcmCompleter ClearCompilationFlagCache
"		let g:clang_user_options = ''
"		if &ft == 'cpp'
"			let g:clang_user_options = '-std=c++11 -stdlib=libc++ -I' . $HOME . '/local/lib/clang/3.4/include/'
"		endif
"		let g:single_compile_options = '-O3 ' . g:clang_user_options
	endif
endfunction

" -- Called AFTER sourcing .vimprj and when not sourcing
function! g:vimprj#dHooks['OnAfterSourcingVimprj']['main_options'](dParams)
	unlet g:vimprj_dir
	if &ft == 'c' || &ft == 'cpp'

	endif
endfunction

"#############################################################################
" - Leader mapping ===========================================================

" -- Map leader key
let mapleader = "."
let g:mapleader = "."

" -- Fast saving with <leader>w
nmap <leader>w :w!<cr>
nnoremap <leader>d :YcmCompleter GoTo<CR>

" -- Search mappings:
" --- Clear search highlight with <leader>/
nmap <leader>/ :nohlsearch<cr>
" --- Fuzzy mode with <leader>/f
nmap <leader>/f :FufCoverageFile<cr>
" --- Recent mode <leader>/r
nmap <leader>/r :FufMruFile<cr>

nmap <leader>n :cnext<CR>
nmap <leader>p :cprevious<CR>

"#############################################################################
" - Jedi =====================================================================

let g:jedi#popup_on_dot = 0

"#############################################################################
" - clang-format =============================================================

" -- Map clang format
autocmd FileType c,cpp,objc map <C-K> :pyf $HOME/local/bin/clang-format.py<CR>
autocmd FileType c,cpp,objc imap <C-K> <c-o>:pyf $HOME/local/bin/clang-format.py<CR>

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

" -- Color scheme
"colorscheme trivial256
"colorscheme charged-256
"colorscheme ir_black
if has("gvim")
	set background=dark
	"colorscheme darkbone
	"colorscheme solarized
	colorscheme seoul256
else
	"	colorscheme gardener
	colorscheme seoul256
endif

" -- Darken whitespaces chars
hi SpecialKey ctermfg=darkgrey guifg=#222244 ctermbg=none gui=none cterm=none

" -- Highlight extra spaces and the end of line
hi clear RedundantSpaces
hi RedundantSpaces  ctermbg=Grey guibg=DarkBlue
match RedundantSpaces /\(\s\+$\| \+\ze\t\|\t\zs \+\)\(\%#\)\@!/

" -- Status line
"set statusline=%1*%F%m%r%h%w\ [%{&ff}][%Y]\ %=\ (%04l,\ %02v)\ [%p%%]\ %<
set statusline=%1*%F%m%r%h%w\ [%{&ff}][%Y]\ %{fugitive#statusline()}\ %=\ (%04l,\ %02v)\ [%p%%]\ %<
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
highlight clear CursorLine
hi CursorLine cterm=bold term=bold gui=bold

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
