;; @see https://github.com/hlissner/emacs-doom-themes
;; 主题颜色
(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-one t)
  :config
  (setq  
   doom-themes-enable-bold t
   doom-themes-enable-italic t)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; @see https://github.com/seagle0128/doom-modeline
;; 状态条
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-icon t
        doom-modeline-irc t
        doom-modeline-mu4e t
        doom-modeline-project-detection 'project
        doom-modeline-lsp t
        doom-modeline-major-mode-icon nil
        doom-modeline-minor-modes (featurep 'minions)
        doom-modeline-height 25
        doom-modeline-bar-width 3
        doom-modeline-buffer-encoding t
        doom-modeline-indent-info nil
        doom-modeline-env-version t))

(provide 'init-gui)
;;; init-gui.el ends here
