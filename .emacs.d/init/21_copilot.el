
;; -------------------------------------------- copilot

;; https://qiita.com/nobuyuki86/items/f3a98428220b101878e0

(when (and (>= emacs-major-version 27)
           (equal (getenv "EMACSSTRAIGHT") "YES"))

  (use-package copilot
    :straight (:type git :host github :repo "zerolfx/copilot.el" :files
		     ("dist" "*.el"))
    :init
    (setq copilot-node-executable
	  "~/.nvm/versions/node/v17.9.1/bin/node")
    :hook
    ;; プログラムモードの場合、copilot-modeを実行
    ((prog-mode . copilot-mode))
    :config
    ;; copilot用にキーバインドを設定
    (defun my-tab ()
      (interactive)
      (or (copilot-accept-completion)
          (company-indent-or-complete-common nil)))
    (global-set-key (kbd "C-TAB") #'my-tab)
    (global-set-key (kbd "C-<tab>") #'my-tab)
    (with-eval-after-load 'company
      (define-key company-active-map (kbd "C-TAB") #'my-tab)
      (define-key company-active-map (kbd "C-<tab>") #'my-tab)
      (define-key company-mode-map (kbd "C-TAB") #'my-tab)
      (define-key company-mode-map (kbd "C-<tab>") #'my-tab))
    (with-eval-after-load 'company
      ;; disable inline previews
      (delq 'company-preview-if-just-one-frontend company-frontends)))



  ;; install node.js
  (let ((my-directory "~/.nvm/versions/node/v17.9.1"))
    (unless (file-exists-p my-directory)
      (message "Directory does not exist: %s" my-directory)
      (message "Running install_nodejs.sh to install node.js...")
      (shell-command "bash ~/.dotfiles/install_nodejs.sh")
      (message "Files have been installed.")))

)

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
;;   (define-key company-mode-map (kbd "C-<tab>") #'my-tab))
