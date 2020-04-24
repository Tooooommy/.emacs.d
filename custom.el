(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hs-special-modes-alist
   (quote
    ((c-mode "{" "}" "/[*/]" nil nil)
     (c++-mode "{" "}" "/[*/]" nil nil)
     (rust-mode "{" "}" "/[*/]" nil nil)
     (go-mode "{" "}" "/[*/]" nil nil))) t)
 '(lazy-highlight-cleanup nil)
 '(package-selected-packages
   (quote
    (git-messenger git-timemachine magit-gitflow magit-todos forge helm-ls-git evil-magit treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil evil-mc evil-escape evil-nerd-commenter evil-surround yasnippet-snippets yaml-mode which-key use-package treemacs toc-org super-save sql-indent smex smartparens rust-playground rg restclient rainbow-delimiters quickrun ox-gfm org-tree-slide org-rich-yank org-preview-html org-pomodoro org-mime org-fancy-priorities org-bullets ob-rust ob-ipython ob-go nlinum-relative modern-cpp-font-lock markdown-toc magit macrostep lua-mode json-mode ibuffer-projectile highlight-defined helpful google-c-style go-playground general flycheck-rust flycheck-posframe flycheck-pos-tip fancy-battery exec-path-from-shell evil elnode elisp-slime-nav eglot editorconfig dumb-jump doom-themes doom-modeline dockerfile-mode diff-hl company-quickhelp company-prescient company-flx cmake-ide cmake-font-lock cargo cal-china-x better-defaults auto-package-update aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-timemachine-minibuffer-author-face ((t (:inherit success))))
 '(git-timemachine-minibuffer-detail-face ((t (:inherit warning))))
 '(macrostep-expansion-highlight-face ((t (:background "#23272e"))))
 '(org-pomodoro-mode-line ((t (:inherit warning))))
 '(org-pomodoro-mode-line-break ((t (:inherit success))))
 '(org-pomodoro-mode-line-overtime ((t (:inherit error)))))
