;; @see http://www.dr-qubit.org/git/undo-tree.git
;; @see https://github.com/emacsmirror/undo-tree
(use-package undo-tree
  :load-path "~/.emacs.d/github/undo-tree-20170706.246"
  :diminish
  :config
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist `(("." . "~/.emacs.d/undotree")))
  (setq delete-old-versions t
	backup-directory-alist `(("." . "~/.emacs.d/saves"))
	backup-by-copying t
	kept-new-versions 6
	kept-old-versions 2
	version-control t))

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
  (setq helm-candidate-number-limit 100)
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

;; @see https://github.com/Wilfred/ag.el
(use-package ag
  :ensure t
  :ensure t
  :config
  (setq ag-highlight-search t)
  ;; @see https://github.com/syohex/emacs-helm-ag
  (use-package helm-ag
    :ensure t))

;; @see https://github.com/BurntSushi/ripgrep
;; @see https://github.com/Wilfred/deadgrep

(provide 'init-helm)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-helm.el ends here
