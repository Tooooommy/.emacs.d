;; C/C++ Mode
(use-package cc-mode
  :ensure nil
  :bind (:map c-mode-base-map
         ("C-c c" . compile))
  :hook (c-mode-common . (lambda () (c-set-style "stroustrup")))
  :init
  (global-flycheck-mode 1)

  (setq-default c-basic-offset 4)
  :config

  (use-package irony
    :ensure t
    :commands
    (irony-install-server irony--find-server-executable)
    :hook
    (((c++-mode c-mode) . irony-mode)
     (irony-mode . irony-cdb-autosetup-compile-options))
    :config
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (use-package company-irony
      :ensure t
      :after irony company
      :config
      (add-to-list 'company-backends 'company-irony))

    (use-package company-c-headers
      :ensure t
      :config
      (add-to-list 'company-backend 'company-c-headers))

    (use-package flycheck-irony
      :ensure t
      :after flycheck
      :hook (flycheck-mode . flycheck-irony-setup))

    (use-package irony-eldoc
      :ensure t
      :hook (irony-mode . irony-eldoc)))

  (use-package rtags
    :ensure t
    :defer t
    :config
    (rtags-enable-standard-keybindings)
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enable t))

  (use-package modern-cpp-font-lock
    :ensure t
    :diminish
    :defer 2
    :hook (after-init . modern-c++-font-lock-global-mode ))

  (use-package google-c-style
    :hook
    ((c-mode c++-mode) . google-set-c-style)
    (c-mode-common . google-make-newline-indent))

  (use-package cmake-mode
    :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

  (use-package cmake-font-lock
    :after (cmake-mode)
    :hook (cmake-mode . cmake-font-lock-activate))

  (use-package cmake-ide
    :after projectile
    :hook (c++-mode . my/cmake-ide-find-project)
    :preface
    (defun my/cmake-ide-find-project ()
      "Finds the directory of the project for cmake-ide."
      (with-eval-after-load 'projectile
        (setq cmake-ide-project-dir (projectile-project-root))
        (setq cmake-ide-build-dir (concat cmake-ide-project-dir "build")))
      (setq cmake-ide-compile-command
            (concat "cd " cmake-ide-build-dir " && cmake .. && make"))
      (cmake-ide-load-db))

    (defun my/switch-to-compilation-window ()
      "Switches to the *compilation* buffer after compilation."
      (other-window 1))
    :bind ([remap comment-region] . cmake-ide-compile)
    :init (cmake-ide-setup)
    :config (advice-add 'cmake-ide-compile :after #'my/switch-to-compilation-window)))

(provide 'init-cpp)

;;; init-cpp.el ends here
