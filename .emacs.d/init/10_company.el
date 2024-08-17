
;; official
;;   https://company-mode.github.io/manual/Getting-Started.html

;; --------------------------------------------------------------
;;   https://company-mode.github.io/
;;
;;   https://tam5917.hatenablog.com/entry/2021/03/29/154958
(use-package company
  :bind
  (:map company-active-map
        ("M-n" . nil)
        ("M-p" . nil)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-h" . nil)
	("C-m" . company-complete-selection)
	)
  :config
  (global-company-mode)
  ;; 遅延なしにする。
  (setq company-idle-delay 0.4)
  ;; デフォルトは4。より少ない文字数から補完が始まる様にする。
  (setq company-minimum-prefix-length 2)
  ;; 候補の一番下でさらに下に行こうとすると一番上に戻る。
  (setq company-selection-wrap-around t)
  ;; 番号を表示する。
  (setq company-show-numbers t)
  )

;; --------------------------------------------------------------
;;  https://github.com/randomphrase/company-c-headers
;;
(use-package company-c-headers
  :after company
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (add-to-list 'company-c-headers-path-system "/usr/include/")
  (add-to-list 'company-c-headers-path-system "/usr/include/c++/11/")
  )

;; -------------------------------------------------------------- Python
;;  https://github.com/pythonic-emacs/company-anaconda
;;
(use-package company-anaconda
  :after company
  :config
  (add-to-list 'company-backends 'company-anaconda)
  (add-hook 'python-mode-hook 'anaconda-mode)
  )


;; -------------------------------------------------------------- Tabnine deep learning
;;   https://qiita.com/blue0513/items/2634fcb3757629124c87
;;
(when (not (equal (getenv "EMACS_IGNORE_COMPAMYTABNINE") "YES"))
  (use-package company-tabnine 
    :after company
    :ensure t
    :config
    (add-to-list 'company-backends 'company-tabnine))

  ;; auto install tabnine bin
  ;; M-x company-tabnine-install-binary
  (let ((my-directory "~/.TabNine"))
    (unless (file-exists-p my-directory)
      (message "Directory does not exist: %s" my-directory)
      (message "Running install_tabnine bin install...")
      (company-tabnine-install-binary)
      (message "Files have been installed.")))
  ;; どこでもいいから TabNine::version バージョンが見えます。
  ;; どこでもいいから TabNine::sem Semantic Completion を有効化
  )

;; (use-package irony
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)g
;;   (add-hook 'objc-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

;; ;; https://qiita.com/sune2/items/c040171a0e377e1400f6
;; 
;; ;; 初回実行時のみ，
;; ;; M-x irony-install-server RET
;; 
;; (use-package irony
;;   :config
;;   (add-hook 'c++-mode-hook 'irony-mode)
;;   (add-hook 'c-mode-hook 'irony-mode)
;;   (add-hook 'objc-mode-hook 'irony-mode)
;;   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
;; 
;; (use-package company-irony
;;   :after company
;;   :config
;;   (add-to-list 'company-backends 'company-irony))
;; 
;; ;; 連想リストの中身を文字列のリストに変更せず、変数そのままの構造を利用。
;; ;; 複数のコンパイルオプションはスペースで区切る
;; (setq irony-lang-compile-option-alist
;;       (quote ((c++-mode . "c++ -std=c++11 -lstdc++")
;;               (c-mode . "c")
;;               (objc-mode . "objective-c"))))
;; ;; アドバイスによって関数を再定義。
;; ;; split-string によって文字列をスペース区切りでリストに変換
;; ;; (24.4以降 新アドバイス使用)
;; (defun ad-irony--lang-compile-option ()
;;   (defvar irony-lang-compile-option-alist)
;;   (let ((it (cdr-safe (assq major-mode irony-lang-compile-option-alist))))
;;     (when it (append '("-x") (split-string it "\s")))))
;; (advice-add 'irony--lang-compile-option :override #'ad-irony--lang-compile-option)
;; ;; (24.3以前 旧アドバイス使用)
;; (defadvice irony--lang-compile-option (around ad-irony--lang-compile-option activate)
;;   (defvar irony-lang-compile-option-alist)
;;   (let ((it (cdr-safe (assq major-mode irony-lang-compile-option-alist))))
;;     (when it (append '("-x") (split-string it "\s")))))



;; ;; 参考 https://qiita.com/zk_phi/items/9dc373e734d20cd31641
;; ;; 『これは「現在編集中のバッファ、またはそのバッファと同じメジャーモー
;; ;; ドになっているバッファ」から補完候補を探してきてくれるものです。』
;; (use-package company-same-mode-buffers
;;   :straight (:type git :host github :repo "zk-phi/company-same-mode-buffers" :files
;; 		   ("dist" "*.el")))
;; 
;; (company-same-mode-buffers-initialize)
;; (setq company-backends
;;       `(
;;         company-dabbrev
;;         company-capf
;;         company-semantic
;;         company-cmake
;;         company-clang
;;         company-files
;; 	
;;         ;; https://qiita.com/zk_phi/items/9dc373e734d20cd31641
;;         ;; 「組み込みのキーワードも words-in-same-mode-buffers
;;         ;; の候補もみんないっしょくたに出てくる」
;;         ;; (company-keywords :with company-same-mode-buffers)
;; 	
;;         (company-dabbrev-code company-gtags company-etags
;; 			      company-keywords)
;;         company-oddmuse
;;         company-bbdb
;;         ,@(unless (version< "24.3.51" emacs-version)
;;             (list 'company-elisp))
;;         ,@(unless (version<= "26" emacs-version)
;;             (list 'company-nxml))
;;         ,@(unless (version<= "26" emacs-version)
;;             (list 'company-css))
;;         ))
;; (push 'company-same-mode-buffers company-backends) ;先頭に追加

