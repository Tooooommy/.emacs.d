;; lua
(use-package lua-mode
  :delight "Λ "
  :mode "\\.lua\\'"
  :interpreter ("lua" . lua-mode)
  :config
  ;; @seee https://github.com/ptrv/company-lua
  (use-package company-lua
    :ensure t
    :config
    (defun my-lua-mode-company-init ()
      (setq-local company-backends '((company-lua
                                      company-etags
                                      company-dabbrev-code
                                      company-yasnippet))))
    (add-hook 'lua-mode-hook #'my-lua-mode-company-init)))

(provide 'init-lua)
;;; init-lua.el
