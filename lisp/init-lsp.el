;; @see https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :hook (prog-mode . (lambda ()
                       (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                         (lsp-deferred))))
  :init
  (setq lsp-auto-guess-root t ;; Detect project root
        lsp-keep-workspace-alive nil ; auto kill lsp server
        lsp-enable-indentation nil
        lsp-prefer-flymake nil     ;; Use lsp-ui and flycheck
        flymake-fringe-indicator-position 'right-fringe)

  :config ;; Configure LSP clients

  ;; @see https://github.com/emacs-lsp/lsp-ui
  (use-package lsp-ui
    :ensure t
    :after lsp
    :diminish
    :hook (lsp-mode . lsp-ui-mode)
    :functions my-lsp-ui-imenu-hide-mode-line
    :commands lsp-ui-doc-hide
    :custom-face 
    ;;(lsp-ui-doc-background ((t (:background ,(face-background 'tooltip)))))
    (lsp-ui-sideline-code-action ((t (:inherit warning))))

    :init
    (setq lsp-ui-doc-enable t
          lsp-ui-doc-use-webkit nil
          lsp-ui-doc-delay 0.5
          lsp-ui-doc-include-signature t
          lsp-ui-doc-position 'top
          lsp-ui-doc-border (face-foreground 'default)
          lsp-eldoc-enable-hover nil ; Disableeldoc displays in minibuffer
          
          lsp-ui-sideline-enable t
          lsp-ui-sideline-show-hover nil
          lsp-ui-sideline-show-diagnostics nil
          lsp-ui-sideline-ignore-duplicate t
          
          lsp-ui-imenu-enable t)

    :bind
    (:map lsp-ui-mode-map
     ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
     ([remap xref-find-references] . lsp-ui-peek-find-references))
    
    :config
    (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

    ;; `C-g to close doc
    (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

    ;; Reset `lsp-ui-doc-background' after loading theme
    (add-hook 'after-load-theme-hook (lambda ()
                                       (setq lsp-ui-doc-border (face-foreground 'default))
                                       (set-face-background 'lsp-ui-doc-background
                                                            (face-background 'tooltip))))
    ;; workround hide mode-line of the lsp-ui-imenu buffer
    ;; @see https://github.com/emacs-lsp/lsp-ui/issues/24
    (defun my-lsp-ui-imenu-hide-mode-line ()
      "Hide the mode-line in lsp-ui-imenu"
      (setq mode-line-format nil))
    (advice-add #'lsp-ui-imenu :after #'my-lsp-ui-imenu-hide-mode-line))

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
           (go-mode . (lambda () (require 'dap-go)))
           (rust-mode . (lambda () (require 'dap-lldb)))))

  ;; @see https://github.com/emacs-lsp/lsp-treemacs
  (use-package lsp-treemacs
    :ensure t
    :init (lsp-treemacs-sync-mode 1)
    :config (progn (lsp-metals-treeview-enable t)
                   (setq lsp-metals-treeview-show-when-views-received t))))

(provide 'init-lsp)

;;; init-lsp.el ends here
