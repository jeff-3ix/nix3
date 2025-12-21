{ config, pkgs, ghostty, system, ... }:

{
  home.username = "jeffu";
  home.homeDirectory = "/home/jeffu";

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    nnn # terminal file manager
    ghostty.packages.${system}.default

    # archives
    zip
    xz
    unzip
    p7zip

    # fonts
    nerd-fonts.fira-code
    #nerd-fonts.font-logos
    #nerd-fonts.powerline-extra-symbols
    nerd-fonts.noto
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    #zoxide
    trashy
    tealdeer
    bat
    duf
    just
    topgrade

    # networking tools
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    speedtest-cli

    # misc
    cowsay
    clolcat
    kittysay
    ponysay
    fortune-kind
    sl
    file
    which
    tree
    gawk
    zstd
    gnupg
    fastfetch
    vimgolf

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal
    obsidian
    libreoffice-fresh
    tailscale
    syncthing
    vscode
    brave
    mullvad-browser
    zoom-us
    protonmail-desktop
    protonvpn-gui
    proton-pass
    vlc
    freetube

    btop  # replacement of htop/nmon
    bottom
    htop
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user.name = "jeff-3ix";
      user.email = "jeffryt@pm.me";
    };
  };

  fonts.fontconfig.enable = true;

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        normal = { family = "JetBrains Mono Nerd Font"; style = "Regular"; };
        bold = { family = "JetBrains Mono Nerd Font"; style = "Bold"; };
        italic = { family = "JetBrains Mono Nerd Font"; style = "Italic"; };
        bold_italic = { family = "JetBrains Mono Nerd Font"; style = "Bold Italic"; };
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
  
  programs.ghostty = {
    enable = true;
    package = ghostty.packages.${system}.default;
    settings = {
      background-blur-radius = 20;
      theme = "dark:Catppuccin Mocha,light:Catppuccin Latte";
      window-theme = "dark";
      background-opacity = 0.8;
      minimum-contrast = 1.1;
      keybind = [
        "global:ctrl+`=toggle_quick_terminal"
        "global:ctrl+shift+n=new_window"
      ];
    };

  };
    
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };   
  
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      # ls and eza aliases (requires eza)
      ls = "eza";
      ll = "eza --long";
      la = "eza --all";
      lla = "eza --long --all";
      lt = "eza --tree";
      llt = "eza --long --tree";
      llta = "eza --long --tree --all";
      
      # trashy updates (requires trashy)
      tt = "trash put";
      tp = "trash put";
      tl = "trash list";
      te = "trash empty";
      
      # nix update aliases
      update = "sudo nixos-rebuild switch";
      up = "sudo nixos-rebuild switch";
      up-test = "sudo nixos-rebuild test";
      
      # git aliases
      gs = "git status";
      gc = "git commit -am";
      
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
