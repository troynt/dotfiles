set nocompatible

call pathogen#runtime_append_all_bundles()

function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Auto-apply .vimrc settings after saving
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" View **********************
syntax on
set number
set guicursor=a:blinkon0
set visualbell t_vb=
set nospell

set laststatus=2
set ruler
set rulerformat=%25(%n%m%r:\ %Y\ [%l,%v]\ %p%%%)
let g:rails_statusline=0

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default

autocmd FileType html set filetype=xhtml
autocmd BufRead *.css.php set filetype=css
autocmd BufRead *.less set filetype=css
autocmd BufRead *.js.php set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
autocmd BufRead *.mkd set filetype=mkd
autocmd BufRead *.markdown set filetype=mkd
autocmd BufRead *.god set filetype=ruby
autocmd BufRead *.as set filetype=actionscript

autocmd FileType python set omnifunc=pythoncompleteComplete
autocmd FileType javascript set omnifunc=javascriptcompleteCompleteJS
autocmd FileType html set omnifunc=htmlcompleteCompleteTags
autocmd FileType css set omnifunc=csscompleteCompleteCSS
autocmd FileType xml set omnifunc=xmlcompleteCompleteTags
autocmd FileType php set omnifunc=phpcompleteCompletePHP
autocmd FileType c set omnifunc=ccompleteComplete

" Enable spellchecking on git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

" Erb
augroup eruby
  autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby
augroup end

" Drupal
augroup drupal
  autocmd BufRead,BufNewFile *.php set filetype=php
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.inc set filetype=php
  autocmd BufRead,BufNewFile *.test set filetype=php
augroup END

let php_sql_query=1
let php_htmlInStrings=1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

set completeopt=longest,menu
set wildmode=list:longest,list:full
set wildmenu
set complete=.,t
"set wildignore=*~


set showcmd "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

" Indentation ********************
set autoindent
set smartindent
set smarttab
set tabstop=4 
set shiftwidth=2
set softtabstop=2
set expandtab


" Buffers ************************
set hidden
set nobackup
set nowritebackup
set noswapfile


" Search ************************* 
set ignorecase
set hlsearch
set incsearch

" Code Folding *******************
set foldclose=
set foldmethod=syntax
set foldnestmax=2
set foldlevel=1
set fillchars=vert:\|,fold:\
set foldminlines=10
noremap <space> za

" Editing ************************
set backspace=indent,eol,start
map <S-Enter> O<ESC>
map <Enter> o<ESC>

set fo-=r

let loaded_matchparen = 1

autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

filetype on " Automatically detect file types
filetype plugin on

set listchars=tab:▸\ ,eol:¬


" Movement ***********************
set nostartofline
set mouse=a

" DVORAK
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-q> <C-w>q




" Custom Hotkeys *****************
let mapleader = ","
nmap <C-N><C-N> :set invnumber<CR>

nmap <leader>rc :Rcontroller<CR>
nmap <leader>rh :Rhelper<CR>
nmap <leader>rm :Rmodel<CR>
nmap <leader>rv :Rview .<CR>


" splitting
nmap <leader>swh  :topleft  vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk    :topleft  new<CR>
nmap <leader>swj  :botright new<CR>
nmap <leader>sh   :leftabove  vnew<CR>
nmap <leader>sl  :rightbelow vnew<CR>
nmap <leader>sk     :leftabove  new<CR>
nmap <leader>sj   :rightbelow new<CR>

map <leader>F :FufFile<CR>
map <leader>/ :FufFile **/<CR>
map <leader>f :FufFileWithCurrentBufferDir<CR>
map <leader>d :FufDir<CR>
map <leader>b :FufBuffer<CR>
map <leader>cd :cd %:p:h<CR>
map <leader>p "0p

map <leader>t :NERDTree<CR>

map <leader>j :Shell jshint % --config ~/.jshint.json<CR>

nnoremap Y y$

MapToggle <F1> hlsearch
MapToggle <F2> wrap
MapToggle <F3> number

:vnoremap < <gv
:vnoremap > >gv

function! InsertTabWrapper()
  let line = getline('.')                         " curline
  let substr = strpart(line, -1, col('.')+1)      " from start to cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize ' . line('$')
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
  silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)


" Plugin Settings ****************
let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp'


" GUI Settings *******************
if has("gui_running")
  let g:zenesque_colors=3
  set guioptions=egmrt
  set guifont=Dejavu_Sans_Mono:h14
  colorscheme zenesque

  set lines=40 columns=120

  set go-=T
  set go-=r
endif

