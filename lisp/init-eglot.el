;; @see https://github.com/joaotavora/eglot
(use-package eglot
  :ensure t
  :defer 3
  :hook
  ((go-mode . eglot-ensure)
   (rust-mode . eglot-ensure)
   (c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)))

;; flymake
(use-package flymake
  :ensure nil
  :defer 3
  :hook (eglot-mode . flymake-mode))

;; @see https://github.com/meqif/flymake-diagnostic-at-point
(use-package flymake-diagnostic-at-point
  :ensure t
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

(provide 'init-eglot)
;;; init-eglot.el
