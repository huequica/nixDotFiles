{
  hostname,
  username,
  ...
}:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  # nix そのものは別途インストーラーで導入済みのため nix-darwin による管理は無効化する
  nix.enable = false;

  networking.hostName = hostname;
  networking.computerName = hostname;

  system.primaryUser = username;
  users.users.${username}.home = "/Users/${username}";

  programs.fish.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "vlc"
      "vivaldi"
    ];
  };

  # DONT TOUCH THIS
  system.stateVersion = 7;
}
