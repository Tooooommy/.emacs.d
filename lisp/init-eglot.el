;; @see https://github.com/joaotavora/eglot
(use-package eglot
  :ensure t
  :hook
  (prog-mode . eglot-ensure))

(provide 'init-eglot)
