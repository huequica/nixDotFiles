{ username, pkgs, ... }:
{
  home.packages = with pkgs; [ android-tools ];
  # users.users."${username}".extraGroups = [ "adbusers" ];
}
