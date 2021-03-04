let mapleader=' '
set t_Co=256
syntax enable " Enable syntax processing
set tabstop=4 " Number of spaces per tab (When opening file)
set softtabstop=4 " Number of spaces shown when editing
set expandtab " Converts tabs into spaces
set showcmd " Show command in bottom bar
set cursorline " Highlights the current line
filetype indent on " Loads filetype specific indent files from ~/.vim/indent/*
set wildmenu " Visual autocomplete for command line
set showmatch " Highlight matching brackets/parentheses/etc

set hls " Highlight search matches
set incsearch " Search as you are typing 
set ignorecase " Ignore case when searching
set smartcase " If searching and use capital letter, search becomes case sensitive

set shiftwidth=4 " Auto indents are 4 spaces
set autoindent " Turn on auto-indent
set smartindent " Smart indent like in VSCode
set relativenumber " Relative line numbers
set nu " Display the absolute line number next to relative line number
set backspace=indent,eol,start
" Performance cost :(
set updatetime=100
set foldmethod=syntax
set foldlevelstart=3
set signcolumn=yes

set hidden

set autoread " Auto update file if changed by external source
set noerrorbells " No bell sounds
set nowrap " Don't auto wrap the text if it overflows

set scrolloff=8 " Scroll up and down when within 8 lines of the top or bottom of the screen
set sidescrolloff=30
set colorcolumn=120 " 120 Character column. Helpful for long lines


" Plugins
call plug#begin('~/.config/nvim/plugged')

" Syntax
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File system
Plug 'scrooloose/nerdtree'

" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Auto expand html tags
Plug 'mattn/emmet-vim'

" Comments
Plug 'tpope/vim-commentary'

" Bracket, parentheses, etc
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" Documentation generator
Plug 'kkoomen/vim-doge'

" Themes
Plug 'morhetz/gruvbox'

" Git stuff
Plug 'Xuyuanp/nerdtree-git-plugin' " Specifically for nerdtree
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

call plug#end()

set background=dark
colorscheme gruvbox
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'
let g:user_emmet_settings = {
    \'javascript.jsx' : {
        \'extends' : 'jsx',
    \},
\}

" FORMATTERS
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType typescript.tsx setlocal formatprg=prettier\ --parser\ typescript
au FileType typescriptreact setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

let g:python3_host_prog = '/usr/bin/python3'
let g:coc_disable_startup_warning = 1
nnoremap <Enter> :noh<return><Enter>

" Configuring coc
let g:coc_global_extensions = [
            \ 'coc-pyright',
            \ 'coc-json',
            \ 'coc-html',
            \ 'coc-emmet',
            \ 'coc-tsserver',
            \ 'coc-prettier',
            \ 'coc-css',
            \ 'coc-snippets'
            \]

" Go to definition
nmap <silent> gd <Plug>(coc-definition)
" Go to class definition
nmap <silent> gy <Plug>(coc-type-definition)
" Find everywhere the hovered keyword is used
nmap <silent> gr <Plug>(coc-references)
" Go to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Rename
nmap <leader>rn <Plug>(coc-rename)

" Tab expansion for coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Open autocomplete when pressing ctrl space
inoremap <silent><expr> <c-space> coc#refresh()

" Press K to show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Auto show documentation if no diagnostics on hovered word
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction
autocmd CursorHoldI * :call <SID>show_hover_doc()

" Go to prev/next diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Activate linters if installed in node modules
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Autocomplete on enter
if exists('*complete_info')
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Highlights symbol under cursor and any references
autocmd CursorHold * silent call CocActionAsync('highlight')

" fzf configs
" Git tracked files only
nmap <leader>f :GFiles<CR>
" All files
nmap <leader>F :Files<CR>

" Clear search when pressing <leader> and space
nnoremap <Leader><space> :noh<cr>
" Center search when pressing next
nnoremap n nzz

" Quick save
nnoremap <Leader>w :w<cr>
nnoremap <Leader>q :q<cr>


" Copypaste
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" Git stuff
nmap <leader>gs :G<CR>
