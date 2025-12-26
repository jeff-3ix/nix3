{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;

    # Keep only options that Home Manager's vim module exposes reliably.
    settings = {
      number = true;

      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      textwidth = 79;

      mouse = "a";
      cursorline = true;
      scrolloff = 6;
      signcolumn = "yes";

      clipboard = "unnamed";
    };

    # Everything else goes here as plain vimrc.
    extraConfig = ''
      set fileformat=unix
      set encoding=UTF-8
      syntax on

      set nocompatible
      set linebreak
      set showbreak=+++
      set showmatch
      set visualbell

      " indentation behavior
      set autoindent
      set smartindent
      set smarttab

      set nowrap
      set ruler
      set undolevels=1000
      set backspace=indent,eol,start

      " Python: 4-space indent
      augroup ft_python_indent
        autocmd!
        autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
      augroup END

      inoremap jj <esc>
    '';
  };
}
