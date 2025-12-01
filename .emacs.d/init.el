;; .emacs

;; -------------------------------------------- emacs size
;;(setq initial-frame-alist '((width  . (getenv "EMACSSIZEX")) (height . (getenv "EMACSSIZEY"))))
;;(setq initial-frame-alist '((width  . (getenv "EMACSSIZEX")) (height . (getenv "EMACSSIZEY"))))
(setq initial-frame-alist '((width  . 120) (height .  40)))


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
 	 (cons '(menu-bar-lines . 1)
	  (cons '(tool-bar-lines . 1)
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

;; disable lock for CIFS mount
(setq create-lockfiles nil)

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
;(setq cvs-cvsroot ":pserver:USER@10.69.95.194:/usr/local/cvsroot");; ← 要編集
;; 文字化け対策パッチ … ログを一度ファイルに落して cvs ci -F する
;;;(eval-after-load "pcvs"
;;;  '(progn (load "my-pcl-cvs-patch")
;;;		  (setq my-cvs-do-commit-logfile-coding-system 'euc-japan-unix)))
;(modify-coding-system-alist 'process "cvs" '(undecided . euc-jp-unix))
;; log はどのコードで書くか決めて → 特定文字が化けるため別途対策必要
;(modify-coding-system-alist 'process "cvs" '(undecided . euc-jp-unix))

(autoload 'diff-mode "diff-mode" "Diff major mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(diffs?\\|patch\\|rej\\)\\'" . diff-mode))

;;; ediff 時にミニウィンドウを出さない
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; バッファーリスト表示時に分割しない
(global-set-key "\C-x\C-b" 'buffer-menu)

;; -------------------------------------------- proxy
(defvar proxy-server (getenv "PROXY_SERVER"))
(when (and proxy-server (not (equal proxy-server "NONE")))
  (setq url-proxy-services
	`(("http" . ,proxy-server)
	  ("https" . ,proxy-server))))

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

(defun dos ()
	(interactive)
	(set-buffer-file-coding-system (quote dos) nil))

(defun unix ()
	(interactive)
	(set-buffer-file-coding-system (quote unix) nil))


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
 '(flycheck-checker-error-threshold 800)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(tool-bar-mode nil)
 '(transient-mark-mode nil))

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

(when (equal (getenv "EMACSCOLOR") "MINGW64")
  (custom-set-faces
   '(default ((t (:inherit nil :stipple nil :background "#202040" :foreground "#EEEEEE" :inverse-video nil :box nil
			   :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100
			   :width normal :foundry "unknown" :family "Courier New")))))
)

 
;; ===========================================================================
;;;; kbd macros
;;;;    Name the keyboard macro
;;;;      M-x name-last-kbd-macro
;;;;    insert macro to .emacs.
;;;;      Open .emacs and then do the following.
;;;;      M-x insert-kbd-macro RET macroname RET


;; ===========================================================================
(let ((msystem (getenv "MSYSTEM")))
  (when msystem
    ;; MSYSTEMが設定されていた場合の処理
    (setenv "EMACS_IGNORE_COMPAMYTABNINE" "YES")
    ))

(when (equal (getenv "EMACSSTRAIGHT") "YES")
  (load "~/.emacs.d/init/01_straight.el")
  (load "~/.emacs.d/init/02_mozc.el")
  (load "~/.emacs.d/init/03_ccmode.el")
  (load "~/.emacs.d/init/10_company.el")
  (load "~/.emacs.d/init/20_chatgpt.el")
  (load "~/.emacs.d/init/21_copilot.el")
  ;;(load "~/.emacs.d/init/30_yasnippet.el")
  (load "~/.emacs.d/init/50_misc.el")
  )

(when (not (equal (getenv "EMACSSTRAIGHT") "YES"))
  ;; Straight 無効時の処理
  
  ;; -------------------------------------------- gtags
  (require 'gtags)
  (add-hook 'c-mode-common-hook 'gtags-mode)
  (add-hook 'c-mode-hook 'my-c-mode-hook)
  (add-hook 'c++-mode-hook 'my-c-mode-hook)

  (when (equal (getenv "EMACSMOZC") "YES")
    ;; -------------------------------------------- emacs mozc
    (require 'mozc)
    (setq default-input-method "japanese-mozc")
    
    ;; -------------------------------------------- boiled-mozc
    (autoload 'boiled-mozc-rK-conv "boiled-mozc"
      "Romaji to Kana-Kanji conversion" t)
    (autoload 'boiled-mozc-rhkR-conv "boiled-mozc"
      "Romaji to Hiragana conversion" t)
    (global-set-key "\C-o" 'boiled-mozc-rK-conv)
    (global-set-key "\M-o" 'boiled-mozc-rhkR-conv)
    
    )
  )

;; ===========================================================================
;; GDB setting
;;(defvar gud-gdb-history (list "mn10300-linux-gdb --annotate=1 apl_dispsrv.out"))
;;(defvar gud-gdb-history (list "/opt/montavista/pro/devkit/arm/v5t_le/bin/arm_v5t_le-gdb --annotate=1 drawtool"))
;;;(defvar gud-gdb-history (list "/usr/local/mips-4.3/bin/mips-linux-gnu-gdb --annotate=1 drawtool"))
;;;(defvar gud-gdb-history (list "/opt/redhat/arm-2010q1/bin/arm-none-linux-gnueabi-gdb --annotate=1 "))
;;(defvar gud-gdb-history (list "/home/hirai/sigma/131002_lfbc70/sdk4.2.1rc4/cs_rootfs_1.3.0/host/bin/mipsel-linux-gdb --annotate=1 drawtool"))
					; M-x gdb のデフォルトコマンドライン

;; ===========================================================================
;; 背景色と文字色を設定する関数
(defun set-dark-theme (bg-color)
  "Set background to BG-COLOR and foreground to white."
  (interactive "sBackground color: ")
  (set-face-background 'default bg-color)
  ;;(set-face-foreground 'default "white")
  )

;; 個別の色コマンド
(defun blue ()
  "Set dark blue background."
  (interactive)
  (set-dark-theme "#001f3f")) ;; 暗めのダークブルー

(defun green ()
  "Set dark green background."
  (interactive)
  (set-dark-theme "#003300")) ;; 暗めのダークグリーン

(defun orange ()
  "Set dark orange background."
  (interactive)
  (set-dark-theme "#331a00")) ;; 暗めのオレンジ系

(defun purple ()
  "Set dark purple background."
  (interactive)
  (set-dark-theme "#1a0033")) ;; 暗めのパープル

(defun gray ()
  "Set dark gray background."
  (interactive)
  (set-dark-theme "#1a1a1a")) ;; 暗めのグレー

;; パスに応じて背景色を切り替える関数
(defun set-background-by-path-or-dir ()
  "Change background color and title based on file or dired directory."
  (let ((path (or (buffer-file-name) default-directory)))
    (when path
      (cond
       ((string-match "/home/hirai/develop-en/" path)
        (set-dark-theme "#003300")
        (setq frame-title-format "Panasonic-ENERGY"))
       ((string-match "/home/hirai/develop-ht/" path)
        (set-dark-theme "#331a00")
        (setq frame-title-format "HITACHI-Linux"))
       ((string-match "/home/hirai/develop-pj/" path)
        (setq frame-title-format "Panasonic-PJ"))
       ((string-match "/home/hirai/develop-fp/" path)
        (setq frame-title-format "Panasonic-FP"))
       ((string-match "/home/hirai/develop-home/" path)
        (setq frame-title-format "hirai-private"))
       ((string-match "/home/hirai/MemoData/" path)
        (setq frame-title-format "hirai-MemoData"))))))

;; ファイルを開いたとき
(add-hook 'find-file-hook 'set-background-by-path-or-dir)
;; 以下はうまくいかんので、DIREDでの色替えは封印
;;  ;; Diredでディレクトリ移動時に対応（Emacs 27用）
;;  (advice-add 'dired-advertised-find-file :after
;;              (lambda (&rest _) (set-background-by-path-or-dir)))
;;  ;; Diredで再読み込み時にも対応
;;  (add-hook 'dired-after-readin-hook 'set-background-by-path-or-dir)


