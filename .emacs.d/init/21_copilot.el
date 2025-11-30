
;;
;; 環境設定手順
;;
;; - ~/MemoData/02.linux/nodejs/ の手順にしたがって、v22より新しい nodejs をインストールする
;; - .bashrcを読み込んで、nodejs/npm が使えるようになったbashからeamcsを起動し直す
;; - このファイルを eval-buffer する
;; - M-x copilot-install-server を実行
;; - https://github.com/login/device を開いておく
;; - M-x copilot-login を実行
;;   one-time code がクリップボードに入るので、https://github.com/login/device で認証
;; - init.el の (load "~/.emacs.d/init/21_copilot.el") の行を有効にする
;;
;; 以下のエラーが出た場合、M-x straight-pull-recipe-repositories を実行してから、再度 eval-buffer する
;;   straight--convert-recipe: Could not find package cond-let. Updating recipe repositories:
;;   (org-elpa melpa gnu-elpa-mirror nongnu-elpa el-get emacsmirror-mirror) with ‘straight-pull-recipe-repositories’ may fix this
;;
;; キーバインド
;;
;;  copilot
;;    tab: 提案受け入れ
;;    C-tab: 提案受け入れ(word単位)
;;    C-n:   次の候補
;;    C-p:   前の候補
;;
;;  copilot chat
;;    C-c C-o: チャット起動
;;    C-c C-c: 入力送信
;;

;; -------------------------------------------- copilot

(when (and (>= emacs-major-version 27)
           (equal (getenv "EMACSUSECOPILOT") "YES"))

  (use-package copilot
    :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
    :ensure t
    :hook (prog-mode . copilot-mode)
    :bind (:map copilot-completion-map
                ([tab] . copilot-accept-completion)
                ("TAB" . copilot-accept-completion)
                ("C-TAB" . copilot-accept-completion-by-word)
                ("C-<tab>" . copilot-accept-completion-by-word)
                ("C-n" . copilot-next-completion)
                ("C-p" . copilot-previous-completion))
    :config
    (add-to-list 'copilot-indentation-alist '(prog-mode 2))
    (add-to-list 'copilot-indentation-alist '(org-mode 2))
    (add-to-list 'copilot-indentation-alist '(text-mode 2))
    (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
    )
  (require 'copilot)
  (setq copilot-indent-offset 4) ;; デフォルト4スペース

  (use-package copilot-chat
    :straight (:host github :repo "chep/copilot-chat.el" :files ("*.el"))
    :ensure t
    :after copilot
    :bind (("C-c C-o" . copilot-chat-open-session)
	   :map copilot-chat-mode-map
	   ("C-c C-c" . copilot-chat-send-message))
    )
  )

