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
wseを行う関数です. 各引数以下をとることができます. データ変換, 閾値決定アルゴリズム, 閾値法は後述します.
```
wse(
   data = データセット
   dt =  ("none", "A1", "A2", "A3", "B1", "B2", "Fi", "Fr"), #データ変換の指定
   thresholdName = ("ldt", "ut", "lut", "lht"), #閾値決定アルゴリズムの指定
   thresholdMode = ("s", "h"), #閾値法の指定
   var = データ変換の際の分散を指定(デフォルトは1),
   index = 分割データのデータ長を指定,
   initThresholdvalue = 閾値の初期値(適当で良い),
)
```
### データ変換
データ変換は指定することができます. rwseでは次の表のデータ変換が実装されています.
| 変数名  | 変換名 |
| ------------- | ------------- |
| none  | データ変換を行わない  |
| A1  | Anscombe transformation 1  |
| A2  | Anscombe transformation 2  |
| A3  | Anscombe transformation 3  |
| B1  | Bartlet transformation 1  |
| B2  | Bartlet transformation 2  |
| Fi  | Fisz transformation  |
| Fr  | Freeman transformation |

### 閾値決定アルゴリズム
データ変換を指定することができます. rwseでは次の表のデータ変換が実装されています.
| 変数名  | 閾値決定アルゴリズム名 | 備考 |
| ------------- | ------------- | ------------- |
| ldt | Level-dependent-Threshold | dt="none"を指定した場合のみ適用化 |
| ut | Universal-Threshold | dt="none"以外を指定した場合のみ適用化 |
| lut | Level-dependent Universal Threshold | dt="none"以外を指定した場合のみ適用化 |
| lht | Level-out-half Cross-validation Threshold | dt="none"以外を指定した場合のみ適用化 |
