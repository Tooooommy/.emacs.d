;; @see https://github.com/magit/magit
(use-package magit
  :ensure t
  :defer t
  :mode (("\\COMMIT_EDITMSG" . text-mode)
         ("\\MERGE_MSG" . text-mode))
  :bind
  (("C-x g" . magit-status)
   ("C-x M-g" . magit-dispatch)
   ("C-c M-g" . magit-file-popup))
  :config

  ;; @see https://github.com/emacs-evil/evil-magit
  (use-package evil-magit
    :ensure t )

  ;; @see https://github.com/magit/forge
  (use-package forge
    :ensure t
    :demand)

  ;; @see https://gitlab.com/pidu/git-timemachine
  (use-package git-timemachine
    :ensure t))

;; @see https://github.com/dgutov/diff-hl
(use-package diff-hl
  :ensure t
  :hook (after-init . global-diff-hl-mode)
  :config
  (diff-hl-dir-mode)
  (advice-add 'svn-status-update-modeline :after #'diff-hl-update)
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  )



(provide 'init-git)

;;; init-git.el ends here
