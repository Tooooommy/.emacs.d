;; @see https://github.com/hlissner/emacs-doom-themes
;; 主题颜色
(use-package doom-themes
  :ensure t
  :init (load-theme 'doom-gruvbox t)
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

(provide 'init-theme)
;;; init-gui.el ends here
