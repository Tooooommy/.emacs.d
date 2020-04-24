;; @see https://github.com/dominikh/yasnippet-go
;; @see https://github.com/dominikh/go-mode.el
(use-package go-mode
  :ensure t
  :after evil-mode
  :mode ("//.go//'" . go-mode)
  :hook (go-mode . (lambda() 
                     (lsp-deferred)
                     (dumb-jump-mode t) 
                     (yas-minor-mode t) 
                     (setq tab-width 2)))
  :bind (:map go-mode-map
         ("<f1>" . go-remove-unused-imports)
         ("<f2>" . godoc-at-point))
  :config 
  ;; Env vars
  (with-eval-after-load 'exec-path-from-shell
    (exec-path-from-shell-copy-envs '("GOPATH" "GO111MODULE" "GOPROXY")))
  ;; Install or update tools
  (defvar go--tools '("golang.org/x/tools/cmd/goimports"
                      "github.com/go-delve/delve/cmd/dlv"
                      "github.com/josharian/impl"
                      "github.com/cweill/gotests/..."
                      "github.com/fatih/gomodifytags"
                      "github.com/davidrjenni/reftools/cmd/fillstruct")
    "All necessary go tools.")

  ;; Do not use the -u flag for gopls, as it will update the dependencies to incompatible versions
  ;; https://github.com/golang/tools/blob/master/gopls/doc/user.md#installation
  (defvar go--tools-no-update '("golang.org/x/tools/gopls@latest")
    "All necessary go tools without update the dependencies.")

  (defun go-update-tools ()
    "Install or update go tools."
    (interactive)
    (unless (executable-find "go")
      (user-error "Unable to find `go' in `exec-path'!"))

    (message "Installing go tools...")
    (let ((proc-name "go-tools")
          (proc-buffer "*Go Tools*"))
      (dolist (pkg go--tools-no-update)
        (set-process-sentinel
         (start-process proc-name proc-buffer "go" "get" "-v" pkg)
         (lambda (proc _)
           (let ((status (process-exit-status proc)))
             (if (= 0 status)
                 (message "Installed %s" pkg)
               (message "Failed to install %s: %d" pkg status))))))

      (dolist (pkg go--tools)
        (set-process-sentinel
         (start-process proc-name proc-buffer "go" "get" "-u" "-v" pkg)
         (lambda (proc _)
           (let ((status (process-exit-status proc)))
             (if (= 0 status)
                 (message "Installed %s" pkg)
               (message "Failed to install %s: %d" pkg status))))))))
  
  ;; Try to install go tools if `gopls' is not found
  (unless (executable-find "gopls")
    (go-update-tools))


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
    :bind (:map go-mode-map
           ("C-c t a" . go-test-current-project)
           ("C-c t m" . go-test-current-file)
           ("C-c t ." . go-test-current-test)
           ("C-c t x" . go-run)))

  ;; @see https://github.com/s-kostyaev/go-gen-test
  (use-package go-gen-test
    :bind (:map go-mode-map
           ("C-c t g" . go-gen-test-dwim)))

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
;;; init-go.el ends here
