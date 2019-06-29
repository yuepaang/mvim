if &compatible
  set nocompatible
endif

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | nested source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
  " NerdTree
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeVCS', 'NERDTreeToggle'] }
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeVCS', 'NERDTreeToggle'] }
  Plug 'low-ghost/nerdtree-fugitive', { 'on': ['NERDTreeVCS', 'NERDTreeToggle'] }
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeVCS', 'NERDTreeToggle'] }
  Plug 'ivalkeen/nerdtree-execute', { 'on': ['NERDTreeVCS', 'NERDTreeToggle'] }

  Plug 'Yggdroot/LeaderF', {'branch': 'master', 'do': './install.sh'}
  Plug 'Yggdroot/LeaderF-marks', {'branch': 'master'}

  " vim support
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'

  Plug 'ncm2/ncm2'
  Plug 'ncm2/ncm2-tagprefix'
  Plug 'ncm2/ncm2-gtags'
  Plug 'ncm2/ncm2-bufword'
  Plug 'fgrsnau/ncm2-otherbuf'
  Plug 'ncm2/ncm2-path'
  Plug 'ncm2/ncm2-tagprefix'
  Plug 'filipekiss/ncm2-look.vim'
  Plug 'ncm2/ncm2-github'
  Plug 'Shougo/neco-syntax' | Plug 'ncm2/ncm2-syntax'
  Plug 'Shougo/neoinclude.vim' | Plug 'ncm2/ncm2-neoinclude'
  Plug 'ncm2/ncm2-pyclang', { 'for': ['c', 'cpp'] }
  Plug 'ncm2/ncm2-racer', { 'for': 'rust' }
  Plug 'ncm2/ncm2-go', { 'for': 'go' }
  Plug 'ncm2/ncm2-html-subscope', { 'for': 'html' }
  Plug 'ncm2/ncm2-jedi', {'for': 'python'}
  Plug 'ncm2/ncm2-markdown-subscope', { 'for': 'markdown' }
  Plug 'Shougo/neco-vim', { 'for': 'vim' } | Plug 'ncm2/ncm2-vim', { 'for': 'vim' }
  Plug 'ncm2/ncm2-ultisnips'

  " LSP
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

  " ALE
  Plug 'w0rp/ale'

  " Ultisnips
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  Plug 'jiangmiao/auto-pairs'
  Plug 'machakann/vim-highlightedyank'
  Plug 'mg979/vim-visual-multi'
  Plug 'sbdchd/neoformat'
  Plug 'Yggdroot/indentLine'

  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  Plug 'Shougo/echodoc.vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-surround'
  Plug 'heavenshell/vim-pydocstring'
  Plug 'sbdchd/neoformat'
  Plug 'ryanoasis/vim-devicons'

  " Lightline
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'macthecadillac/lightline-gitdiff'
  Plug 'maximbaz/lightline-ale'

  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/rainbow_parentheses.vim'

  Plug 'NLKNguyen/papercolor-theme'
  Plug 'endel/vim-github-colorscheme'

call plug#end()

for rcfile in split(globpath("~/mvim/rc", "*.vim"), '\n')
	execute('source '.rcfile)
endfor

" ================================
"    Plugins configuration
" ===============================
" Color theme
let g:lightline = {}
if &diff
    colorscheme github
else
    colorscheme PaperColor
endif

let g:lightline = { 'colorscheme': 'PaperColor' }
if strftime('%H') >= 7 && strftime('%H') < 18
  set background=light
else
  set background=dark
endif

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" echodoc
set noshowmode
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" neoformat
let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']

" Python Docstring
" nmap <silent> <C-d> <Plug>(pydocstring)
nmap <silent> <leader>pd <Plug>(pydocstring)

" 打开文件自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

fun! VM_Start()
  HighlightedyankOff
endfun

fun! VM_Exit()
  HighlightedyankOn
endfun


function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1)
  echom s:uri
  if s:uri != ""
    silent exec "!open '".s:uri."'"
    :redraw!
  else
    echo "No URI found in line."
  endif
endfunction

nnoremap <leader>oc :call HandleURL()<CR>¬
