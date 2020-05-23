;; @see https://github.com/Triagle/emacs/blob/4e60068814735b38055c79d3bad7cb06f9e4322b/configuration.org
;; init.el
(let ((minver "26"))
  (when (version< emacs-version minver)
    (error "Emacs %s or higher is required." minver)))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

;; adjust garbage collection thresholds during startup, and thereafter
(setq file-name-handler-alist nil)
(defvar normal-gc-cons-threshold (* 20 1024 1024))
(defvar init-gc-cons-threshold (* 128 1024 1024))
(setq gc-cons-threshold init-gc-cons-threshold)
(add-hook 'emacs-startup-hook
         (lambda () (setq gc-cons-threshold normal-gc-cons-threshold)))

;; bootstrap config
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(setq *mac* (eq system-type 'darwin))
(setq *win64* (eq system-type 'winows-nt))
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)))

(require 'init-elpa)
(require 'init-helpers)

(require 'init-builtin)
(require 'init-evil)
(require 'init-helm)
(require 'init-keymap)
(require 'init-git)
(require 'init-theme)
(require 'init-modeline)
(require 'init-treemacs)
(require 'init-projectile)
;; (require 'init-eglot)
(require 'init-eldoc)
(require 'init-lsp)
(require 'init-flycheck)
(require 'init-prog)
(require 'init-docker)
(require 'init-mt)
(require 'init-sql)
(require 'init-lua)
(require 'init-markdown)
(require 'init-cpp)
(require 'init-org)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-elisp)
(require 'init-go)
(require 'init-rust)

(provide 'init)

;;; init.el ends here
