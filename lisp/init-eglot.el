;; @see https://github.com/joaotavora/eglot
(use-package eglot
  :ensure t
  :hook
  ((go-mode rust-mode c-mode c++-mode) . eglot-ensure))

(provide 'init-eglot)
