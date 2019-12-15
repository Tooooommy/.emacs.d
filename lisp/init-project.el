;; @see https://github.com/bbatsov/projectile
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

;; @see https://github.com/bbatsov/helm-projectile
;; (use-package helm-projectile
;;   :ensure t
;;   :config (helm-projectile-on))

;; @see https://github.com/IvanMalison/org-projectile


;; @see https://github.com/technomancy/find-file-in-project

(provide 'init-project)
