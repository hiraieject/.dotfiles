
(when (equal (getenv "EMACSSTRAIGHT") "YES")
  (use-package gtags
    :commands gtags-mode
    :config
    (add-hook 'c-mode-common-hook 'gtags-mode)
    )
  
  (use-package cc-mode
    :hook ((c-mode . my-c-mode-hook)
           (c++-mode . my-c-mode-hook))
    )
  )

(unless (equal (getenv "EMACSSTRAIGHT") "YES")
  (require 'gtags)
  (add-hook 'c-mode-common-hook 'gtags-mode)

  (add-hook 'c-mode-hook 'my-c-mode-hook)
  (add-hook 'c++-mode-hook 'my-c-mode-hook)

  )


(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
                ("\\.c$"  . c++-mode)
                ("\\.h$"  . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.hh$"  . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.hpp$" . c++-mode)
                ) auto-mode-alist))


(defun my-c-mode-hook ()
  "My hook for C mode."
  (setq-default c-basic-offset 4)
  (if (string-equal (getenv "EMACSTAB") "TAB")
      (setq indent-tabs-mode t)    ; インデントにTABを使う
    (setq indent-tabs-mode nil))  ; インデントにスペースを使う
  (setq c-auto-newline nil)
					;  (c-set-style "bsd")
					;  (c-set-style "k&r")
					;  (c-set-style "linux")
					;  (setq c-basic-offset 2)
					;  (setq tab-width 8)
  (setq c-set-style "gnu")
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq c-auto-newline nil)	; 自動改行
  (setq comment-start "// ") ; //形式のコメント
  (setq comment-end "")
  ;; (define-key c-mode-map  [(tab)] 'company-complete)
  ;; (define-key c++-mode-map  [(tab)] 'company-complete)
  (gtags-mode 1)		; GTAGS
  (gtags-make-complete-list)
  (local-set-key "\M-t" 'gtags-find-tag)
  (local-set-key "\M-r" 'gtags-find-rtag)
  (local-set-key "\M-s" 'gtags-find-symbol)
  (local-set-key "\M-p" 'gtags-find-pattern)
  ;;(local-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
  (local-set-key "\C-t" 'gtags-pop-stack)
  )

(defun bsd ()
  (interactive)
  (set-c-style "BSD")
  )

(defun gnu ()
  (interactive)
  (set-c-style "GNU")
  )

(defun c++ ()
  (interactive)
  (set-c-style "C++")
  )

(defun k&r ()
  (interactive)
  (set-c-style "C++")
  )

(defun notab-mode ()
  (interactive)
  (setq indent-tabs-mode nil)
  )

; GTAGS の生成コマンド
(defun gtags ()
  "create gtags file."
  (interactive)
  (load "gtags")
  (shell-command "gtags >/dev/null")
  (gtags-make-complete-list)
  )

;;gtags mode の使い方
;; M-t:関数の定義元へ移動
;; M-r:関数を参照元の一覧を表示．RET で参照元へジャンプできる
;; M-s:変数の定義元と参照元の一覧を表示．RET で該当箇所へジャンプできる．
;; C-t:前のバッファへ戻る 
;; gtags-find-pattern:関連ファイルからの検索．
;; gtags-find-tag-from-here:カーソル位置の関数定義へ移動． 
