{ ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
    };
    settings = {
      user.name = "jeff-3ix";
      user.email = "jeffryt@pm.me";
    };
  };
}
