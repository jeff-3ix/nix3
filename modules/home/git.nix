{ ... }:

{
  programs.git = {
    enable = true;

    userName = "jeff-3ix";
    userEmail = "jeffryt@pm.me";

    signing = {
      key = "A84DA197C1543082F3E83D1DF1E1EEDAA53EE303";
      signByDefault = true;
    };

    settings = {
      push.autoSetupRemote = true;
      pull.rebase = true;

      gpg.format = "openpgp";
      pgp.program = "gpg";
    };
  };
}
