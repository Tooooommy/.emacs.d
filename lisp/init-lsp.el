;; @see https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :defines (lsp-clients-python-library-directories lsp-rust-rls-server-command)
  :commands (lsp-enable-which-key-integration lsp-format-buffer lsp-organize-imports)
  :hook ((prog-mode . (lambda ()
                        (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                          (lsp-deferred))))
         (lsp-mode . (lambda ()
                       (lsp-enable-which-key-integration)
                       (unless (apply #'derived-mode-p '(c-mode c++-mode go-mode))
                         (add-hook 'before-save-hook #'lsp-format-buffer t t)
                         (add-hook 'before-save-hook #'lsp-organize-imports)))))
  :bind (:map lsp-mode-map
         ("C-c C-d" . lsp-describe-thing-at-point)
         ([remap xref-find-definitions] . lsp-find-definition)
         ([remap xref-find-references] . lsp-find-references))
  :init
  ;; @see https://github.com/emacs-lsp/lsp-mode#performance
  (setq read-process-output-max (* 1024 1024))

  (setq lsp-auto-guess-root nil ;; Detect project root
        lsp-keep-workspace-alive nil ; auto kill lsp server
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-prefer-capf t
        lsp-keymap-prefix "C-c l")

  ;; For `lsp-clients'
  (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
  (unless (executable-find "rls")
    (setq lsp-rust-rls-server-command '("rustup" "run" "stable" "rls"))))

;; @see https://github.com/emacs-lsp/lsp-ui
(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :functions my-lsp-ui-imenu-hide-mode-line
  :commands lsp-ui-doc-hide
  :custom-face 
  ;;(lsp-ui-doc-background ((t (:background ,(face-background 'tooltip)))))
  (lsp-ui-sideline-code-action ((t (:inherit warning))))

  :bind ("C-c u" . lsp-ui-imenu)
  :hook (lsp-mode . lsp-ui-mode)
  :init (setq lsp-ui-doc-enable t
              lsp-ui-doc-use-webkit nil
              lsp-ui-doc-delay 0.2
              lsp-ui-doc-include-signature t
              lsp-ui-doc-position 'at-point
              lsp-ui-doc-border (face-foreground 'default)
              lsp-eldoc-enable-hover nil ; Disableeldoc displays in minibuffer
              
              lsp-ui-sideline-enable t
              lsp-ui-sideline-show-hover nil
              lsp-ui-sideline-show-diagnostics nil
              lsp-ui-sideline-ignore-duplicate t
              lsp-ui-imenu-enable t)

  :config
  (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

  ;; `C-g to close doc
  (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

  ;; Reset `lsp-ui-doc-background' after loading theme
  (add-hook 'after-load-theme-hook (lambda ()
                                     (setq lsp-ui-doc-border (face-foreground 'default))
                                     (set-face-background 'lsp-ui-doc-background
                                                          (face-background 'tooltip)))))
;; @see https://github.com/tigersoldier/company-lsp
(use-package company-lsp
  :ensure t
  :after company-mode
  :init (push 'company-lsp company-backends)
  :config
  (company-lsp--cache-item-candidates 'auto)
  (setq company-lsp-async t
        company-lsp-enable-snippet t
        company-lsp-enable-recompletion t))

;; @see https://github.com/emacs-lsp/dap-mode
(use-package dap-mode
  :functions dap-hydra/nil
  :diminish
  :bind (:map lsp-mode-map
         ("<f5>" . dap-debug)
         ("M-<f5>" . dap-hydra))
  :hook ((after-init . dap-mode)
         (dap-mode . dap-ui-mode)
         (dap-session-created . (lambda (_args) (dap-hydra)))
         (dap-stopped . (lambda (_args) (dap-hydra)))
         (dap-terminated . (lambda (_args) (dap-hydra/nil)))

         (python-mode . (lambda () (require 'dap-python)))
         (go-mode . (lambda () (require 'dap-go)))
         (rust-mode . (lambda () (require 'dap-lldb)))
         ((c-mode c++-mode objc-mode swift-mode) . (lambda () (require 'dap-lldb)))))

;; @see https://github.com/emacs-lsp/lsp-treemacs
(use-package lsp-treemacs
  :ensure t
  :after lsp-mode
  :init (lsp-treemacs-sync-mode 1)
  :bind (:map lsp-mode-map
         ("C-<f8>" . lsp-treemacs-errors-list)
         ("C-<f8>" . lsp-treemacs-symbols))
  :config (with-eval-after-load 'ace-window
            (when (boundp 'aw-ignored-buffers)
              (push 'lsp-treemacs-symbols-mode aw-ignored-buffers)
              (push 'lsp-treemacs-java-deps-mode aw-ignored-buffers))))

;; Microsoft python-language-server support
(use-package lsp-python-ms
  :hook (python-mode . (lambda () (require 'lsp-python-ms)))
  :init
  (when (executable-find "python3")
    (setq lsp-python-ms-python-executable-cmd "python3")))


;; C/C++/Objective-C support
(use-package ccls
  :defines projectile-project-root-files-top-down-recurring
  :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls)))
  :config
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json" ".ccls")
                  projectile-project-root-files-top-down-recurring))))



(provide 'init-lsp)

;;; init-lsp.el ends here
