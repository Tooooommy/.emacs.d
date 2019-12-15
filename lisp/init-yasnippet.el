;; @see https://github.com/abo-abo/auto-yasnippet
(use-package auto-yasnippet
  :ensure t
  :bind (
         ("H-w" . #'aya-create)
         ("H-y" . #'aya-expand)))

;; @see https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1)
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets" ;; personal snippets
          ))

  ;; @see https://github.com/AndreaCrotti/yasnippet-snippets
  (use-package yasnippet-snippets
    :ensure t
    :diminish yas-minor-mode
    :hook (after-init . yas-global-mode)
    :config (use-package yasnippet-snippets :ensure t)))

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
