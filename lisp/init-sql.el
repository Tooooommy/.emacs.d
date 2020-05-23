;; @see https://github.com/alex-hhh/emacs-sql-indent
(use-package sql-indent
  :ensure t
  :defer 3
  :after (:any sql sql-interactive-mode)
  :delight sql-mode "Σ ")

(provide 'init-sql)
;;; init-sql.el
