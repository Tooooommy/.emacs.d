;; @see https://github.com/TommyX12/company-tabnine
(use-package company-tabnine
  :ensure t
  :config (add-to-list 'company-backends #'company-tabnine))

(provide 'init-tabnine)
