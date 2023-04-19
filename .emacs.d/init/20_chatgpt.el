
(when (equal (getenv "EMACSSTRAIGHT") "YES")

  ;; -------------------------------------------- charGPT
  (use-package openai :straight (:host github :repo "emacs-openai/openai"))
  (use-package chatgpt :straight (:host github :repo "emacs-openai/chatgpt"))
  (use-package codegpt :straight (:host github :repo "emacs-openai/codegpt"))
  (use-package dall-e :straight (:host github :repo "emacs-openai/dall-e"))
  
  (if (file-exists-p "~/.emacs.d/.secret.el")
      (load "~/.emacs.d/.secret.el"))


  (setq codegpt-tunnel 'chat            ; The default is 'completion
	codegpt-model "gpt-3.5-turbo")  ; You can pick any model you want!

					; - `chatgpt-model` - ID of the model to use. (Default: `"gpt-3.5-turbo"`)
					; - `chatgpt-max-tokens` - The maximum number of tokens to generate in the completion. (Default: `2000`)
					; - `chatgpt-temperature` - What sampling temperature to use. (Default: `1.0`)
					; - `chatgpt-input-method` - Method to receive input. (Default: `'window`)
					; - `chatgpt-spinner-type` - Type of the spinner. (Default: `'moon`)
					; - `chatgpt-display-tokens-info` - Non-nil we display tokens information for each request. (Default: `t`)
					; - `chatgpt-animate-text` - Display text gradually instead of output it all at once. (Default: `t`)
					; - `chatgpt-animate-fps` - Frame per seconds to display text animation. (Default: `5`)


  ;;;### コードのドキュメントを自動的に作成する
  (defun codegpt-docj (start end)
    "Automatically write documentation for your code.

    This command is interactive region only, the START and END are boundaries of
    that region in buffer."
    (interactive "r")
    (codegpt--internal
     "以下に続くコードで定義される関数のドキュメントを書いて"
     start end))

  ;;;### 問題を見つける
  (defun codegpt-fixjj (start end)
    "Fix your code.

    This command is interactive region only, the START and END are boundaries of
    that region in buffer."
    (interactive "r")
    (codegpt--internal
     "以下に続くコードにはバグがあります。バグを修正したコードを表示して。修正の解説も付けて。"
     start end))

  ;;;### 選択したコードを説明する
  (defun codegpt-explainj (start end)
    "Explain the selected code.

    This command is interactive region only, the START and END are boundaries of
    that region in buffer. 回答は日本語で."
    (interactive "r")
    (codegpt--internal
     "以下に続くコードを説明して"
     start end))


  ;;;### 選択したコードのテストを書く
  (defun codegpt-testj (start end)
    "Generate test the selected code.

    This command is interactive region only, the START and END are boundaries of
    that region in buffer."
    (interactive "r")
    (codegpt--internal
     ;; "Implement tests for the following code"
     "以下に続くコードのテストを実装して"
     start end))

)
