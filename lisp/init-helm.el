;; @see https://github.com/emacs-helm/helm
(use-package helm
  :ensure t
  :defer 3
  :hook (after-init . helm-mode)
  :config
  ;; config 
  (require 'helm-config)
  (setq helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-apropos-fuzzy-match t
        helm-display-header-line nil
        helm-ff-file-name-history-use-recentf t
        helm-autoresize-max-height 20
        helm-autoresize-min-height 20
        helm-buffer-max-length 55
        helm-split-window-inside-p t
        helm-M-x-always-save-history t
        helm-locate-command "mdfind %s %s")

  ;; @see https://github.com/emacsorphanage/helm-swoop
  (use-package helm-swoop
    :ensure t
    :defer 3
    :config
    (setq helm-multi-swoop-edit-save t
          helm-swoop-split-with-multiple-windows nil
          helm-swoop-split-direction 'split-window-vertically
          helm-swoop-speed-or-color nil
          helm-swoop-move-to-line-cycle t
          helm-swoop-use-fuzzy-match t
          helm-swoop-use-line-number-face t))
  
  ;; @see https://github.com/emacs-helm/helm-ls-git
  (use-package helm-ls-git
    :ensure t
    :defer 3
    )

  ;; @see https://github.com/jupl/helm-gitignore
  (use-package helm-gitignore
    :ensure t
    :defer 3
    )

  ;; @see https://github.com/emacs-helm/helm-descbinds
  (use-package helm-descbinds
    :ensure t
    :defer 3
    :hook (helm-mode . helm-descbinds-mode))

  ;; @see https://github.com/emacs-helm/helm-org
  (use-package helm-org
    :ensure t
    :defer 3
    )

  ;; @see https://github.com/bbatsov/helm-projectile
  (use-package helm-projectile
    :ensure t
    :defer 3
    :config
    (setq helm-projectile-fuzzy-match t))
  )

(provide 'init-helm)
