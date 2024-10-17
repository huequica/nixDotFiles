{ pkgs, ... }:
let
  sddmWallpaper = pkgs.fetchurl {
    url = "https://supersonico.jp/download/wallpaper/63_vday2024_1920x1200.jpg";
    sha256 = "sha256-vqzhfHOhZNyqN+1bObKEqp5GAwDsWWDG2E1xT8Tz1yg=";
  };
in
{
  services.xserver.enable = true;
  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  services.desktopManager.plasma6.enable = true;

  # smartphone integration
  programs.kdeconnect.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # custom login theme
  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      background = "${sddmWallpaper}";
      loginBackground = true;
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha";
    wayland.enable = true;
  };
}
