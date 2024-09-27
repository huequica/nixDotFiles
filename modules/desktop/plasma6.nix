{ pkgs, ... }:
{
  services.xserver.enable = true;
  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # smartphone integration
  programs.kdeconnect.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # enabling SDDM config in KDE system config
  # but, no effective select theme... :(
  environment.systemPackages = with pkgs; [
    kdePackages.sddm-kcm
  ];
}
