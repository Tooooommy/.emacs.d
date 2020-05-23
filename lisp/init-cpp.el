;; C/C++ Mode
(use-package cc-mode
  :ensure nil
  :defer 3
  :bind (:map c-mode-base-map
         ("C-c c" . compile))
  :init
  (setq-default c-default-style "linux")
  (setq-default c-basic-offset 4)
  :config
  (use-package company-ctags
    :ensure t
    :defer 3
    :after company
    :config
    (setq company-ctags-extra-tags-files '("$HOME/TAGS" "/usr/include/TAGS"))
    (company-ctags-auto-setup)
    )

  (use-package modern-cpp-font-lock
    :ensure t
    :defer 3
    :diminish
    :hook (after-init . modern-c++-font-lock-global-mode ))

  (use-package google-c-style
    :hook (c-mode-common . (lambda ()
                             (google-set-c-style)
                             (google-make-newline-indent))))

  (use-package cmake-mode
    :defer 3
    :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

  (use-package cmake-font-lock
    :defer 3
    :after (cmake-mode)
    :hook (cmake-mode . cmake-font-lock-activate)))

(provide 'init-cpp)

;;; init-cpp.el ends here
