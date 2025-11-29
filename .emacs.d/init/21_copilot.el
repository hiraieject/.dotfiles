
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

  (use-package copilot-chat
    :straight (:host github :repo "chep/copilot-chat.el" :files ("*.el"))
    :ensure t
    :after copilot
    :bind (("C-c C-o" . copilot-chat-open-session)
	   :map copilot-chat-mode-map
	   ("C-c C-c" . copilot-chat-send-message))
    )
  )

;;(when (and (>= emacs-major-version 27)
;;           (equal (getenv "EMACSSTRAIGHT") "YES"))
;;
;;  (use-package copilot
;;    :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
;;    :ensure t
;;    :hook (prog-mode . copilot-mode)
;;    :bind (:map copilot-completion-map
;;		("<tab>" . 'copilot-accept-completion)
;;		("TAB" . 'copilot-accept-completion)
;;		("C-TAB" . 'copilot-accept-completion-by-word)
;;		("C-<tab>" . 'copilot-accept-completion-by-word)
;;		("C-n" . 'copilot-next-completion)
;;		("C-p" . 'copilot-previous-completion))
;;    
;;    :config
;;    (add-to-list 'copilot-indentation-alist '(prog-mode 2))
;;    (add-to-list 'copilot-indentation-alist '(org-mode 2))
;;    (add-to-list 'copilot-indentation-alist '(text-mode 2))
;;    (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
;;    (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))
;;
;;    )
;;  )

;; sudo apt install nodejs npm
;; M-x copilot-install-server
;; 上だとnodejs12が入るので動かない
;; sudo apt remove nodejs npm
;; sudo apt autoremove

;; curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
;; source ~/.bashrc
;; nvm install 22
;; nvm use 22
;; nvm alias default 22
;; M-x copilot-install-server


;;;; https://qiita.com/nobuyuki86/items/f3a98428220b101878e0
;;
;;(when (and (>= emacs-major-version 27)
;;           (equal (getenv "EMACSSTRAIGHT") "YES"))
;;
;;  (use-package copilot
;;    :straight (:type git :host github :repo "zerolfx/copilot.el" :files
;;		     ("dist" "*.el"))
;;    :init
;;    (setq copilot-node-executable
;;	  "/usr/bin/node")
;;    :hook
;;    ;; プログラムモードの場合、copilot-modeを実行
;;    ((prog-mode . copilot-mode))
;;    :config
;;    ;; copilot用にキーバインドを設定
;;    (defun my-tab ()
;;      (interactive)
;;      (or (copilot-accept-completion)
;;          (company-indent-or-complete-common nil)))
;;    (global-set-key (kbd "C-TAB") #'my-tab)
;;    (global-set-key (kbd "C-<tab>") #'my-tab)
;;    (with-eval-after-load 'company
;;      (define-key company-active-map (kbd "C-TAB") #'my-tab)
;;      (define-key company-active-map (kbd "C-<tab>") #'my-tab)
;;      (define-key company-mode-map (kbd "C-TAB") #'my-tab)
;;      (define-key company-mode-map (kbd "C-<tab>") #'my-tab))
;;    (with-eval-after-load 'company
;;      ;; disable inline previews
;;      (delq 'company-preview-if-just-one-frontend company-frontends)))
;;
;;)

;; (straight-use-package
;;  '(copilot :type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))
;; 
;; ;; 使用するnode.jsを指定
;; (setq copilot-node-executable "~/.nvm/versions/node/v17.9.1/bin/node")
;; 
;; ;; プログラムモードの場合、copilot-modeを実行
;; (add-hook 'prog-mode-hook 'copilot-mode)
;; 
;; ;; copilot用にキーバインドを設定
;; (defun my-tab ()
;;   (interactive)
;;   (or (copilot-accept-completion)
;;       (company-indent-or-complete-common nil)))
;; 
;; (global-set-key (kbd "C-TAB") #'my-tab)
;; (global-set-key (kbd "C-<tab>") #'my-tab)
;; 
;; (with-eval-after-load 'company
;;   (define-key company-active-map (kbd "C-TAB") #'my-tab)
;;   (define-key company-active-map (kbd "C-<tab>") #'my-tab)
;;   (define-key company-mode-map (kbd "C-TAB") #'my-tab)
;;   (define-key company-mode-map (kbd "C-<tab>") #'my-tab)

