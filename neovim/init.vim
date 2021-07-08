"m/vim-airline/vim-airline-themes Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'
Plug 'kamykn/spelunker.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

" Languages/syntax
Plug 'leafOfTree/vim-vue-plugin'
Plug 'nelsyeung/twig.vim'
Plug 'ap/vim-css-color'
Plug 'yuezk/vim-js'
Plug 'StanAngeloff/php.vim'
" Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'leafOfTree/vim-svelte-plugin'

" DEV Tools
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-eunuch'
Plug 'vim-test/vim-test'
Plug 'editorconfig/editorconfig-vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'alvan/vim-closetag'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdTree'

" Themes
Plug 'ghifarit53/tokyonight-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'

" Initialize plugin system
call plug#end()

let g:mapleader = "\<Space>"

" NERDTree bindings
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinPos = 1
let g:NERDTreeWinSize = 45

" Easy Motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map  <silent> s <Plug>(easymotion-bd-w)
nmap <silent> s <Plug>(easymotion-overwin-w)
nmap f <Plug>(easymotion-overwin-f2)
map <C-j> <Plug>(easymotion-j)
map <C-k> <Plug>(easymotion-k)

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" FZF bingings
let g:fzf_nvim_statusline = 0 " disable statusline overwriting
nnoremap <silent> <leader><space> :GFiles<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :AgIn

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

function! SearchWordWithAg()
execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
let old_reg = getreg('"')
let old_regtype = getregtype('"')
let old_clipboard = &clipboard
set clipboard&
normal! ""gvy
let selection = getreg('"')
call setreg('"', old_reg, old_regtype)
let &clipboard = old_clipboard
execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

inoremap jk <ESC>

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set clipboard=unnamedplus
set smarttab
set smartindent
" set cindent
" always uses spaces instead of tab characters
set expandtab
set autoindent
set termguicolors
set nowrap

""""""""
" Autoclose tags
let g:closetag_filenames = '*.html,*.twig,*.php,*.js,*.vue'
""""""""
let g:rainbow_active = 1

" Color scheme
" let g:tokyonight_style = 'storm' " available: night, storm
" let g:tokyonight_enable_italic = 1
" colorscheme tokyonight
" let g:airline_theme='tokyonight'

if &term =~ '256color'
  " disable Background Color Erase (BCE)
  set t_ut=
endif
set t_Co=256
set t_ut=

colorscheme codedark
let g:airline_theme='codedark'
"
" Frameworks
let g:vim_svelte_plugin_use_sass = 1

" let g:gruvbox_contrast_dark = 'dark'
" colorscheme gruvbox
" let g:AirlineTheme='base16_colors'
" let g:airline_theme='gruvbox'

autocmd FileType twig,scss,css,javascript,php autocmd BufWritePre <buffer> %s/\s\+$//e
" Remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e
" Line numbers
set relativenumber
" search caseinsensitive
set ignorecase
autocmd WinEnter,FocusGained * :setlocal number relativenumber
autocmd WinLeave,FocusLost   * :setlocal number norelativenumber
" coc scss mixins support
autocmd FileType scss setl iskeyword+=@-@

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-phpls',
  \ 'coc-emmet',
  \ 'coc-svelte',
  \ ]


" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" Add empty line at the end of file
set nofixeol

" don't give |ins-completion-menu| messages.
set shortmess+=c

let &colorcolumn="80,".join(range(120,999),",")
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-c> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-c> <Plug>(coc-range-select)
xmap <silent> <C-c> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>ex  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Spell checking
" Option to disable word checking.
" Disable URI checking. (default: 0)
let g:spelunker_disable_uri_checking = 1

" Disable email-like words checking. (default: 0)
let g:spelunker_disable_email_checking = 1

" Disable account name checking, e.g. @foobar, foobar@. (default: 0)
" NOTE: Spell checking is also disabled for JAVA annotations.
let g:spelunker_disable_account_name_checking = 1

" Disable acronym checking. (default: 0)
let g:spelunker_disable_acronym_checking = 1

" Disable checking words in backtick/backquote. (default: 0)
le g:spelunker_disable_backquoted_checking = 1

" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  autocmd BufWinEnter,BufWritePost *.vim,*.vue,*.html,*.twig,*.php,*.js,*.jsx,*.json,*.md call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md call spelunker#check_displayed_words()
augroup END

" Remove trailing spaces on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" Trim on call :TrimWhitespace
" command! TrimWhitespace call TrimWhitespace()
" Trim automaticaly before each save
autocmd BufWritePre * :call TrimWhitespace()

"Git workflow
let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6  }  }
nnoremap <space>gb :GBranches<CR>

let g:fugitive_pty = 0
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gc :Git commit -v -q<CR>
nnoremap <space>gt :Git commit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gpl :exec "Git pull origin " . fugitive#head()<CR>
nnoremap <space>gps :Git -c push.default=current push<CR>
