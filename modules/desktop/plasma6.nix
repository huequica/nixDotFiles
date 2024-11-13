{ pkgs, ... }:
let
  sddmWallpaper = pkgs.fetchurl {
    url = "https://supersonico.jp/download/wallpaper/57_birthday2022_1920x1200.jpg";
    sha256 = "sha256-6/EOoy1ekwK1014NWLacp654JpvaHsgxQZmwTn7sWLE=";
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
