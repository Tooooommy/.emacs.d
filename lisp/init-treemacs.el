;; @see https://github.com/Alexander-Miller/treemacs
(use-package treemacs
  :ensure t
  :defer t
  :commands (treemacs-follow-mode
             treemacs-filewatch-mode
             treemacs-fringe-indicator-mode
             treemacs-git-mode)
  :bind ("M-0" . treemacs-select-window)
  :config 
  (setq treemacs-collapse-dirs                 (if treemacs-python-executable 3 0)
        treemacs-is-never-other-window         nil
        treemacs-follow-after-init             t
        treemacs-silent-filewatch              t
        treemacs-silent-refresh                t
        treemacs-width                         30
        treemacs-no-png-images                 nil)

  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
    (`(t . t) (treemacs-git-mode 'deferred))
    (`(t . _) (treemacs-git-mode 'simple)))

  (use-package treemacs-projectile
    :ensure t
    :after treemacs projectile)

  (use-package treemacs-icons-dired
    :ensure t
    :after treemacs dired
    :hook (after-init . treemacs-icons-dired-mode))

  (use-package treemacs-magit
    :after magit
    :commands treemacs-magit--schedule-update
    :hook ((magit-post-commit
            git-commit-post-finish
            magit-post-stage
            magit-post-unstage)
           . treemacs-magit--schedule-update)))

(provide 'init-treemacs)
;;; init-treemacs.el ends here
