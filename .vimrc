
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
call pathogen#helptags()
call pathogen#incubate()

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
map ,b :Explore!<CR>

" NERDtree file browser is better
map ,nt :NERDTree 
" Locate the current file in NERDTree
map ,nf :NERDTreeFind<CR>

map <TAB> 

" Run the current buffer as ruby code.
map ,rr :exe ':w !ruby'<CR>

" Run the current spec file.
map ,rs :exe ':!spec --format nested %'<CR>
map ,tt :let g:rubytest_in_quickfix = 0<CR><Plug>RubyTestRun
map ,tT :let g:rubytest_in_quickfix = 1<CR><Plug>RubyTestRun
map ,tf :let g:rubytest_in_quickfix = 0<CR><Plug>RubyFileRun
map ,tF :let g:rubytest_in_quickfix = 1<CR><Plug>RubyFileRun
map ,m :TagbarToggle<CR>

" Mapping so that I can easily change to the working directory of the
" current file.
map ,cd :cd %:p:h<CR>

" Fix indenting on the entire file.
map ,ai gg=G<CR>


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

hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'
let g:svndiff_autoupdate = 1 

noremap <F3> :call Svndiff("prev")<CR>
noremap <F4> :call Svndiff("next")<CR>
noremap <F5> :call Svndiff("clear")<CR>

" Jump to closing brace by pressing "%"
noremap % v%
