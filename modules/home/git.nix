{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      push.autoSetupRemote = true;
    };
    settings = {
      user.name = "jeff-3ix";
      user.email = "jeffryt@pm.me";
    };
  };
}
