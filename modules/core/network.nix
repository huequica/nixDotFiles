{
  config,
  hostname,
  pkgs,
  ...
}:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    # expressvpn がうまく使用できないことがあるので openvpn も入れておいてマニュアルで認証する
    networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

    firewall.enable = false;
  };

  services.expressvpn.enable = true;
  environment.systemPackages = with pkgs; [
    expressvpn
  ];
}
