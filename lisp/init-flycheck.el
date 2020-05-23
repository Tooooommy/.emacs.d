;; @see https://github.com/flycheck/flycheck
(use-package flycheck
  :ensure t
  :defer 3
  :commands flycheck-redefine-standard-error-levels
  :hook (after-init . global-flycheck-mode)
  :init (setq flycheck-global-modes
              '(not text-mode outline-mode fundamental-mode lisp-interaction-mode
                    org-mode diff-mode shell-mode eshell-mode term-mode vterm-mode)
              flycheck-emacs-lisp-load-path 'inherit
              flycheck-indication-mode (if (display-graphic-p)
                                           'right-fringe
                                         'right-margin)
              ;; Only check while saving and opening files
              flycheck-check-syntax-automatically '(save mode-enabled))
  :config
  ;; Prettify indication styles
  (when (fboundp 'define-fringe-bitmap)
    (define-fringe-bitmap 'flycheck-fringe-bitmap-arrow
      [16 48 112 240 112 48 16] nil nil 'center))
  (flycheck-redefine-standard-error-levels "⏴" 'flycheck-fringe-bitmap-arrow)

  ;; @see https://github.com/flycheck/flycheck-pos-tip
  (use-package flycheck-pos-tip
    :ensure t
    :defer 3
    :defines flycheck-pos-tip-timeout
    :hook (global-flycheck-mode . flycheck-pos-tip-mode)
    :config (setq flycheck-pos-tip-timeout 30))
  )

(provide 'init-flycheck)
;;; init-flycheck.el ends
