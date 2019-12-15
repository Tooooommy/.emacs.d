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
  :bind  (:map helm-map
          ("<tab>" . helm-execute-persistent-action)
          ("C-i" . helm-execute-persistent-action)
          ("C-z" . helm-select-action))
  :init (helm-mode 1)
  (setq helm-M-x-fuzzy-match t
        helm-ff-fuzzy-matching t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-split-window-in-side-p nil)
  :config
  (require 'helm-config)
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

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

;;; init-helm.el ends here
