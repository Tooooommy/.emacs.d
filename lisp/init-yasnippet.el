;; @see https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook (prog-mode . yas-global-mode)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))

  ;; @see https://github.com/AndreaCrotti/yasnippet-snippets
  (use-package yasnippet-snippets :ensure t))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
