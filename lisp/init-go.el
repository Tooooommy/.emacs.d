;; @see https://github.com/dominikh/yasnippet-go
;; @see mhttps://github.com/dominikh/go-mode.el
(use-package go-mode
  :ensure t
  :after evil-mode
  :mode ("//.go//'" . go-mode)
  :hook (go-mode . (lambda() 
                     (lsp-deferred)
                     (dumb-jump-mode t) 
                     (yas-minor-mode t) 
                     (setq tab-width 2)))
  :config 
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save)

  ;; @see https://github.com/syohex/emacs-go-eldoc
  (use-package go-eldoc
    :ensure t
    :hook (go-mode . go-eldoc-setup)
    :config
    (set-face-attribute 'eldoc-highlight-function-argument nil
                        :underline t
                        :foreground "green"
                        :weight 'bold))

  ;; @see https://github.com/godoctor/godoctor
  (use-package godoctor
    :ensure t)

  ;; @see https://github.com/benma/go-dlv.el
  (use-package go-dlv
    :ensure t)

  ;; @see https://github.com/s-kostyaev/go-fill-struct
  (use-package go-fill-struct
    :ensure t)

  ;; @see https://github.com/syohex/emacs-go-impl
  (use-package go-impl
    :ensure t)

  ;; @see https://github.com/nlamirault/gotest.el
  (use-package gotest
    :ensure t)

  ;; @see https://github.com/brantou/emacs-go-tag
  (use-package go-tag
    :ensure t
    :config (setq go-tag-args (list "-transform" "snakecase")))

  ;; @see https://github.com/weijiangan/flycheck-golangci-lint
  (use-package flycheck-golangci-lint
    :ensure t
    :after flycheck
    :defines flycheck-disabled-checkers
    :hook 
    (go-mode . (lambda () 
                 "Enable golangci-lint"
                 (setq flycheck-disabled-checkers '(go-gofmt
                                                    go-golint
                                                    go-vet
                                                    go-build
                                                    go-test
                                                    go-errcheck))
                 (flycheck-golangci-lint-setup)))))

;; @see https://github.com/grafov/go-playground
(use-package go-playground
  :ensure t 
  :diminish)

(provide 'init-go)
