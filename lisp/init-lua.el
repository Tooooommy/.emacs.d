;; lua
(use-package lua-mode
  :defer 3
  :delight "Λ "
  :mode "\\.lua\\'"
  :interpreter ("lua" . lua-mode))

;; @seee https://github.com/ptrv/company-lua
(use-package company-lua
  :ensure t
  :defer 3
  :config
  (defun my-lua-mode-company-init ()
    (setq-local company-backends '((company-lua
                                    company-etags
                                    company-dabbrev-code
                                    company-yasnippet))))
  (add-hook 'lua-mode-hook #'my-lua-mode-company-init))

(provide 'init-lua)
;;; init-lua.el
