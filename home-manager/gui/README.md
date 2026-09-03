# audio.nix について

なぜか Inzone Buds を USB ドングル経由で使えない問題があり、 Claude とトラブルシューティングをした結果このファイルに至る。  
以下に具体的な原因を残す。

> - 原因: INZONE BudsのUSBドングルは再生用インターフェースを2つ(DEV=0とDEV=1)公開しており、PipeWire/WirePlumberが自動選択するDEV=0は実際には無音のインターフェースで、実際に音が出るのはDEV=1側だった。
> - 切り分け経緯: カーネルログのcannot get freqはダミーな別インターフェース(Interface 4)由来の無害な警告で、本命の原因は「音は出るはずのインターフェースが選ばれていない」というPipeWire側のデバイス選択ミスだった。Windowsで正常に鳴ったことでハードウェア故障の可能性を排除し、aplay -D hw:3,1の直接テストで初めて音が出ることを確認できた。
> - 対処: home-manager/gui/audio.nix を追加し、WirePlumberのルールでINZONE Budsのsinkに対しapi.alsa.pathをhw:CARD=Buds,DEV=1に固定するよう設定した。
