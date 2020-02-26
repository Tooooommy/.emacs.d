;; @see https://github.com/Triagle/emacs/blob/4e60068814735b38055c79d3bad7cb06f9e4322b/configuration.org
;; init.el
(let ((minver "26"))
  (when (version< emacs-version minver)
    (error "Emacs v%s or higher is required." minver)))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "github" user-emacs-directory))

;; some config
(setq make-backup-files nil)
(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)


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

;; (require 'benchmark-init-modes)
;; (require 'benchmark-init)
;; (benchmark-init/activate)


(require 'init-elpa)
(require 'init-helpers)
(require 'init-calendar)
(require 'init-evil)
(require 'init-config)
(require 'init-gui)
;; (require 'init-modeline)
(require 'init-edit)
(require 'init-treemacs)
(require 'init-helm)
(require 'init-projectile)
(require 'init-restclient)

;; text
(require 'init-markdown)
(require 'init-org)

;; prog
(require 'init-git)
(require 'init-lsp)
(require 'init-docker)
(require 'init-flycheck)
(require 'init-company)
(require 'init-yasnippet)
(require 'init-elisp)
(require 'init-go)
(require 'init-rust)

(provide 'init)

;;; init.el ends here
