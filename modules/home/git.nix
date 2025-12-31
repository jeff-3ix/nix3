{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "jeff-3ix";
      user.email = "jeffryt@pm.me";

      gpg.format = "openpgp";
      pgp.program = "gpg";
      
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
    
    signing = {
      key = "A84DA197C1543082F3E83D1DF1E1EEDAA53EE303";
      signByDefault = true;
    };
  };
}
