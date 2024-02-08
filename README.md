# rwseについて

製作者: Kaoru Matsui

**rwse**(R wavelet shrinkage estimation)は，ソフトウェアフォールト発見数データから，離散型非同次ポアソン過程における強度関数を推定するプログラムです．

# rwseの使い方
このリポジトリをcloneした後, 必要なパッケージをインストールしてrwse直下で`/src/WaveletTransform.R`をインポートして使用してください.
詳しい使い方はrwse/examples/example_usage.pyをご覧ください．

# rwseで使える各関数について
## loadData()
データセットを読み込むための関数です. txt形式で,1行目にテスト時刻, 2行目にフォール発見数が記載されているものに限ります.
```
loadData(
    dataPath = "データセットのパス"
)
```
## wse()
wseを行う関数です. 各引数に関しては以下になります.
```
wse(
   data = データセット
   dt = データ変換の指定 ("none", "A1", "A2", "A3", "B1", "B2", "Fi", "Fr"),
   thresholdName = 閾値決定アルゴリズムの指定 ("ldt", "ut", "lut"),
   thresholdMode = 閾値法の指定 ("s", "h"),
   var = データ変換の際の分散を指定(デフォルトは1),
   index = 分割データのデータ長を指定,
   initThresholdvalue = 閾値の初期値(適当で良い),
)
```
