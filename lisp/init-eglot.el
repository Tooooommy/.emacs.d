;; @see https://github.com/joaotavora/eglot
(use-package eglot
  :ensure t
  :hook
  ((go-mode . eglot-ensure)
   (rust-mode . eglot-ensure)
   (c-mode . eglot-ensure)
   (c++-mode . eglot-ensure)))

(provide 'init-eglot)
