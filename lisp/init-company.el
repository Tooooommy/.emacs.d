;; @see https://github.com/company-mode/company-mode
(use-package company
  :ensure t
  :diminish company-mode
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :commands company-abort
  :hook (after-init . global-company-mode)
  :bind
  (("M-/" . company-complete)
   ("<backtab>" . company-yasnippet)
   :map company-active-map
   ("C-p" . company-complete-common-or-cycle)
   ("C-n" . company-complete-common-or-cycle)
   ("<tab>" . company-complete-common-or-cycle)
   ("RET" . company-complete-selection)
   ("<backtab>" . my-company-yasnippet)
   ;; ("C-c C-y" . my-company-yasnippet)
   :map company-search-map
   ("C-p" . company-complete-common-or-cycle)
   ("C-n" . company-complete-common-or-cycle))
  :init
  (defun my-company-yasnippet ()
    "Hide the current completions and sho snippets"
    (interactive)
    (company-abort)
    (call-interactively 'company-yasnippet))
  :config
  (setq company-tooltip-align-annotations t
	company-tooltip-limit 12 
	company-idle-delay 0
	company-echo-delay (if (display-graphic-p) nil 0)
	company-minimum-prefix-length 2
	company-require-match nil
	company-dabbrev-ignore-case nil
	company-dabbrev-downcase nil)


  ;; @see https://github.com/raxod502/prescient.el
  (use-package company-prescient
    :ensure t
    :init (company-prescient-mode 1)
    :hook (company-mode . company-prescient-mode))

  ;; @see https://github.com/expez/company-quickhelp
  (use-package company-quickhelp
    :ensure t 
    :defines company-quickhelp-delay
    :bind (:map company-active-map
           ([remap company-show-doc-buffer] . company-quickhelp-manual-begin))
    :hook (global-company-mode . company-quickhelp-mode)
    :init (setq company-quickhelp-delay 0.5))

  ;; @see https://github.com/PythonNut/company-flx
  (use-package company-flx
    :ensure t
    :init (company-flx-mode +1)
    :hook (global-company-mode . company-flx-mode)))

  (provide 'init-company)
;;; init-company.el ends here
