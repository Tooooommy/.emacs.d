;; @see https://github.com/fgallina/python.el
(use-package python
  :ensure t 
  :hook (inferior-python-mode . (lambda ()
                                  (process-query-on-exit-flag
                                   (get-process "Python"))))
  :init (setq python-shell-completion-native-enable nil)
  :config (when (and (executable-find "python3")
                     (string= python-shell-interpreter "python"))
            (setq python-shell-interpreter "python3"))

  ;; @see https://github.com/JorisE/yapfify
  (use-package yapfify
    :ensure t
    :diminish yapf-mode
    :hook (python-mode . yapf-mode)))

;; @see https://github.com/akaihola/flymake-python
;; @see https://github.com/fgallina/python-django.el

;; @see https://github.com/jorgenschaefer/pyvenv
;; @see https://github.com/porterjamesj/virtualenvwrapper.el
;; @see https://github.com/tkf/emacs-python-environment
;; @see https://github.com/pwalsh/pipenv.el
(use-package pipenv
  :ensure t
  :hook (python-mode . pipenv-mode)
  :init
  (setq pipenv-projectile-after-switch-function #'pipenv-projectile-after-switch-extended))
 
(provide 'init-python)

;;; init-python.el ends here
