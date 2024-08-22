
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; #highlight-indent-guides
;;
(use-package highlight-indent-guides
  )

;;(setq highlight-indent-guides-method 'character
;;	highlight-indent-guides-character 124
;;	highlight-indent-guides-responsive 'top)
(setq highlight-indent-guides-method 'fill)

;;(define-key my-toggle-map (kbd "h") 'highlight-indent-guides-mode)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Flycheck check error background
;; https://www.flycheck.org/en/latest/languages.html
;;
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)
