;; @see https://github.com/abo-abo/auto-yasnippet
(use-package auto-yasnippet
  :ensure t)

;; @see https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))

  ;; @see https://github.com/AndreaCrotti/yasnippet-snippets
  (use-package yasnippet-snippets
    :ensure t
    :diminish yas-minor-mode
    :hook (after-init . yas-global-mode)))

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
