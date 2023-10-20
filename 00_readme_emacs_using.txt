

-- 01_straight.el --	パッケージマネージャー
以降のパッケージは、これで取得している
必要なければ、とりあえずは自動実行で使うのみ

-- 02_mozc.el --	漢字変換
とりあえずデフォルトでOK

-- 03_ccmode.el --

C++モード

-- 10_company.el --	カンパニーモード、テキスト補完

-- 20_chatgpt.el --	chatGPT拡張

   codegpt-docj
     "以下に続くコードで定義される関数のドキュメントを書いて"
   codegpt-fixjj
     "以下に続くコードにはバグがあります。バグを修正したコードを表示して。修正の解説も付けて。"
   codegpt-explainj
     "以下に続くコードを説明して"
   codegpt-testj
     "以下に続くコードのテストを実装して"

| `codegpt`         | The master command                              |
| `codegpt-custom`  | Write your own instruction                      |
| `codegpt-doc`     | Automatically write documentation for your code |
| `codegpt-fix`     | Find problems with it                           |
| `codegpt-explain` | Explain the selected code                       |
| `codegpt-improve` | Improve, refactor or optimize it                |


-- 21_copilot.el --	github　copilot
契約切ったので、無効化中
有効化するには init.el を編集
