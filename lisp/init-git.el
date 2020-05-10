;; @see https://github.com/magit/magit
(use-package magit
  :ensure t
  :mode (("\\COMMIT_EDITMSG" . text-mode)
         ("\\MERGE_MSG" . text-mode))
  :config
  ;; @see https://github.com/magit/forge
  (use-package forge
    :ensure t))

;; @see https://github.com/dgutov/diff-hl
(use-package diff-hl
  :ensure t
  :defer t
  :init
  (global-diff-hl-mode 1)
  (diff-hl-dir-mode 1)
  :config
  (advice-add 'svn-status-update-modeline :after #'diff-hl-update)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))
(setq auto-revert-check-vc-info t)

(provide 'init-git)

;;; init-git.el ends here
