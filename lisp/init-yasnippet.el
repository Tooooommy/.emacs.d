;; @see https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :defer 3
  :diminish yas-minor-mode
  :hook (prog-mode . yas-global-mode)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))

  ;; @see https://github.com/AndreaCrotti/yasnippet-snippets
  (use-package yasnippet-snippets
    :ensure t
    :defer 3
    ))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
