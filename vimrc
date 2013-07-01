set nocompatible
execute pathogen#infect()
filetype plugin on

" ---------------------------------
" UI
" ---------------------------------

set t_Co=256
syntax on
colorscheme jellybeans
set background=light
set title
set titleold=
set nonumber
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set visualbell t_vb=
set mouse=a
set showcmd
set showmode
set ch=1
set grepprg=ack
set grepformat=%f:%l:%m
set binary
set autoindent
set copyindent
set smartindent
set smarttab
set guicursor=a:blinkon0
set nowrap
set backspace=indent,eol,start
set nospell
set linespace=0
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set nosmarttab
set formatoptions=1
set linebreak
set breakat=\ |@-+;:,./?^I
set virtualedit=block
set isk+=_,$,@,%,#,-
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set foldenable
set nostartofline
set scrolljump=5
set scrolloff=3
set splitbelow
set splitright
set ttimeout
set ttimeoutlen=20
set notimeout
if system('uname') =~ 'Linux'
  set clipboard=unnamed
  set guioptions-=T
endif

set laststatus=2
set statusline+=%f
set statusline+=%=
set statusline+=%{SyntasticStatuslineFlag()}%*
set statusline+=\ [
set statusline+=%{strlen(&ft)?&ft:'none'} "
set statusline+=]

set fo-=r

" resize splits when window is resized
au VimResized * exe "normal! \<c-w>="


" ---------------------------------
" Completion
" ---------------------------------

set completeopt=longest,menuone,preview
set wildmode=list:longest,list:full

set wildignore+=*/.hg,*/.git,*/.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc
set wildignore+=*.sw?
set wildignore+=.DS_Store

set wildmenu
set complete=.,t
"set wildignore=*~


" ---------------------------------
" Buffers
" ---------------------------------

set hidden
set nobackup
set nowritebackup
set noswapfile

if has("undofile")
  set undofile
  set undodir=~/.undo
end


" ---------------------------------
" Mappings
" ---------------------------------

let mapleader = ","
nnoremap ; :

" code folding
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" cd to current file's directory
nmap <leader>cd %:p:h

" feature toggles
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <F1> hlsearch
MapToggle <F2> wrap
MapToggle <F3> number
MapToggle <F4> paste

" new line creation with return
map <S-Enter> O<ESC>
map <Enter> o<ESC>

" indentation
vnoremap < <gv
vnoremap > >gv

" window splitting
nmap <leader>swh :topleft vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk :topleft new<CR>
nmap <leader>swj :botright new<CR>
nmap <leader>sh :leftabove vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove new<CR>
nmap <leader>sj :rightbelow new<CR>

" window movement
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-q> <C-w>q

map <leader>/ :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
map <leader>t :NERDTreeToggle<CR>
 
nnoremap Y y$

" syncit command for local VM work
map <C-U> :!syncit<CR>

" insert mode completion
inoremap <C-L> <C-X><C-L>
inoremap <C-F> <C-X><C-F>

" quick access to ack
map <leader>a :Ack 

" Ex Mode is annoying. 
" Use this for formatting instead.
map Q gq

" Save even if we forgot to open the file with sudo
cmap w!! %!sudo tee > /dev/null %

" ---------------------------------
" Plugins
" ---------------------------------

let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp'
let g:statline_show_encoding = 0

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']

let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_custom_ignore = { 'file': '\.eot$\|\.woff$\|\.svg$\|\.ttf$\|\.jpg$\|\.gif$\|\.png$' }

" ---------------------------------
" Auto Commands
" ---------------------------------

" set filetype
autocmd BufRead *.css.php set filetype=css
autocmd BufRead *.less set filetype=css
autocmd BufRead,BufNewFile *.scss set filetype=scss
autocmd BufRead *.js.php set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
autocmd BufRead *.md set filetype=mkd
autocmd BufRead *.mkd set filetype=mkd
autocmd BufRead *.markdown set filetype=mkd
autocmd BufRead *.god set filetype=ruby
autocmd BufRead *.as set filetype=actionscript
autocmd BufRead *.sls set filetype=yaml
autocmd BufRead,BufNewFile *.go set filetype=go

" set completion
autocmd FileType ruby set omnifunc=rubycomplete#Complete ts=4 sts=2 sw=2 expandtab
autocmd FileType python set omnifunc=pythoncomplete#Complete ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript setlocal nocindent
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags ts=4 sts=4 sw=4 expandtab
autocmd FileType css,scss set omnifunc=csscomplete#CompleteCSS ts=4 sts=4 sw=4 expandtab
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags ts=4 sts=4 sw=4 expandtab
autocmd FileType php set omnifunc=phpcomplete#CompletePHP iskeyword-=- ts=4 sts=4 sw=4 keywordprg=pman expandtab
autocmd FileType c set omnifunc=ccomplete#Complete ts=4 sts=4 sw=4 expandtab
autocmd FileType bash,zsh,sh set ts=4 sts=4 sw=4 expandtab
autocmd FileType go set ts=4 sts=4 sw=4 noexpandtab

autocmd Filetype gitcommit set tw=68 spell


" ---------------------------------
" OS X Stuff
" ---------------------------------

if system('uname') =~ 'Darwin'
  let $PATH = $HOME .
    \ '/usr/local/bin:/usr/local/sbin:' .
    \ '/usr/pkg/bin:' .
    \ '/opt/local/bin:/opt/local/sbin:' .
    \ $PATH
endif

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
