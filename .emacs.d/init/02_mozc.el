
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

;; ;; -------------------------------------------- emacs mozc
;; (setq default-input-method "japanese-mozc")
;; (use-package mozc)
;; ;;   (require 'mozc)
;; ;; 半角スペースは Shift-Space で入力可
;; 
;; ;; -------------------------------------------- boiled-mozc
;; 
;; ;; https://github.com/tadanagao/boiled-mozc
;; 
;; (straight-use-package
;; '(boiled-mozc :type git :host github :repo "tadanagao/boiled-mozc" :files ("dist" "*.el")))
;; 
;; (autoload 'boiled-mozc-rK-conv "boiled-mozc"
;; "Romaji to Kana-Kanji conversion" t)
;; (autoload 'boiled-mozc-rhkR-conv "boiled-mozc"
;; "Romaji to Hiragana conversion" t)
;; (global-set-key "\C-o" 'boiled-mozc-rK-conv)
;; (global-set-key "\M-o" 'boiled-mozc-rhkR-conv)
