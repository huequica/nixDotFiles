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

  # 内蔵 HDA の HDMI / DisplayPort 出力は番号でしか区別できないため、接続先モニター名を付ける。
  # 対応は ELD (amixer -c0 cget iface=PCM,name=ELD,device=N) で確認したもので、
  # 物理的な接続ポートを変えるとずれる。
  xdg.configFile."wireplumber/wireplumber.conf.d/52-hdmi-monitor-names.conf".text = ''
    monitor.alsa.rules = [
      {
        matches = [
          { node.name = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI1__sink" }
        ]
        actions = {
          update-props = {
            node.description = "VG280K"
          }
        }
      }
      {
        matches = [
          { node.name = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI2__sink" }
        ]
        actions = {
          update-props = {
            node.description = "LG HDR 4K"
          }
        }
      }
      {
        matches = [
          { node.name = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI3__sink" }
        ]
        actions = {
          update-props = {
            node.description = "P27FBB-RGGL"
          }
        }
      }
    ]
  '';
}
