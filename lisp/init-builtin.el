;; ido
(use-package ido
  :init (ido-mode 1))

;; ibuffer
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

;; winner
(use-package winner
  :hook (after-init . winner-mode))

;; ediff
(use-package ediff
  :hook (ediff-quit . winner-undo))

;; saveplace
(use-package save-place
  :hook (after-init . save-place-mode))

;; hl-line // 高亮当前行
(use-package hl-line
  :hook(after-init . global-hl-line-mode))

;; hideshow
(use-package hideshow
  :diminish hs-minor-mode
  :bind
  (:map prog-mode-map
   ("M--" . hs-toggle-hiding)
   ("M-+" . hs-show-all))
  :hook (prog-mode . hs-minor-mode)
  :custom
  (hs-special-modes-alist
   (mapcar 'purecopy
           '((c-mode "{" "}" "/[*/]" nil nil)
             (c++-mode "{" "}" "/[*/]" nil nil)
             (rust-mode "{" "}" "/[*/]" nil nil)
             (go-mode "{" "}" "/[*/]" nil nil)))))

;; whitespace
;; (use-package whitespace
;;   :hook ((prog-mode markdown-mode conf-mode) . whitespace-mode)
;;   :config (setq whitespace-style '(face trailling)))

;; so-long
;; (use-package so-long
;;   :config (global-so-long-mode 1))

;; subword
(use-package subword
  :ensure nil
  :hook (after-init . global-subword-mode))

;; ;; delsel
;; (use-package delsel
;;   :ensure nil
;;   :hook (after-init . delete-selection-mode))

;; paren
(use-package paren
  :hook (after-init . show-paren-mode)
  :config
  (setq show-paren-when-point-inside-paren t
        show-paren-when-point-in-periphery t))

;; simple
(use-package simple
  :hook (after-init . (lambda()
                        (line-number-mode)
                        (column-number-mode)
                        (size-indication-mode))))

;; autorevert
(use-package autorevert
  :hook (after-init . global-auto-revert-mode))

;; isearch
;; 注：isearch-lazy-count和lazy-count-prefix-format需要Emacs 27+
(use-package isearch
  :bind
  (:map isearch-mode-map
   ([remap isearch-delete-char] . isearch-del-char))

  :custom
  ;; (isearch-lazy-count t)
  ;; (lazy-count-prefix-format "%s/%s ")
  (lazy-highlight-cleanup nil))

;; recentf
(use-package recentf
  :hook (after-init . recentf-mode)
  :bind
  ("C-x C-r" . recentf-open-files)
  :config
  (run-at-time nil (* 5 60) 'recentf-save-list)
  (setq recentf-max-menu-items 25)
  (setq recentf-max-saved-items 25))


(provide 'init-builtin)
;;; init-builtin.el nends here
