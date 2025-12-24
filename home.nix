{ config, pkgs, system, ... }:

{
  home.username = "jeffu";
  home.homeDirectory = "/home/jeffu";

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # fonts
    nerd-fonts.fira-code
    nerd-fonts.noto
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    trash-cli
    tealdeer
    bat
    duf
    just
    topgrade
    pika-backup

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
    thunderbird
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
    citrix_workspace

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
/*
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings" = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1"
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" 
    ];
    # ghostty keyboard shortcut
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Ctrl><Alt>t";
      command = "ghostty";
      name = "Open Ghostty";
    };
    
    # ghostty keyboard shortcut using super key
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>t";
      command = "ghostty";
      name = "Open Ghostty(super)";
    };
    
    # brave keyboard shortcut
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "<Super>b";
      command = "brave";
      name = "Open Brave";
    };
  };
  */
  
  # basic configuration of git
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
  
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableBashIntegration = true;
    
    settings = {
      background-opacity = "0.8";
      font-family = "JetBrainsMono Nerd Font";
     
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
      tt = "trash-put";
      tp = "trash-put";
      tl = "trash-list";
      te = "trash-empty";
      
      # nix update aliases
      update = "sudo nixos-rebuild switch";
      up = "sudo nixos-rebuild switch";
      up-test = "sudo nixos-rebuild test";
      
      # git aliases
      gs = "git status";
      gc = "git commit -am";
      gpush = "git push";
      gpull = "git pull";
      
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
