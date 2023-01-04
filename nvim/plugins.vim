packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('tpope/vim-sensible')
call minpac#add('junegunn/fzf', {'do': { -> fzf#install() }})
call minpac#add('junegunn/fzf.vim')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
call minpac#add('w0rp/ale')
call minpac#add('mhinz/vim-grepper')
call minpac#add('janko-m/vim-test')
call minpac#add('tpope/vim-obsession')

" lean & mean status/tabline for vim
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
" a git wrapper so awesome, it should be illegal
call minpac#add('tpope/vim-fugitive')
" a GitHub extension for fugitive
call minpac#add('tpope/vim-rhubarb')
" shows git diff in the gutter
call minpac#add('airblade/vim-gitgutter')
" tree explorer
call minpac#add('scrooloose/nerdtree')
" multiple selection Sublime style
call minpac#add('terryma/vim-multiple-cursors')
" quoting/parenthesizing made simple
call minpac#add('tpope/vim-surround')
" a solid language pack
call minpac#add('sheerun/vim-polyglot', { 'rev': 'v4.16.0' })

call minpac#add('fatih/vim-go')

call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-rake')
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-endwise')
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('jparise/vim-graphql')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('vim-syntastic/syntastic')

call minpac#add('github/copilot.vim')

call minpac#add('akinsho/toggleterm.nvim', { 'tag': 'v2.*' })

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

