;; .emacs


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

;; domainなしのホスト名取得
(defvar system-name-simple
  (replace-regexp-in-string "\\..*\\'" "" (system-name))
  "The simple host name of the machine Emacs is running on, which is without domain information.")

;; -------------------------------------------- basic emacs setting

(setq load-path (cons "~/.emacs.d/lisp" load-path))
;;(setq load-path (cons "/usr/local/share/gtags" load-path))

(setq default-frame-alist
	(cons '(vertical-scroll-bars . nil)
 	 (cons '(menu-bar-lines . 0)
	  (cons '(tool-bar-lines . 0)
	    default-frame-alist))))

(setq inhibit-startup-message t)        ; スタート時のメッセージの抑制
(setq line-number-mode t)               ; 行数を表示
(setq column-number-mode t)             ; カラム番号の表示
(setq scroll-step 1)			; スクロール行数
(setq-default tab-width 8)		; TAB幅
(setq compile-command "make ")		; M-x compile コマンド
(setq-default truncate-lines t)		; 行折り返す
(setq delete-auto-save-files t)		; 終了時にオートセーブファイルを消す
;;(display-time)			; モードラインに時刻表示
(which-function-mode 1)			; 現在の関数名をモードラインに表示
(setq truncate-partial-width-windows nil)

;;; デフォルトの文字コード
;(set-default-coding-systems 'euc-jp-unix)  <- shell等で文字化けするので無効化
(setq-default buffer-file-coding-system 'utf-8)

;;; キーワードで色分けする
(global-font-lock-mode t)

;;; リージョンをハイライトする
(transient-mark-mode t)

;;; 一行づつスクロール … 通常バッファ用
(setq scroll-conservatively 35
	  scroll-margin 0
	  scroll-step 1)
;;; 一行づつスクロール … shell バッファ用
(setq comint-scroll-show-maximum-output t)

;;; kill-ringを参照 -- browse-kill-ring
;;  下記 my-pcl-cvs-patch のエラーをなくすためだけに導入
;;;;(require 'browse-kill-ring)

;;; pcl-cvs設定
;;  pserver は各自の環境に合わせて設定して下さい。
(setq cvs-cvsroot ":pserver:USER@10.69.95.194:/usr/local/cvsroot");; ← 要編集
;; 文字化け対策パッチ … ログを一度ファイルに落して cvs ci -F する
;;;(eval-after-load "pcvs"
;;;  '(progn (load "my-pcl-cvs-patch")
;;;		  (setq my-cvs-do-commit-logfile-coding-system 'euc-japan-unix)))
(modify-coding-system-alist 'process "cvs" '(undecided . euc-jp-unix))
;; log はどのコードで書くか決めて → 特定文字が化けるため別途対策必要
(modify-coding-system-alist 'process "cvs" '(undecided . euc-jp-unix))

(autoload 'diff-mode "diff-mode" "Diff major mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(diffs?\\|patch\\|rej\\)\\'" . diff-mode))

;;; ediff 時にミニウィンドウを出さない
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; バッファーリスト表示時に分割しない
(global-set-key "\C-x\C-b" 'buffer-menu)

;; -------------------------------------------- 行番号
;;(require 'wb-line-number)
;;(wb-line-number-enable)
(set-scroll-bar-mode nil)                 ; no scroll bar, even in x-window system

;(defun lnon ()
;  (interactive)
;  (wb-line-number-enable))
;(defun lnoff ()
;  (interactive)
;  (wb-line-number-disable))

;;(lnon)

;; -------------------------------------------- backup file

;;;; １世代バックアップ
;(setq make-backup-files t)	; backup file 作る
;(setq vc-make-backup-files t)
;defun make-backup-file-name (filename)
;  (expand-file-name
;    (concat "~/.emacs.d/bak/" (file-name-nondirectory filename) "~")
;    (file-name-directory filename)))

;;;; 複数世代バックアップ
(setq make-backup-files t)	; backup file 作る
(setq vc-make-backup-files t)
;; 格納ディレクトリーの変更
;;   (対象ディレクトリー . 格納ディレクトリー) のリスト
(setq backup-directory-alist '((".*" . "~/.emacs.d/bak")))
;; 番号付けによる複数保存
(setq version-control     t)  ;; 実行の有無
(setq kept-new-versions   5)  ;; 最新の保持数
(setq kept-old-versions   1)  ;; 最古の保持数
(setq delete-old-versions t)  ;; 範囲外を削除

;; -------------------------------------------- CC-mode / GTAGS
;;;(setq load-path (cons "/usr/local/share/gtags" load-path))

(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode   "cc-mode" "C Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.cpp$" . c++-mode)
                ("\\.hpp$" . c++-mode)
                ("\\.c$"  . c++-mode)
                ("\\.h$"  . c++-mode)
                ("\\.hh$"  . c++-mode)
                ) auto-mode-alist))


;cc-mode のカスタマイズ
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'c-mode-common-hook
	'(lambda ()
	  (turn-on-font-lock)			; 
	  (c-set-style "gnu")
;	  (c-set-style "bsd")
;          (c-set-style "k&r")
;          (c-set-style "linux")
;	  (setq c-basic-offset 2)
;	  (setq tab-width 8)
	  (setq c-basic-offset 4)
	  (setq tab-width 4)
	  (setq c-auto-newline nil)	; 自動改行
	  (gtags-mode 1)		; GTAGS
	  (gtags-make-complete-list)
	  (local-set-key "\M-t" 'gtags-find-tag)
          (local-set-key "\M-r" 'gtags-find-rtag)
	  (local-set-key "\M-s" 'gtags-find-symbol)
	  (local-set-key "\M-p" 'gtags-find-pattern)
	  ;;(local-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
          (local-set-key "\C-t" 'gtags-pop-stack)
	  (setq comment-start "// ") ; //形式のコメント
	  (setq comment-end "")
	  ))

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

;; GDB setting
;;(defvar gud-gdb-history (list "mn10300-linux-gdb --annotate=1 apl_dispsrv.out"))
;;(defvar gud-gdb-history (list "/opt/montavista/pro/devkit/arm/v5t_le/bin/arm_v5t_le-gdb --annotate=1 drawtool"))
;;;(defvar gud-gdb-history (list "/usr/local/mips-4.3/bin/mips-linux-gnu-gdb --annotate=1 drawtool"))
;;;(defvar gud-gdb-history (list "/opt/redhat/arm-2010q1/bin/arm-none-linux-gnueabi-gdb --annotate=1 "))
;;(defvar gud-gdb-history (list "/home/hirai/sigma/131002_lfbc70/sdk4.2.1rc4/cs_rootfs_1.3.0/host/bin/mipsel-linux-gdb --annotate=1 drawtool"))
					; M-x gdb のデフォルトコマンドライン

;; -------------------------------------------- key bind

(define-key global-map [f1]  'start-kbd-macro)		; F1
(define-key global-map [f2]  'end-kbd-macro)            ; F2
(define-key global-map [f3]  'call-last-kbd-macro)      ; F3
(define-key global-map [f4]  'goto-line)		; F4

(define-key global-map [f5]  'tabbar-mode)      	; F5
(define-key global-map [f6]  'tabbar-backward)          ; F6
(define-key global-map [f7]  'tabbar-forward)		; F7
(define-key global-map [f8]  'yank)                     ; F8

(define-key global-map [f9]  'compile)                  ; F9
(define-key global-map [f10] 'next-error)               ; F10
(define-key global-map [f11] 'query-replace)            ; F11
(define-key global-map [f12] 'replace-string)           ; F12

(define-key global-map "\C-z" 'undo)			; UNDO
(define-key global-map [home] 'other-window)		; HOME
(define-key global-map [insert] 'ignore)		; disable INSERT

;; -------------------------------------------- GDB key bind
;; C-c C-w	gud-watch
;; C-x C-a C-b	gud-break
;; C-x C-a C-d	gud-remove
;; C-x C-a C-f	gud-finish
;; C-x C-a TAB	gud-stepi
;; C-x C-a C-j	gud-jump
;; C-x C-a C-l	gud-refresh
;; C-x C-a C-n	gud-next
;; C-x C-a C-p	gud-print
;; C-x C-a C-r	gud-cont
;; C-x C-a C-s	gud-step
;; C-x C-a C-t	gud-tbreak
;; C-x C-a C-u	gud-until
;; C-x C-a C-w	gud-watch
;; C-x C-a <	gud-up
;; C-x C-a >	gud-down

;; -------------------------------------------- MISC macro

(defun indent2 ()
	(interactive)
	(message "set tab width '4'")
	(setq tab-stop-list
	      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76))
	(setq-default tab-width 4)
	(setq c-basic-offset 2))
(defun tab4 ()
	(interactive)
	(message "set tab width '4'")
	(setq tab-stop-list
	      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76))
	(setq-default tab-width 4))
(defun tab3 ()
	(interactive)
	(message "set tab width '4'")
	(setq tab-stop-list
	      '(3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54 57))
	(setq-default tab-width 4)
	(setq c-basic-offset 3)
)

(defun tab8 ()
	(interactive)
	(message "set tab width '8'")
	(setq tab-stop-list
	      '(8 16 24 32 40 48 56 64 72 80 88 96 104 112 120 128 136 144))
	(setq-default tab-width 8))

(defun tmp ()
	(interactive)
	(switch-to-buffer "*tmp*"))

(defun euc ()
	(interactive)
	(set-buffer-file-coding-system (quote euc-japan-unix) nil))

(defun jis ()
	(interactive)
	(set-buffer-file-coding-system (quote junet-unix) nil))

(defun sjis ()
	(interactive)
	(set-buffer-file-coding-system (quote shift_jis-dos) nil))

(defun utf8 ()
	(interactive)
	(set-buffer-file-coding-system (quote utf-8) nil))

(defun utf16 ()
	(interactive)
	(set-buffer-file-coding-system (quote utf-16) nil))


;; ===========================================================================

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; turn on font-lock mode
(global-font-lock-mode t)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; GDB setting
;;(defvar gud-gdb-history (list "arm_v5t_le-gdb "))
;;(defvar gud-gdb-history (list "mn10300-linux-gdb --annotate=1 apl_dispsrv.out"))
; M-x gdb 

;; 見た目の設定
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(tool-bar-mode nil)
 '(transient-mark-mode nil))

;; -------------------------------------------- emacs size
;;(setq initial-frame-alist '((width  . (getenv "EMACSSIZEX")) (height . (getenv "EMACSSIZEY"))))
;;(setq initial-frame-alist '((width  . (getenv "EMACSSIZEX")) (height . (getenv "EMACSSIZEY"))))
(setq initial-frame-alist '((width  . 120) (height .  40)))

;; -------------------------------------------- emacs mozc
(when (equal (getenv "EMACSMOZC") "YES")
  (setq default-input-method "japanese-mozc")
  (require 'mozc)
  )
;; 半角スペースは Shift-Space で入力可

;; -------------------------------------------- emacs 色の設定
(when (equal (getenv "EMACSCOLOR") "BLUE")
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "#143A81" :foreground "#FFFFFF" :inverse-video nil :box nil
			   :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79
			   :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
)
(when (equal (getenv "EMACSCOLOR") "DARKBLUE")
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "#101540" :foreground "#FFFFFF" :inverse-video nil :box nil
			   :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79
			   :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
)
(when (equal (getenv "EMACSCOLOR") "GREEN")
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "#002B36" :foreground "#EEEEEE" :inverse-video nil :box nil
			   :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79
			   :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
)
(when (equal (getenv "EMACSCOLOR") "RED")
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "#400000" :foreground "#EEEEEE" :inverse-video nil :box nil
			   :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79
			   :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
)
(when (equal (getenv "EMACSCOLOR") "GRAY")
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "#303030" :foreground "#EEEEEE" :inverse-video nil :box nil
			   :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 79
			   :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
)

 
;; ===========================================================================
;;;; kbd macros
;;;;    Name the keyboard macro
;;;;      M-x name-last-kbd-macro
;;;;    insert macro to .emacs.
;;;;      Open .emacs and then do the following.
;;;;      M-x insert-kbd-macro RET macroname RET
(fset 'eq1
   [?\C-x ?\C-f ?~ ?/ ?e ?q ?1 ?/ return])
(fset 'eq1src
   [?\C-x ?\C-f ?~ ?/ ?e ?q ?1 ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?s ?t ?a ?r ?t ?u ?p ?/ ?u ?s ?r ?/ ?s ?r ?c ?/ return])
(fset 'sq1
   [?\C-x ?\C-f ?~ ?/ ?s ?q ?1 ?/ return])
(fset 'sq1src
   [?\C-x ?\C-f ?~ ?/ ?s ?q ?1 ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?S ?Q ?1 ?/ ?u ?s ?r ?/ ?s ?r ?c ?/ return])
(fset 'wm
   [?\C-x ?\C-f ?~ ?/ ?s ?t ?a ?r ?t ?u ?p ?_ ?p ?a ?n ?a ?a ?p ?p ?/ return])
(fset 'wmsrc
   [?\C-x ?\C-f ?~ ?/ ?s ?t ?a ?r ?t ?u ?p ?_ ?p ?a ?n ?a ?a ?p ?p ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?s ?t ?a ?r ?t ?u ?p ?r ?6 ?7 ?5 ?2 ?_ ?p ?a ?n ?a ?a ?p ?p ?/ ?u ?s ?r ?/ ?s ?r ?c ?/ return])
(fset 'wb
   [?\C-x ?\C-f ?~ ?/ ?s ?t ?a ?r ?t ?u ?p ?_ ?w ?h ?i ?t ?e ?b ?o ?a ?r ?d ?/ return])
(fset 'wbsrc
   [?\C-x ?\C-f ?~ ?/ ?s ?t ?a ?r ?t ?u ?p ?_ ?w ?h ?i ?t ?e ?b ?o ?a ?r ?d ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?s ?t ?a ?r ?t ?u ?p ?r ?6 ?5 ?9 ?1 ?_ ?w ?h ?i ?t ?e ?b ?o ?a ?r ?d ?/ ?u ?s ?r ?/ ?s ?r ?c ?/ return])
(fset 'sf2
   [?\C-x ?\C-f ?~ ?/ ?s ?f ?2 ?/ return])
(fset 'sf2src
   [?\C-x ?\C-f ?~ ?/ ?s ?f ?2 ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?s ?f ?2 ?/ ?u ?s ?r ?/ ?s ?r ?c ?/ return])
(fset 'bf1
   [?\C-x ?\C-f ?~ ?/ ?b ?f ?1 ?/ return])
(fset 'bf1src
   [?\C-x ?\C-f ?~ ?/ ?b ?f ?1 ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?b ?f ?1 ?n ?w ?/ ?A ?p ?p ?S ?r ?c ?/ return])
(fset 'bf1wm
   [?\C-x ?\C-f ?~ ?/ ?b ?f ?1 ?n ?w ?_ ?p ?a ?n ?a ?a ?p ?p ?_ ?h ?2 ?6 ?4 ?/ return])
(fset 'bf1wmsrc
   [?\C-x ?\C-f ?~ ?/ ?b ?f ?1 ?n ?w ?_ ?p ?a ?n ?a ?a ?p ?p ?_ ?h ?2 ?6 ?4 ?/ ?c ?u ?r ?r ?e ?n ?t ?_ ?b ?f ?1 ?n ?w ?r ?4 ?4 ?2 ?9 ?_ ?p ?a ?n ?a ?a ?p ?p ?_ ?h ?2 ?6 ?4 ?/ ?A ?p ?p ?S ?r ?c ?/ return])
(fset 'aichi
   [?\C-x ?\C-f ?~ ?/ ?a ?i ?c ?h ?i ?/ return])
(fset 'aichisrc
   [?\C-x ?\C-f ?~ ?/ ?a ?i ?c ?h ?i ?/ return])

;; ;; -------------------------------------------- straight
;; ;; https://nukosuke.hatenablog.jp/entry/straight-el
;; ;; 何も考えず公式のREADMEからコピペすればいいコード
;; ;; straight.el自身のインストールと初期設定を行ってくれる
;; (let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
;;       (bootstrap-version 3))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))
;; 
;; ;; use-packageをインストールする
;; (straight-use-package 'use-package)
;; 
;; ;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; ;; 本来は (use-package hoge :straight t) のように書く必要がある
;; (setq straight-use-package-by-default t)
;; 
;; ;; init-loaderをインストール&読み込み
;; (use-package init-loader)
;; 
;; ;; ~/.emacs.d/init/ 以下のファイルを全部読み込む
;; (init-loader-load "~/.emacs.d/init")

