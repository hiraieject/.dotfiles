

(when (equal (getenv "EMACSSTRAIGHT") "YES")
  ;; STRAIGHT が有効なときは package.el の自動有効化を止める
  (setq package-enable-at-startup nil))



