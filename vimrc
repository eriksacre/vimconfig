set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-rails'
Bundle 'croaky/vim-colors-github'
Bundle 'danro/rename.vim'
Bundle 'kchmck/vim-coffee-script'

scriptencoding utf-8
set shell=bash
filetype plugin indent on
runtime macros/matchit.vim
syntax on

set autoread
set autowrite
set wrap
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set number
set numberwidth=3
set autowrite
set splitbelow
set splitright
set incsearch

" kill trailing spaces when exiting file
" autocmd BufWritePre * :%s/\s\+$//e

let mapleader=","
nnoremap <leader>r :!ruby %<cr>
map <leader>ct :!ctags -R --exclude=.git<cr>

set laststatus=2
set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

map <Leader>ac :sp app/controllers/application_controller.rb<cr>
map <Leader>cr :sp config/routes.rb<cr>
map <Leader>cd :sp config/database.yml<cr>
map <Leader>sc :sp db/schema.rb<cr>
map <Leader>gem :sp Gemfile<cr>
map <Leader>bb :!bundle install<cr>
map <Leader>cn :e ~/coding-notes.txt<cr>
map <Leader>m :Rmodel 
map <Leader>mc :e app/models/concerns/
map <Leader>c :Rcontroller 
map <Leader>cc :e app/controllers/concerns/
map <Leader>v :Rview 
map <Leader>t :w<cr>:call RunCurrentTest()<cr>
map <Leader>dm :!bin/rake db:migrate<cr>
map <Leader>r :!bin/rake 
map <Leader>rr :!bin/rake routes<cr>
map <Leader>rn :!bin/rake notes<cr>
map <Leader>rt :!bin/rake test:all<cr>
map <Leader>rc :!COVERAGE=true bin/rake test:all && open coverage/index.html<cr>
map <Leader>rs :!bin/rake stats<cr>
map <Leader>, <C-w><C-w>
map <Leader>gm :!bin/rails g model 
map <Leader>gc :!bin/rails g controller 
map <Leader>gd :!bin/rails g migration 
map <Leader>gs :!git status<cr>
map <Leader>gac :!git add . && git commit -m ""<LEFT>
map <Leader>gp :!git push<cr>
vmap <Leader>gb :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
map <C-h> :nohl<cr>
map <C-s> <esc>:w<cr>
imap <C-s> <esc>:w<cr>

function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    call SetTestRunner("!bin/rake test")
  endif
  exec g:bjo_test_runner g:bjo_test_file
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

" TODO: Define rails_projections for easy access to fixtures, JS, CSS, ...
"
