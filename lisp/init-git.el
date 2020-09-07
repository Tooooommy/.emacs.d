;; @see https://github.com/magit/magit
(use-package magit
  :ensure t
  :defer 3
  :mode (("\\COMMIT_EDITMSG" . text-mode)
         ("\\MERGE_MSG" . text-mode)))

;; @see https://github.com/dgutov/diff-hl
(use-package diff-hl
  :ensure t
  :defer 3
  :init
  (global-diff-hl-mode 1)
  (diff-hl-dir-mode 1)
  (diff-hl-margin-mode 1)
  (advice-add 'svn-status-update-modeline :after #'diff-hl-update)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

(provide 'init-git)

;;; init-git.el
