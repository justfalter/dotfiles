
set nocompatible

set autoindent
set shiftwidth=2
set smarttab
set expandtab
set showmode
set showmatch
set ruler
set nojoinspaces
set cpo+=$
set whichwrap=""
set modelines=0
set nobackup
set encoding=utf-8
set wildmenu
let g:rubycomplete_rails = 1

let mapleader=','

" Hack to use old RE engine. New one is slow?
if version >= 704
  set re=1
end

" Disable stuff I'm not using.
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'confluencewiki')
call add(g:pathogen_disabled, 'rubytest.vim')
call add(g:pathogen_disabled, 'vim-rvm')
call add(g:pathogen_disabled, 'snipmate.vim')

" Give ourselves some room when scrolling around.
set scrolloff=5

" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off 
call pathogen#infect('bundle/{}')
call pathogen#helptags()

" Disable audible bell so I'm not embharassed to type when I've got the
" sound on.
set visualbell

" Manage buffers effectively.
" set hidden
set nohidden

" keep a longer history
set history=1000

" For when we aren't running in a GUI...
if !has("gui_running")
  " Set 256 colors
  set t_Co=256 
endif

set background=dark
"colorscheme desertEx
colorscheme vividchalk

"extended % matching
runtime macros/matchit.vim

set number

filetype plugin indent on
syntax enable
let detected_ruby_path = ""
if !empty($MY_RUBY_HOME)
  " This is from RVM
  let detected_ruby_path = $MY_RUBY_HOME
elseif !empty($RUBY_ROOT)
  " This is from chruby
  let detected_ruby_path = $RUBY_ROOT
endif 

" Check for RVM and jruby, and setup the ruby_path. This stops vim-ruby from having to
" call ruby to get the path, which slows things down horribly under jruby.
if !empty(matchstr(detected_ruby_path, 'jruby'))
  let g:ruby_path = join(split(glob(detected_ruby_path . '/lib/ruby/*.*')."\n" . glob(detected_ruby_path . '/lib/rubysite_ruby/*'),"\n"),',')
endif

" Don't be a whitespace jerk.
autocmd FileType,ColorScheme *
\ syntax match TrailingWhitespace /\s\+$/ |
\ highlight TrailingWhitespace cterm=underline gui=underline guifg=darkblue ctermfg=darkblue |
\ syntax match Tab /\t/ |
\ highlight Tab cterm=underline gui=underline guifg=darkgray ctermfg=darkgray

" ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" template language support (SGML / XML too)
" ------------------------------------------

autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufNewFile,BufRead *.nse setlocal ft=lua
autocmd BufNewFile,BufRead *.t setlocal ft=perl
" Threatinator feed files
autocmd BufNewFile,BufRead *.feed setlocal ft=ruby

" github flavored markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" json
let g:vim_json_syntax_conceal = 0
augroup json_autocmd 
  autocmd! 
  autocmd FileType json set autoindent 
  autocmd FileType json set formatoptions=tcq2l 
  autocmd FileType json set textwidth=78 shiftwidth=2 
  autocmd FileType json set softtabstop=2 tabstop=2 
  autocmd FileType json set expandtab 
  " autocmd FileType json set foldmethod=syntax 
augroup END

" CSS
" ---
autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Better Search
" -------------
set hlsearch
set incsearch

" This slows scrolling down a ton.
" set cursorline                   

if exists('+colorcolumn')
  " Show column 80, so I can know when to use the enter key.
  set colorcolumn=80
endif

" Tagbar
" --------
" Shove the tagbar onto the left.
let g:tagbar_left = 1
" Get rid of extra whitespace
let g:tagbar_compact = 1
" Autoclose tagbar after jumping
let g:tagbar_autoclose = 1

" File Browser
" ------------
" hide some files and remove stupid help
let g:explHideFiles='^\.,.*\.sw[po]$,.*\.pyc$'
let g:explDetailedHelp=0

" Builtin file browser
map <leader>b :Explore!<CR>

" NERDtree file browser is better
map <leader>nt :NERDTree 
" Locate the current file in NERDTree
map <leader>nf :NERDTreeFind<CR>
" Show dotfiles.
let NERDTreeShowHidden=1
" Close the tree when I open a file. 
let NERDTreeQuitOnOpen=1

map <TAB> 

" Run the current buffer as ruby code.
map <leader>rr :exe ':w !ruby'<CR>

" Run the current spec file.
map <leader>rs :exe ':!spec --format nested %'<CR>
map <leader>tt :let g:rubytest_in_quickfix = 0<CR><Plug>RubyTestRun
map <leader>tT :let g:rubytest_in_quickfix = 1<CR><Plug>RubyTestRun
map <leader>tf :let g:rubytest_in_quickfix = 0<CR><Plug>RubyFileRun
map <leader>tF :let g:rubytest_in_quickfix = 1<CR><Plug>RubyFileRun
map <leader>m :TagbarToggle<CR>

" Mapping so that I can easily change to the working directory of the
" current file.
map <leader>cd :cd %:p:h<CR>

" Fix indenting on the entire file.
map <leader>ai gg=G<CR>

" Git stuff
map <leader>gs :Gstatus
map <leader>gd :Gdiff
map <leader>gb :Gblame

" Stop GitGutter from re-running each time I switch tabs.
let g:gitgutter_eager = 0


" Snagged from http://www.daskrachen.com/2011/12/how-to-make-tagbar-work-with-objective.html
" add a definition for Objective-C to tagbar
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

" Enable autocompletion
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1

" vim-bookmark settings
let g:bookmark_highlight_lines = 1
highlight BookmarkLine term=reverse cterm=reverse gui=reverse
highlight BookmarkAnnotationLine term=reverse cterm=reverse gui=reverse

" hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
" hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
" hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'
" let g:svndiff_autoupdate = 1 
" 
" noremap <F3> :call Svndiff("prev")<CR>
" noremap <F4> :call Svndiff("next")<CR>
" noremap <F5> :call Svndiff("clear")<CR>

" Jump to closing brace by pressing "%"
noremap % v%

" TabMessage redirects output from a command into a new tab.
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  tabnew
  silent put=message
  set nomodified
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)


" Switching tabs
nmap <A-}> :tabn<CR>
nmap <A-{> :tabp<CR>

" Map a lot of keys such that copying/pasting/etc act like windows
source $VIMRUNTIME/mswin.vim
behave mswin

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
