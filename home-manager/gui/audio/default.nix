{
  # INZONE Buds の USB ドングルは playback インターフェースを2つ公開しており、
  # PipeWire がデフォルトで選ぶ DEV=0 は無音で、実際に音が出るのは DEV=1 側のため固定する。
  xdg.configFile."wireplumber/wireplumber.conf.d/51-inzone-buds.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [
          { node.name = "alsa_output.usb-Sony_INZONE_Buds-00.analog-stereo" }
        ]
        actions = {
          update-props = {
            api.alsa.path = "hw:CARD=Buds,DEV=1"
          }
        }
      }
    ]
  '';
}
