"sudo apt-get install vim-gtk3
set nocompatible
set nu 
set tabstop=4
set shiftwidth=4
set expandtab
set shiftwidth=4
set smartindent
set hls is
set autoindent 
set nu
syntax on
colorscheme Test
set completeopt=longest,menuone


filetype plugin on 

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'Valloric/YouCompleteMe', {'do':'python3 install.py --clang-completer --java-completer','for':['cpp','java','c']}
Plug 'davidhalter/jedi-vim', {'for':['python']}
Plug 'ervandew/supertab', {'for':['python']}
Plug 'tpope/vim-surround'
Plug 'sirver/UltiSnips'
Plug 'honza/vim-snippets'
call plug#end()

function! CppSettings()
    nnoremap <F5> :w!<Enter> :!g++ %<CR> :!./a*<CR>
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    let g:ycm_extra_conf_vim_data = ['&filetype']
endfunc
autocmd FileType cpp call CppSettings()

function! CSettings()
    nnoremap <F5> :w!<Enter> :!gcc % -lm<CR> :!./a*<CR>
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    let g:ycm_extra_conf_vim_data = ['&filetype']
endfunc
autocmd FileType c call CSettings()

function! PythonSettings()
    nnoremap <F5> :w!<Enter> :!python3 %<CR>
    let g:SuperTabDefaultCompletionType = "<C-x><C-O>"
    let g:jedi#auto_initialization = 1
    let g:ycm_python_binary_path = 'python3'
endfunc
autocmd FileType python call PythonSettings()


inoremap {<CR> {<CR>}<C-o>O
inoremap <S-Tab> <C-d>

xnoremap <c-y> "+y
nnoremap <c-y> "+p

runtime! ftplugin/man.vim
tnoremap <Esc> <C-\><C-n>

"ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f cpp /usr/include/c++/7
