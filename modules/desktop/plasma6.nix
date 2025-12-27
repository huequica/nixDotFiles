{ pkgs, ... }:
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

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
