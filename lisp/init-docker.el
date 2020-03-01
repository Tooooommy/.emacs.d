;; @see https://github.com/Silex/docker.el
(use-package docker
  :ensure t
  :defines docker-image-run-arguments
  :bind ("C-c d" . docker)
  :init (setq docker-image-run-arguments '("-i" "-t" "--rm")
              docker-container-shell-file-name "/bin/bash"))

;; @see https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode)
  :config (setq dockerfile-mode-command "docker"))

;; @see https://github.com/emacs-pe/docker-tramp.el
(use-package docker-tramp)

(provide 'init-docker)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-docker.el ends here
