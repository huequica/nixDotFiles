{ pkgs, ... }:
{
  services.nextcloud-client = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    startInBackground = true;
  };
}
