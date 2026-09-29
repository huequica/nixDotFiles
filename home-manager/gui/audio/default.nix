{ pkgs, ... }:
let
  # 内蔵 HDA の HDMI / DisplayPort 出力(HiFi__HDMIN__sink)は番号でしか区別できず、
  # かつ番号とモニターの対応は挿すポートによって変わる。ALSA の ELD (EDID 由来のモニター名) を
  # 都度読み取って wireplumber.conf.d に反映することで、決め打ちの対応表がずれるのを防ぐ。
  # pin_nid=0xa の 3 系統(内蔵 HDMI/DP 出力)のみを対象とし、codec_dev_id は
  # HiFi__HDMI(dev_id+1)__sink の番号に一致する(amixer -c0 cget iface=PCM,name=ELD,device=N で確認)。
  hdmiMonitorNamesUpdate = pkgs.writeShellApplication {
    name = "hdmi-monitor-names-update";
    text = builtins.readFile ./hdmi-monitor-names-update.sh;
  };
in
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

  home.packages = [ hdmiMonitorNamesUpdate ];

  systemd.user.services.hdmi-monitor-names = {
    Unit = {
      Description = "ALSA ELD から読み取ったモニター名を wireplumber の HDMI/DP 出力に反映する";
      Before = [ "wireplumber.service" ];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${hdmiMonitorNamesUpdate}/bin/hdmi-monitor-names-update";
    };
    Install = {
      WantedBy = [ "wireplumber.service" ];
    };
  };
}
