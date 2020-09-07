;; 初始化画面	
(defun scratch-buffer-message ()
  (interactive)
  (concat ";; Happy hacking "	
          (or user-login-name "")	
          " - Emacs love you!\n\n"))

(setq-default initial-scratch-message (scratch-buffer-message))
(setq initial-major-mode 'fundamental-mode)

;; 显示设置
(cd "~/")                                         ; 切换到主目录
(display-time-mode 1)                             ; 在modeline 加上时间
(fset 'yes-or-no-p 'y-or-n-p)                     ; 改变询问字符

;; 系统编码
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;; Suppress GUI features
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

;; 字体设置
(set-face-attribute 'default  nil :font "Source Code Pro Medium 12")

;; 编辑器标题
(setq frame-title-format '("Tooooommy Emacs - %b")
      icon-title-format frame-title-format)

;; 初始化调整窗口
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; 显示窗口
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(add-hook 'window-setup-hook #'window-divider-mode)

;; 删除某些buffer
(defvar *protected-buffers* '("*scratch*" "*Messages*")
  "Buffers that cannot be killed.")

(defun my/protected-buffers ()
  "Protects some buffers from being killed."
  (dolist (buffer *protected-buffers*)
    (with-current-buffer buffer
      (emacs-lock-mode 'kill))))

(add-hook 'after-init-hook #'my/protected-buffers)

;; vc 
(auto-revert-mode 1)

;; tab
(setq-default indent-tabs-mode nil)

;; winner
(use-package winner
  :ensure nil
  :defer t
  :hook (after-init . winner-mode))

;; ediff
(use-package ediff
  :ensure nil
  :defer t
  :hook (ediff-quit . winner-undo))

;; hl-line // 高亮当前行
(use-package hl-line
  :ensure nil
  :defer t
  :hook(after-init . global-hl-line-mode))

;; so-long
(when (not (version< emacs-version "27"))
  (use-package so-long
    :ensure nil
    :defer t
    :hook (after-init .global-so-long-mode)))

;; eldoc
(use-package eldoc
  :ensure nil
  :defer t
  :diminish)

;; subword
;; (use-package subword
;;   :ensure nil
;;   :hook (after-init . global-subword-mode))

;; windmove
(use-package windmove
  :ensure nil
  :defer t)

;; @see https://github.com/technomancy/better-defaults
;; 默认设置
(use-package better-defaults
  :ensure t)

(provide 'init-builtin)
;;; init-builtin.el nends here
