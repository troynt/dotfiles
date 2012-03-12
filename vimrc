set nocompatible
set grepprg=ack
set grepformat=%f:%l:%m
set list
call pathogen#runtime_append_all_bundles()

" ---------------------------------
" Helpers
" ---------------------------------
function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  silent! execute winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
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


" Toggles options
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Open url on the current line in browser
function! Browser()
  let line0 = getline(".")
  let line = matchstr(line0, "http[^ )]*")
  let line = escape(line, "#?&;|%")
  exec ':silent !open ' . "\"" . line . "\""
endfunction

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

" Quickly switch between .h and .m files
function! Switch()
  if expand('%:e') == 'h'
    try | find %:t:r.m 
    catch
      try | find %:t:r.c
      catch
        try | find %:t:r.cc
        catch
          try | find %:t:r.cpp | catch | endtry
        endtry
      endtry
    endtry
  else
    find %:t:r.h
endif
endfunction
command! Switch call Switch()


" ---------------------------------
" Text Formatting
" ---------------------------------
" Indentation ********************
set autoindent
set smartindent
set smarttab
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set formatoptions+=n
set virtualedit=block

" ---------------------------------
" Color Scheme
" ---------------------------------
if( has("gui_running") )
  colorscheme xoria256
  set guifont=Inconsolata:h18
  set transparency=0
  set fuopt+=maxhorz                      " grow to maximum horizontal width on entering fullscreen mode
endif
" ---------------------------------
" UI
" ---------------------------------
syntax on
set number
set guicursor=a:blinkon0
set visualbell t_vb=
set nospell
set nostartofline
set mouse=a
set backspace=indent,eol,start
set laststatus=2
set ch=2
set ruler
set rulerformat=%25(%n%m%r:\ %Y\ [%l,%v]\ %p%%%)
let g:rails_statusline=0

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default

set isk+=_,$,@,%,#,-
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·

autocmd FileType python set omnifunc=pythoncompleteComplete
autocmd FileType javascript set omnifunc=javascriptcompleteCompleteJS
autocmd FileType html set omnifunc=htmlcompleteCompleteTags
autocmd FileType css set omnifunc=csscompleteCompleteCSS
autocmd FileType xml set omnifunc=xmlcompleteCompleteTags
autocmd FileType php set omnifunc=phpcompleteCompletePHP
autocmd FileType c set omnifunc=ccompleteComplete

" Enable spellchecking on git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
  set lines=40 columns=120

" Drupal
augroup drupal
  autocmd BufRead,BufNewFile *.php set filetype=php.drupal
  autocmd BufRead,BufNewFile *.module set filetype=php.drupal
  autocmd BufRead,BufNewFile *.install set filetype=php.drupal
  autocmd BufRead,BufNewFile *.inc set filetype=php.drupal
  autocmd BufRead,BufNewFile *.test set filetype=php.drupal
augroup END

" set filetype
autocmd FileType html set filetype=xhtml
autocmd BufRead *.css.php set filetype=css
autocmd BufRead *.less set filetype=css
autocmd BufRead *.js.php set filetype=javascript
autocmd BufRead *.json set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
autocmd BufRead *.mkd set filetype=mkd
autocmd BufRead *.markdown set filetype=mkd
autocmd BufRead *.god set filetype=ruby
autocmd BufRead *.as set filetype=actionscript

autocmd BufNewFile,BufRead *.php set ft=php.html

autocmd BufNewFile,BufRead *.html.erb set ft=html.eruby.eruby-rails
autocmd BufNewFile,BufRead *.jst.coffee set ft=html

" set completion
"autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" java
autocmd FileType java set autoindent
autocmd FileType java set si
autocmd FileType java set shiftwidth=2
autocmd FileType java set expandtab!

" actionscript
autocmd FileType actionscript set autoindent
autocmd FileType actionscript set si
autocmd FileType actionscript set shiftwidth=2


let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

let java_comment_strings=1
let java_highlight_java_lang_ids=1

" ---------------------------------
" Completion
" ---------------------------------

set completeopt=longest,menu
set wildmode=list:longest,list:full
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


" ---------------------------------
" Buffers
" ---------------------------------
set hidden

" ---------------------------------
" Visual Cues
" ---------------------------------
set showcmd "show incomplete cmds down the bottom
set showmode "show current mode down the bottom

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

" feature toggles
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
nmap <leader>swh  :topleft  vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk    :topleft  new<CR>
nmap <leader>swj  :botright new<CR>
nmap <leader>sh   :leftabove  vnew<CR>
nmap <leader>sl  :rightbelow vnew<CR>
nmap <leader>sk     :leftabove  new<CR>
nmap <leader>sj   :rightbelow new<CR>

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


" open a url on the current line in browser
map ,w :call Browser()<CR>

" Save even if we forgot to open the file with sudo
cmap w!! %!sudo tee %


" Ex Mode is annoying. 
" Use this for formatting instead.
map Q gq


" ---------------------------------
" Plugins
" ---------------------------------
let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp|\.o$|\.exe$|\.bak$|\.swp|\.class$'
let g:syntastic_gjslint_conf = ' --custom_jsdoc_tags "module,method,requires,description"'
