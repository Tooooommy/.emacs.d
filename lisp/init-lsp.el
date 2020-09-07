;; @see https://github.com/emacs-lsp/lsp-mode
(use-package lsp-mode
  :ensure t
  :defer 3
  :defines (lsp-clients-python-library-directories lsp-rust-rls-server-command)
  :commands (lsp-enable-which-key-integration lsp-format-buffer lsp-organize-imports)
  :diminish
  :hook ((prog-mode . (lambda ()
                        (unless (derived-mode-p 'emacs-lisp-mode 'lisp-mode)
                          (lsp-deferred))))
         (lsp-mode . (lambda ()
                       ;; Integrate `which-key'
                       (lsp-enable-which-key-integration)
                       ;; Format and organize imports
                       (unless (add-hook 'before-save-hook #'lsp-format-buffer t t)
                         (add-hook 'before-save-hook #'lsp-organize-imports t t)))))
  :bind (:map lsp-mode-map
         ([remap xref-find-definitions] . lsp-find-definition)
         ([remap xref-find-references] . lsp-find-references))
  :init
  (setq lsp-keymap-prefix "C-c l"
        lsp-auto-guess-root t
        lsp-flycheck-live-reporting nil
        lsp-keep-workspace-alive nil
        lsp-prefer-capf t
        lsp-signature-auto-activate nil

        lsp-enable-file-watchers nil
        lsp-enable-folding nil
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-enable-symbol-highlighting nil)
  ;; For `lsp-clients'
  (setq lsp-clients-python-library-directories '("/usr/local/" "/usr/"))
  (unless (executable-find "rls")
    (setq lsp-rust-rls-server-command '("rustup" "run" "stable" "rls")))
  :config
  (with-no-warnings
    (defun my-lsp--init-if-visible (func &rest args)
      "Not enabling lsp in `git-timemachine-mode'."
      (unless (bound-and-true-p git-timemachine-mode)
        (apply func args)))
    (advice-add #'lsp--init-if-visible :around #'my-lsp--init-if-visible))

  (use-package lsp-ui
    :ensure t
    :defer 3
    :custom-face
    (lsp-ui-sideline-code-action ((t (:inherit warning))))
    :hook (lsp-mode . lsp-ui-mode)
    :init (setq lsp-ui-doc-enable t
                lsp-ui-doc-use-webkit nil
                lsp-ui-doc-delay 0.2
                lsp-ui-doc-include-signature t
                lsp-ui-doc-position 'at-point
                lsp-ui-doc-border (face-foreground 'default)
                lsp-eldoc-enable-hover nil ; Disable eldoc displays in minibuffer

                lsp-ui-sideline-enable t
                lsp-ui-sideline-show-hover nil
                lsp-ui-sideline-show-diagnostics nil
                lsp-ui-sideline-show-code-actions t
                lsp-ui-sideline-ignore-duplicate t

                lsp-ui-imenu-enable t
                lsp-ui-imenu-colors `(,(face-foreground 'font-lock-keyword-face)
                                      ,(face-foreground 'font-lock-string-face)
                                      ,(face-foreground 'font-lock-constant-face)
                                      ,(face-foreground 'font-lock-variable-name-face)))
    :config
    (add-to-list 'lsp-ui-doc-frame-parameters '(right-fringe . 8))

    ;; `C-g'to close doc
    (advice-add #'keyboard-quit :before #'lsp-ui-doc-hide)

    ;; Reset `lsp-ui-doc-background' after loading theme
    (add-hook 'after-load-theme-hook
              (lambda ()
                (setq lsp-ui-doc-border (face-foreground 'default))
                (set-face-background 'lsp-ui-doc-background
                                     (face-background 'tooltip)))))

  ;; Microsoft python-language-server support
  (use-package lsp-python-ms
    :ensure t
    :defer 3
    :hook (python-mode . (lambda () (require 'lsp-python-ms)))
    :init
    (when (executable-find "python3")
      (setq lsp-python-ms-python-executable-cmd "python3")))

  ;; ;; C/C++/Objective-C support
  ;; (use-package ccls
  ;;   :ensure t
  ;;   :defer 3
  ;;   :defines projectile-project-root-files-top-down-recurring
  ;;   :hook ((c-mode c++-mode objc-mode cuda-mode) . (lambda () (require 'ccls)))
  ;;   :config
  ;;   (with-eval-after-load 'projectile
  ;;     (setq projectile-project-root-files-top-down-recurring
  ;;           (append '("compile_commands.json" ".ccls")
  ;;                   projectile-project-root-files-top-down-recurring))))

  ;; @see https://github.com/emacs-lsp/helm-lsp/
  (use-package helm-lsp
    :ensure t
    :defer 3
    :after helm
    :bind
    (:map lsp-mode-map
     ([remap xref-find-apropos] . helm-lsp-workspace-symbol)))

  ;; @see https://github.com/emacs-lsp/lsp-treemacs
  (use-package lsp-treemacs
    :ensure t
    :defer 3
    :after treemacs
    :init (lsp-treemacs-sync-mode 1))

  )

(provide 'init-lsp)
;;; init-lsp.el
