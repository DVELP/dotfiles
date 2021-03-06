" --------------------
" PACKAGES
" --------------------
" ale
let g:ale_linters = {
\ 'javascript': []
\ }
let g:ale_ruby_rails_best_practices_executable = 'bundle'
let g:ale_ruby_rubocop_executable = 'bundle'

nmap <silent> [r <Plug>(ale_previous_wrap)
nmap <silent> ]r <Plug>(ale_next_wrap)

set updatetime=1000
autocmd CursorHold * call ale#Lint()
autocmd CursorHoldI * call ale#Lint()
autocmd InsertLeave * call ale#Lint()
autocmd TextChanged * call ale#Lint()
let g:ale_lint_on_text_changed = 0

" airLine
set laststatus=2
let g:airline_theme = 'bubblegum'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline#extensions#syntastic#enabled = 1
let g:airline_section_b = "%f%m"
let g:airline_section_c = "%{fugitive#head()}" "display git branch
let g:airline_section_z = '%3l:%3v'

" ctrlp
" use silver_searcher for lookup
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
endif
let g:ctrlp_use_caching = 0
set timeoutlen=500 " reduce wait time for amigigous chars

" jshint
" only check syntax on write
let JSHintUpdateWriteOnly = 1

" rspec
let g:rspec_command = "VtrSendCommandToRunner! rspec {spec}"

" silver_searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" --------------------
" APPEARANCE
" --------------------
syntax enable
colorscheme solarized
" switch background
if has('gui_running')
  set background=light
else
  set background=dark
endif

" make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" --------------------
" CONFIG
" --------------------
imap <c-space> <c-x><c-o>
let g:bufferline_echo = 0 " don't show standard budder

" disable the arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" map semi-colon to colon
nnoremap ; :
filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins
set autoindent
set backspace=indent,eol,start " backspace for dummys
set backupdir=/tmp/
set complete+=kspell
set directory=/tmp " don't clutter my dirs up with swp and tmp files
set et|retab
set encoding=utf-8
set expandtab
set grepprg=ag " use sliver_searcher instead of grep
set gdefault " assume the /g flag on :s substitutions to replace all matches
set incsearch
set laststatus=2  " always show status line.
set list " use :set list! to toggle visible whitespace on/off
set listchars=nbsp:¬,tab:>-,trail:•,extends:➮
set modeline " bash-like filenames completion
set nobackup
set nowritebackup
set noerrorbells " disable vim error noise
set noshowmode "hide default vim mode
set noswapfile " diable swap file
set nocompatible
set number
set numberwidth=5
set history=50
set relativenumber
set ruler
set shiftwidth=2
set showcmd " display incomplete commands
set smartcase " searching
set smarttab
set tabstop=2
set wildignore+=tmp/** " ignore stuff that can't be opened
set wildmode=longest,full
set wildmenu
:setlocal spell spelllang=en_gb

" --------------------
" GIT
" --------------------
autocmd Filetype gitcommit setlocal spell textwidth=72 " format commit

" --------------------
" MAPPINGS
" --------------------
let mapleader = ","

" navigate displayed lines rather than physical lines
noremap j gj
noremap k gk

" vim-tmux-runner
nnoremap <Leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>
nnoremap <Leader>sf :VtrSendFile<cr>
nnoremap <Leader>sl :VtrSendLinesToRunner<cr>

map <Leader>a :call RunAllSpecs()<cr>
map <Leader>bb :!bundle install<cr>
map <Leader>e :w<cr>:Explore<cr>
map <Leader>f :Ack<space>
map <Leader>fc :Ack <C-R><C-W><cr>
map <Leader>gw :!git add . && git commit -m 'WIP' && git push<cr>
map <Leader>l :call RunLastSpec()<cr>
map <Leader>q :copen<cr>
map <Leader>p :set paste<cr><esc>"*]p:set nopaste<cr>
map <Leader>ra :%s/
map <Leader>s :call RunNearestSpec()<cr>
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>sl :sort<cr>
map <Leader>t :call RunCurrentSpecFile()<cr>
map <Leader>u :Eunittest<cr>
map <Leader>v :vsp<cr>
map <Leader>vi :tabe ~/Dropbox/dotfiles/.vimrc<cr>

" rename current file - thanks Gary Bernhardt
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<cr>
