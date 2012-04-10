set nocompatible
call pathogen#runtime_append_all_bundles()

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" ---------------------------------
" Color Scheme
" ---------------------------------
if( has("gui_running") )
  colorscheme xoria256
  set guioptions=egmrt
  set guifont=Inconsolata:h18
  set transparency=0
  set fuopt+=maxhorz                      " grow to maximum horizontal width on entering fullscreen mode
endif

syntax on

set autoindent
set backspace=indent,eol,start
set binary
set ch=1
set clipboard=unnamed
set encoding=utf-8
set expandtab
set fileencodings=ucs-bom,utf-8,latin1,default
set foldenable
set formatoptions+=n
set gdefault
set grepformat=%f:%l:%m
set grepprg=ack
set guicursor=a:blinkon0
set hlsearch
set ignorecase
set incsearch
set isk+=_,$,@,%,#,-
set linespace=0
set mouse=a
set nolist
set nosmarttab
set nospell
set nostartofline
set notimeout
set nowrap
set number
set scrolljump=5
set scrolloff=3
set shiftround
set shiftwidth=2
set showcmd
set showmode
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitbelow
set splitright
set tabstop=2
set title
set titleold=
set ttimeout
set ttimeoutlen=20
set virtualedit=block
set visualbell t_vb=

" ---------------------------------
" Status Line
" ---------------------------------
set laststatus=2
set statusline+=%f
set statusline+=%=
set statusline+=%{SyntasticStatuslineFlag()}%*
set statusline+=\ [
set statusline+=%{strlen(&ft)?&ft:'none'}
set statusline+=]

set fo-=r

" highlight VCS conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

let loaded_matchparen = 1

set isk+=_,$,@,%,#,-
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·
set list

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

if has("gui")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif


set hidden
set nobackup
set nowritebackup
set noswapfile
set nobackup
set nowritebackup
set noswapfile

set showcmd "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

" Search *******************
set ignorecase " searches are case insensitive...
set smartcase  " ... unless they contain at least one capital letter

set hlsearch " highlight matches
set incsearch " incremental searching

set showmatch
set mat=5

" Code Folding *******************
set foldclose=
set foldmethod=syntax
set foldnestmax=2
set foldlevel=1
set fillchars=vert:\|,fold:\
set foldminlines=10
noremap <space> za

" ---------------------------------
" Mappings
" ---------------------------------
let mapleader = ","
nnoremap ; :

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

filetype on " Automatically detect file types
filetype plugin on
" new line creation with return
map <S-Enter> O<ESC>
map <Enter> o<ESC>

" indentation
vnoremap < <gv
vnoremap > >gv


" Movement ***********************
set nostartofline
set mouse=a

" Window Movement
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-q> <C-w>q

" Custom Hotkeys *****************
nmap <C-N><C-N> :set invnumber<CR>

nmap <leader>rc :Rcontroller<CR>
nmap <leader>rh :Rhelper<CR>
nmap <leader>rm :Rmodel<CR>
nmap <leader>rv :Rview .<CR>


" Splitting
nmap <leader>swh :topleft vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk :topleft new<CR>
nmap <leader>swj :botright new<CR>
nmap <leader>sh :leftabove vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove new<CR>
nmap <leader>sj :rightbelow new<CR>

" FuzzyFinder
map <leader>r :FufJumpList<CR>
map <leader>F :FufFile<CR>
map <leader>/ :FufFile **/<CR>
map <leader>f :FufFileWithCurrentBufferDir<CR>
map <leader>d :FufDir<CR>
map <leader>b :FufBuffer<CR>
 
map <leader>t :NERDTree<CR>

map <leader>j :Shell jshint % --config ~/.jshint.json<CR>
map <leader>g :Shell gjslint %<CR>
map <leader>. :Errors<CR>


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

" Close inactive (hidden) buffers
" http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers
" http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfunction
command! -nargs=* Only call CloseHiddenBuffers()

" quick access to running shell commands
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 

" ---------------------------------
" Plugins
" ---------------------------------

let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp'
let g:statline_show_encoding = 0

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_gjslint_conf = ' --custom_jsdoc_tags "module,method,requires,description"'
let g:syntastic_check_on_open=1

let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 2

let g:ctrlp_custom_ignore = { 'file': '\.eot$\|\.woff$\|\.svg$\|\.ttf$\|\.jpg$\|\.gif$\|\.png$' }

" ---------------------------------
" Auto Commands
" ---------------------------------
" Drupal
augroup drupal
  autocmd BufRead,BufNewFile *.php     set filetype=php.drupal
  autocmd BufRead,BufNewFile *.module  set filetype=php.drupal
  autocmd BufRead,BufNewFile *.install set filetype=php.drupal
  autocmd BufRead,BufNewFile *.inc     set filetype=php.drupal
  autocmd BufRead,BufNewFile *.test    set filetype=php.drupal
augroup END

autocmd BufNewFile,BufRead *.html.erb set ft=html.eruby.eruby-rails
autocmd BufNewFile,BufRead *.jst.coffee set ft=html



" set filetype
autocmd BufRead *.css.php  set filetype=css
autocmd BufRead *.less     set filetype=css
autocmd BufRead *.js.php   set filetype=javascript
autocmd BufRead *.js       set filetype=javascript
autocmd BufRead *.mkd      set filetype=mkd
autocmd BufRead *.markdown set filetype=mkd
autocmd BufRead *.god      set filetype=ruby
autocmd BufRead *.as       set filetype=actionscript

" set completion
autocmd FileType ruby       set omnifunc=rubycomplete#Complete
autocmd FileType python     set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
autocmd FileType c          set omnifunc=ccomplete#Complete

autocmd Filetype gitcommit set tw=68 spell

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

autocmd FileType php set keywordprg=pman
autocmd FileType php set iskeyword-=-

" java
autocmd FileType java set autoindent si sw=2 expandtab!

" actionscript
autocmd FileType actionscript set autoindent si sw=2

let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

let java_comment_strings=1
let java_highlight_java_lang_ids=1


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

