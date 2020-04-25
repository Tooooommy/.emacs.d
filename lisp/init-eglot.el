;; @see https://github.com/joaotavora/eglot
(use-package eglot
  :ensure t
  :hook
  ((go-mode
    rust-mode) . eglot-ensure))

(provide 'init-eglot)
