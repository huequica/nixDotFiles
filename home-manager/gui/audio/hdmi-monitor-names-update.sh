conf_dir="$HOME/.config/wireplumber/wireplumber.conf.d"
conf_file="$conf_dir/52-hdmi-monitor-names.conf"
mkdir -p "$conf_dir"

tmp=$(mktemp)
{
  echo "monitor.alsa.rules = ["
  for f in /proc/asound/card*/eld#*; do
    [ -f "$f" ] || continue
    pin_nid=$(sed -n 's/^codec_pin_nid[[:space:]]*//p' "$f")
    [ "$pin_nid" = "0xa" ] || continue
    present=$(sed -n 's/^monitor_present[[:space:]]*//p' "$f")
    [ "$present" = "1" ] || continue
    dev_id=$(sed -n 's/^codec_dev_id[[:space:]]*//p' "$f")
    name=$(sed -n 's/^monitor_name[[:space:]]*//p' "$f")
    [ -n "$name" ] || continue
    hdmi_num=$(( dev_id + 1 ))
    cat <<EOF
    {
      matches = [
        { node.name = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__HDMI${hdmi_num}__sink" }
      ]
      actions = {
        update-props = {
          node.description = "${name}"
        }
      }
    }
EOF
  done
  echo "]"
} > "$tmp"

if ! cmp -s "$tmp" "$conf_file" 2>/dev/null; then
  mv "$tmp" "$conf_file"
  # --no-block: ジョブ投入だけで戻る。素待ちすると Before=wireplumber.service の
  # 順序制約と循環待機してデッドロックする(このサービス自身が wireplumber.service の
  # 起動より先に完了しなければならないため)。
  systemctl --user --no-block try-restart wireplumber.service || true
else
  rm -f "$tmp"
fi
