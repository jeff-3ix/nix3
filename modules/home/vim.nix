{ config, pkgs, ... }:

{
  programs.vim = {
    enable = true;

    # Most "set ..." options belong here
    settings = {
      # fileformat=unix is typically fine to omit (Linux default),
      # but including it matches your vimrc intent.
      fileformat = "unix";
      encoding = "UTF-8";

      compatible = false; # "set nocompatible"
      number = true;
      linebreak = true;
      showbreak = "+++";
      textwidth = 79;

      showmatch = true;
      visualbell = true;

      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      # defaults (your global non-python behavior)
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;

      autoindent = true;
      smartindent = true;
      smarttab = true;
      expandtab = true;
      wrap = false; # "set nowrap"

      ruler = true;
      undolevels = 1000;
      backspace = "indent,eol,start";

      mouse = "a";
      cursorline = true;
      scrolloff = 6;
      signcolumn = "yes";

      clipboard = "unnamed";
    };

    # Vimscript bits: syntax, mappings, filetype-specific overrides
    extraConfig = ''
      syntax on

      " Python: 4-space indent
      augroup ft_python_indent
        autocmd!
        autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
      augroup END

      " quick escape
      inoremap jj <esc>
    '';
  };
}

