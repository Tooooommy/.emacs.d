;; @see https://github.com/flycheck/flycheck
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :hook (after-init . global-flycheck-mode)
  :config
  ;;(ispell-change-dictionary "american" t)
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-indication-mode 'right-fringe)
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
      [16 48 112 240 112 48 16] nil nil 'center))

  ;; @see https://github.com/alexmurray/flycheck-posframe
  (use-package flycheck-posframe
    :ensure t
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))

  ;; @see https://github.com/flycheck/flycheck-pos-tip
  (use-package flycheck-pos-tip
    :ensure t
    :defines flycheck-pos-tip-timeout
    :hook (global-flycheck-mode . flycheck-pos-tip-mode)
    :config (setq flycheck-pos-tip-timeout 30)))

(provide 'init-flycheck)
;;; init-flycheck ends here
