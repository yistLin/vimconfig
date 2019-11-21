" Author: Yist Lin

set nocompatible  " required in VIM

" vim-plug {{{
call plug#begin('~/.vim/plugged')

" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim'

" Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'

" commentary.vim: comment stuff out
Plug 'tpope/vim-commentary'

" Optimized Solarized colorschemes. Best served with true-color terminals!
Plug 'lifepillar/vim-solarized8'

" Dark powered asynchronous completion framework for neovim/Vim8
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" A solid language pack for Vim 
Plug 'sheerun/vim-polyglot'

" Light & Dark color schemes inspired by Google Material's Design
Plug 'NLKNguyen/papercolor-theme'

" A modern vim plugin for editing LaTeX files.
Plug 'lervag/vimtex'

" An arctic, north-bluish clean and elegant Vim theme
Plug 'arcticicestudio/nord-vim'

" A dark theme for Vim
Plug 'dracula/vim'

" A vim plugin to display the indentation levels with thin vertical lines
Plug 'Yggdroot/indentLine'

" fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" vim-searchindex: display number of search matches & index of a current match
Plug 'google/vim-searchindex'

" *-Improved
Plug 'haya14busa/vim-asterisk'

" A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'

" A 24bit colorscheme for Vim, Airline and Lighline
Plug 'jacoborus/tender.vim'

" Adaptation of one-light and one-dark colorschemes for Vim
Plug 'rakr/vim-one'

call plug#end()
" }}}

" Plugin: Lightline {{{
let g:lightline = {
    \ 'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'readonly', 'filename', 'modified' ] ],
    \     'right': [ [ 'percent' ],
    \                [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \     'fileformat': 'LightlineFileformat',
    \     'filetype': 'LightlineFiletype',
    \     'fileencoding': 'LightlineFileencoding',
    \ },
    \ }

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? &fileencoding : ''
endfunction
" }}}

" Plugin: vimtex {{{
let g:polyglot_disabled = [ "latex" ]
let g:vimtex_compiler_progname = 'nvr'
call deoplete#custom#var('omni', 'input_patterns', {
    \ 'tex': g:vimtex#re#deoplete
    \ })
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim', 
    \ 'background' : 1,
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-latexoption="-shell-escape"',
    \   '-interaction=nonstopmode',
    \ ],
    \}
" }}}

" Plugin: indentLine {{{
let g:indentLine_char = '┊'
let g:indentLine_setConceal = 0
" }}}

" Plugin: UltiSnips {{{
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<C-k>"
let g:UltiSnipsJumpBackwardTrigger="<C-l>"
" }}}

" Plugin: vim-asterisk {{{
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
" }}}

" Plugin: NERDTree {{{
let g:NERDTreeWinPos = "right"
let g:NERDTreeQuitOnOpen = 1
" }}}

" Spaces & Tabs {{{
set autoindent     " copy indent when starting a new line
set expandtab      " expand tab to spaces
set smarttab       " insert 'tabstop' number of spaces pressing tab
set tabstop=4      " number of visual spaces a tab
set softtabstop=4  " number of spaces for a tab
set shiftwidth=4   " while shifting, indents will have a width of 4
set shiftround     " while shifting, round indentation to the nearest multiple of shiftwidth.
" }}}

" Colors {{{
syntax enable

" Detect whether shell is through Mosh or not
function! s:is_mosh()
    let output = system("is-mosh -v")
    if v:shell_error
        return 0
    endif
    return !empty(l:output)
endfunction

" Turn off 24-bits color when shell is through Mosh
function s:auto_termguicolors()
    if !(has("termguicolors"))
        return
    endif
    set termguicolors
    set background=dark
    " let g:one_allow_italics=1
    " colorscheme one
    " let g:lightline.colorscheme = "one"
    " let g:PaperColor_Theme_Options = {
    "   \     'theme': {
    "   \         'default.light': {
    "   \             'allow_italic': 1,
    "   \             'allow_bold': 1
    "   \         }
    "   \     }
    "   \ }

    " colorscheme PaperColor
    " let g:lightline.colorscheme = "PaperColor"

    let g:gruvbox_italic=1
    let g:gruvbox_contrast_dark="hard"
    colorscheme gruvbox
    let g:lightline.colorscheme = "gruvbox"
endfunction

call s:auto_termguicolors()
" }}}

" User Interface {{{
set number
set numberwidth=6
set showmatch     " highlight matching [{()}]
set laststatus=2  " display the status line
set noshowmode    " no need to show mode while using lightline
set noerrorbells  " disable beep on errors.
set visualbell    " flash the screen instead of beeping on errors
set showcmd       " show the last command entered in the bottom line
set wildmenu      " visual autocomplete for command menu
set wildignore=*.swp,*.bak,*.pyc,*.class
" }}}

" Text Rendering {{{
set fileencodings=utf8,big5,big5-hkscs,gbk,latin1
filetype on            " turn on filetype detection
filetype indent on     " load indent/example.vim
filetype plugin on     " load ftplugin/example.vim
set display+=lastline  " always display the last line
set wrap
set breakindent        " give indent to wrapped lines
set foldmethod=marker
set conceallevel=0
set scrolloff=3
set linebreak
" }}}

" Searching {{{
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
set smartcase  " switch to case-sensitive when search query contains an uppercase letter
" }}}

" Autogroups {{{
augroup configgroup

    " clean out all previous commands
    autocmd!

    " trim trailing spaces
    autocmd FileType c,cpp,python,javascript,html,tex autocmd BufWritePre <buffer> %s/\s\+$//e

    " set up filetype for special filetypes
    autocmd BufNewFile,BufRead *.ejs set filetype=html

    " jump to the last edited position
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " close the auto-completion windows when it is done
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

augroup END
" }}}

" Backup {{{
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Remapping {{{
let mapleader=","
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>h :noh<CR>

" mark a word as good and add it to my spellfile
nnoremap <leader>a zg

" toggle spell check
nnoremap <leader>s :setlocal spell! spell?<CR>

" toggle folding
nnoremap <leader>f zi

" vim-fugitive functions
nnoremap <leader>l :Gclog<CR>
nnoremap <leader>d :Gdiffsplit<CR>

" paste from yank register (won't be affected by default register)
map <leader>p "0p
map <leader>P "0P

" comment quickly with vim-commentary
nnoremap <leader>/ :Commentary<CR>
vnoremap <leader>/ :Commentary<CR>

" close quickfix
nnoremap <leader>c :ccl<CR>

" toggle folding by pressing space bar twice
nnoremap <silent><Space> za

" save/exit
map qq :q<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move half page up/down with j, k
nnoremap J 5j
nnoremap K 5k
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>

" create and move between tabs
nnoremap tp :tabprev<CR>
nnoremap tn :tabnext<CR>
nnoremap to :tabonly<CR>
nnoremap <expr> tt (v:count == 0 ? ":tabnew<CR>"   : ":<C-U>execute v:count 'tabnext'<CR>")
nnoremap <expr> tq (v:count == 0 ? ":tabclose<CR>" : ":<C-U>execute v:count 'tabclose'<CR>")
" }}}

" Miscellaneous Options {{{
set confirm         " display a confirmation dialog when closing an unsaved file
set encoding=utf-8  " set characters encoding
set autoread        " re-read files if it's written outside
set backspace=indent,eol,start
let g:tex_flavor = "latex"  " see .tex file as latex instead of plaintex
let g:tex_conceal = ''
" }}}

" Spell {{{
set spelllang=en
set spellfile=~/.config/nvim/spell/en.utf-8.add
" }}}
