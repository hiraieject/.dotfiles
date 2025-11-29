
(when (and (>= emacs-major-version 27)
           (equal (getenv "EMACSUSEYASNIPPET") "YES"))
  
  (use-package yasnippet
    :ensure t
    :hook ((text-mode
            prog-mode
            conf-mode
            snippet-mode) . yas-minor-mode-on)
    :init
    (setq yas-snippet-dir "~/.emacs.d/snippets"))
  
  (use-package yasnippet-snippets         ; Collection of snippets
    :ensure t)
  )
