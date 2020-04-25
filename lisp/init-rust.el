;; @see https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :ensure t
  :init (setq rust-format-on-save t)
  :hook (rust-mode . (lambda () (setq indent-tabs-mode nil)))
  :config 

  ;; @see https://github.com/kwrooijen/cargo.el
  (use-package cargo
    :ensure t
    :diminish cargo-minor-mode
    :hook (rust-mode . cargo-minor-mode)
    :config (setq compilation-filter-hook 
                  (append compilation-filter-hook '(cargo-process--add-errno-buttons))))

  ;; ;; @see https://github.com/flycheck/flycheck-rust
  ;; (use-package flycheck-rust
  ;;   :ensure t
  ;;   :hook (flycheck-mode . flycheck-rust-setup))

  ;; @see https://github.com/jxs/flymake-rust
  (use-package flymake-rust
    :ensure t
    :hook (rust-mode . flymake-rust-load))
  )

(provide 'init-rust)

;;; init-rust.el ends here
