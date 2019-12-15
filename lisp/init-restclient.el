;; @see https://github.com/pashky/restclient.el
(use-package restclient
  :ensure t
  :mode ("//.http//'" . restclient-mode)
  :config
  ;; @see https://github.com/iquiw/company-restclient
  (use-package company-restclient
    :ensure t
    :ensure t
    :config (add-to-list 'company-backends 'company-restclient)))

;; @see https://github.com/joshwnj/json-mode
(use-package json
  :ensure t)


;; @see https://github.com/nicferrier/elnode
(use-package elnode
  :ensure t)

(provide 'init-restclient)
