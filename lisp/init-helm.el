;; @see https://github.com/emacs-helm/helm
(use-package helm
  :ensure t
  :diminish helm-mode
  :commands (helm-mode
             helm-mini
             helm-M-x
             helm-command-prefix
             helm-show-kill-ring
             helm-find-files
             helm-register)
  :init
  (helm-mode 1)
  (helm-autoresize-mode t)
  :config
  (require 'helm-config)
  (setq helm-autoresize-max-height 0
        helm-autoresize-min-height 30
        helm-follow-mode-persistent t
        helm-split-window-inside-p t
        helm-scroll-amount 8
        helm-move-to-line-cycle-in-source t
        helm-display-header-line nil
        helm-echo-input-in-header-line t
        helm-input-idle-delay 0.01)

  ;; @see https://github.com/PythonNut/helm-flx
  (use-package helm-flx
    :ensure t
    :if (featurep 'flx)
    :after helm
    :init (helm-flx-mode 1)
    :config (setq helm-flx-for-helm-find-files t
                  helm-flx-for-helm-locate t))

  ;; @see https://github.com/emacsorphanage/helm-swoop
  (use-package helm-swoop
    :ensure t
    :bind
    (:map helm-swoop-map
     ("C-s" . helm-next-line)
     ("C-r" . helm-previous-line)
     :map helm-multi-swoop-map
     ("C-s" . helm-next-line)
     ("C-r" . helm-previous-line))))

(provide 'init-helm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-helm.el ends here
