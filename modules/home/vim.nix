{ ... }:

{
  programs.vim = {
    enable = true;

    extraConfig = ''
      set fileformat=unix
      set encoding=UTF-8
      syntax on

      set nocompatible
      set number
      set linebreak
      set showbreak=+++
      set textwidth=79
      set showmatch
      set visualbell

      set hlsearch
      set smartcase
      set ignorecase
      set incsearch

      " Defaults: 2-space indent
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2

      set autoindent
      set smartindent
      set smarttab
      set expandtab
      set nowrap

      set ruler
      set undolevels=1000
      set backspace=indent,eol,start

      inoremap jj <esc>

      set mouse=a
      set cursorline
      set scrolloff=6
      set signcolumn=yes

      set clipboard=unnamed

      " Python: 4-space indent
      augroup ft_python_indent
        autocmd!
        autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
      augroup END
    '';
  };
}
