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

  ;; @see https://github.com/emacs-helm/helm-ls-git
  (use-package helm-ls-git
    :ensure t)

  ;; @see https://github.com/magit/forge
  (use-package forge
    :ensure t
    :demand)

  ;; @see https://github.com/alphapapa/magit-todos
  (use-package magit-todos
    :ensure t
    :config (magit-todos-mode t))

  ;; @see https://github.com/jtatarik/magit-gitflow
  (use-package magit-gitflow
    :ensure t
    :config (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))


  ;; @see https://gitlab.com/pidu/git-timemachine
  (use-package git-timemachine
    :ensure t
    :custom-face
    (git-timemachine-minibuffer-author-face ((t (:inherit success))))
    (git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
    :bind (:map vc-prefix-map
           ("t" . git-timemachine)))

  ;; @see https://github.com/syohex/emacs-git-messenger
  (use-package git-messenger
    :ensure t
    :bind (:map vc-prefix-map
           ("p" . git-messenger:popup-message)
           :map git-messenger-map
           ("m" . git-messenger:copy-message))
    :init (setq git-messenger:use-magit-popup t))

  ;; @see https://github.com/dgutov/diff-hl
  (use-package diff-hl
    :ensure t
    :hook(after-init . global-diff-hl-mode))
  )


(provide 'init-git)

;;; init-git.el ends here
