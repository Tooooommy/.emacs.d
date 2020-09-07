;; C/C++ Mode
(use-package cc-mode
  :ensure nil
  :bind (:map c-mode-base-map
         ("C-c c" . compile))
  :hook (c-mode-common . (lambda () (c-set-style "stroustrup")))
  :init (setq-default c-basic-offset 4))

(use-package modern-cpp-font-lock
  :diminish
  :init (modern-c++-font-lock-global-mode t))

;; cmake-ide
(use-package cmake-ide
  :ensure t
  :init (cmake-ide-setup))

(provide 'init-cpp)

;;; init-cpp.el ends here
