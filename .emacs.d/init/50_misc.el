
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; #highlight-indent-guides
;;
(when (equal (getenv "EMACSSTRAIGHT") "YES")
  (straight-use-package 'highlight-indent-guides)

  ;;(setq highlight-indent-guides-method 'character
  ;;	highlight-indent-guides-character 124
  ;;	highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-method 'fill)

  ;;(define-key my-toggle-map (kbd "h") 'highlight-indent-guides-mode)

  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))
