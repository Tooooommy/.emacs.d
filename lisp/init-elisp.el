;; use elisp-mode
(use-package elisp-mode
  :ensure nil
  :mode ("//.el//'" "//.emacs//'")
  :defines (flycheck-disabled-checkers calculate-lisp-indent-last-sexp)
  :functions (helpful-update
              my-lisp-indent-function
              function-advices
              add-button-to-remove-advice
              describe-function-1@advice-remove-button
              end-of-sexp
              helpful-callable@advice-remove-button)
  :bind (:map emacs-lisp-mode-map
         ("C-c C-z" . ielm)
         ("C-c C-e" . toggle-debug-on-error)
         ("C-c C-c" . emacs-lisp-byte-compile)
         ("C-c C-r" . eval-region)
         ("C-c C-f" . eval-defun)
         ("C-c C-b" . eval-buffer))
  :hook (emacs-lisp-mode . (lambda ()
                             "Disable the checkdoc checker."
                             (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc))))
  :config (when (boundp 'elisp-flymake-byte-compile-load-path)
            (add-to-list 'elisp-flymake-byte-compile-load-path load-path))
  
  ;; Syntax highlighting of know elisp symbos
  ;; @see https://github.com/Fanael/highlight-defined
  (use-package highlight-defined
    :ensure t
    :hook (emacs-lisp-mode . highlight-defined-mode))

  ;; Align indent keywords
  ;; @see https://emacs.stackexchange.com/questions/10230/how-to-indent-keywords-aligned
  (defun my-lisp-indent-function (indent-point state)
    "This function is the normal value of the variable `lisp-indent-function'.
The function `calculate-lisp-indent' calls this to determine
if the arguments of a Lisp function call should be indented specially.

INDENT-POINT is the position at which the line being indented begins.
Point is located at the point to indent under (for default indentation);
STATE is the `parse-partial-sexp' state for that position.

If the current line is in a call to a Lisp function that has a non-nil
property `lisp-indent-function' (or the deprecated `lisp-indent-hook'),
it specifies how to indent.  The property value can be:

* `defun', meaning indent `defun'-style
  \(this is also the case if there is no property and the function
  has a name that begins with \"def\", and three or more arguments);

* an integer N, meaning indent the first N arguments specially
  (like ordinary function arguments), and then indent any further
  arguments like a body;

* a function to call that returns the indentation (or nil).
  `lisp-indent-function' calls this function with the same two arguments
  that it itself received.

This function returns either the indentation to use, or nil if the
Lisp function does not specify a special indentation."
    (let ((normal-indent (current-column))
          (orig-point (point)))
      (goto-char (1+ (elt state 1)))
      (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
      (cond
       ;; car of form doesn't seem to be a symbol, or is a keyword
       ((and (elt state 2)
             (or (not (looking-at "\\sw\\|\\s_"))
                 (looking-at ":")))
        (if (not (> (save-excursion (forward-line 1) (point))
                    calculate-lisp-indent-last-sexp))
            (progn (goto-char calculate-lisp-indent-last-sexp)
                   (beginning-of-line)
                   (parse-partial-sexp (point)
                                       calculate-lisp-indent-last-sexp 0 t)))
        ;; Indent under the list or under the first sexp on the same
        ;; line as calculate-lisp-indent-last-sexp.  Note that first
        ;; thing on that line has to be complete sexp since we are
        ;; inside the innermost containing sexp.
        (backward-prefix-chars)
        (current-column))
       ((and (save-excursion
               (goto-char indent-point)
               (skip-syntax-forward " ")
               (not (looking-at ":")))
             (save-excursion
               (goto-char orig-point)
               (looking-at ":")))
        (save-excursion
          (goto-char (+ 2 (elt state 1)))
          (current-column)))
       (t
        (let ((function (buffer-substring (point)
                                          (progn (forward-sexp 1) (point))))
              method)
          (setq method (or (function-get (intern-soft function)
                                         'lisp-indent-function)
                           (get (intern-soft function) 'lisp-indent-hook)))
          (cond ((or (eq method 'defun)
                     (and (null method)
                          (> (length function) 3)
                          (string-match "\\`def" function)))
                 (lisp-indent-defform state indent-point))
                ((integerp method)
                 (lisp-indent-specform method state
                                       indent-point normal-indent))
                (method
                 (funcall method indent-point state))))))))
  ;;  ;; extra ext for emacs-lisp-mode
  ;;  (add-to-list 'auto-mode-alist '("//.emacs//'" . emcas-lisp-mode))
  ;;  (add-to-lisp 'auto-mode-alist '("//*scratch*//'" . emacs-lisp-mode))
  
  ;; hook
  (add-hook 'emacs-lisp-mode-hook
            (lambda () (setq-local lisp-indent-function #'my-lisp-indent-function)))
  ;; Add remove buttons for advices
  (add-hook 'help-mode-hook 'cursor-sensor-mode)

  (defun function-advices (function)
    "Return FUNCTION's advices"
    (let ((function-def (advice--symbol-function function))
          (ad-functions '()))
      (while (advice--p function-def)
        (setq ad-functions (append `(,(advice--car function-def)) ad-functions))
        (setq function-def (advice--cdr function-def)))
      ad-functions))

  (defun add-button-to-remove-advice (buffer-name function)
    "Add a button to remove advice."
    (when (get-buffer buffer-name)
      (with-current-buffer buffer-name
        (save-excursion
          (goto-char (point-min))
          (let ((ad-index 0)
                (ad-list (reverse (function-advices function))))
            (while (re-search-forward "^.+ :[-a-z]+ advice: \\(.+\\)$" nil t)
              (let* ((name (string-trim (match-string 1) "'" "'"))
                     (advice (or (intern-soft name) (nth ad-index ad-list))))
                (when (and advice (functionp advice))
                  (let ((inhibit-read-only t))
                    (insert "\t")
                    (insert-text-button
                     "[Remove]"
                     'cursor-sensor-functions `((lambda (&rest _) (message "%s" ',advice)))
                     'help-echo (format "%s" advice)
                     'action
                     ;; In case lexical-binding is off
                     `(lambda (_)
                        (when (yes-or-no-p (format "Remove %s ? " ',advice))
                          (message "Removing %s of advice from %s" ',function ',advice)
                          (advice-remove ',function ',advice)
                          (if (eq major-mode 'helpful-mode)
                              (helpful-update)
                            (revert-buffer nil t))))
                     'follow-link t))))
              (setq ad-index (1+ ad-index))))))))

  (define-advice describe-function-1 (:after (function) advice-remove-button)
    (add-button-to-remove-advice "*Help*" function))

  ;; Remove hook
  (defun remove-hook-at-point ()
    "Remove the hook at the point in the *Help* buffer."
    (interactive)
    (unless (or (eq major-mode 'help-mode)
                (eq major-mode 'helpful-mode)
                (string= (buffer-name) "*Help*"))
      (error "Only for help-mode or helpful-mode"))
    (let ((orig-point (point)))
      (save-excursion
        (when-let
            ((hook (progn (goto-char (point-min)) (symbol-at-point)))
             (func (when (and
                          (or (re-search-forward (format "^Value:?[\s|\n]") nil t)
                              (goto-char orig-point))
                          (sexp-at-point))
                     (end-of-sexp)
                     (backward-char 1)
                     (catch 'break
                       (while t
                         (condition-case _err
                             (backward-sexp)
                           (scan-error (throw 'break nil)))
                         (let ((bounds (bounds-of-thing-at-point 'sexp)))
                           (when (< (car bounds) orig-point (cdr bounds))
                             (throw 'break (sexp-at-point)))))))))
          (when (yes-or-no-p (format "Remove %s from %s? " func hook))
            (remove-hook hook func)
            (if (eq major-mode 'helpful-mode)
                (helpful-update)
              (revert-buffer nil t)))))))
  (bind-key "r" #'remove-hook-at-point help-mode-map))

;; @see https://github.com/joddie/macrostep
(use-package macrostep
  :ensure t
  :after elisp-mode
  :custom-face (macrostep-expansion-highlight-face ((t (:background ,(face-background 'tooltip)))))
  :bind (:map emacs-lisp-mode-map
         ("C-c C-m" . macrostep-expand)
         :map lisp-interaction-mode-map
         ("C-c C-m" . macrostep-expand))
  :config (add-hook 'after-load-theme-hook (lambda ()
                                             (set-face-background 'macrostep-expansion-highlight-face
                                                                  (face-background 'tooltip)))))
;; @see https://github.com/purcell/elisp-slime-nav
(use-package elisp-slime-nav
  :ensure t 
  :after elisp-mode
  :diminish
  :commands (elisp-slime-nav-mode elisp-slime-nav-find-elisp-thing-at-point))

;; @see https://github.com/Wilfred/helpful
(use-package helpful
  :ensure t
  :bind (([remap describe-variable] . helpful-variable)
         ([remap describe-function] . helpful-callable)
         ([remap describe-key] . helpful-key)
         :map emacs-lisp-mode-map
         ("C-c C-d" . helpers/helpful-at-point-dwim))

  :init
  (setq helpful-max-buffers 10))

;; @see https://github.com/Wilfred/elisp-refs
(use-package elisp-refs
  :ensure t)

;; @see eldoc
(use-package eldoc
  :ensure t
  :diminish)

(provide 'init-elisp)

;;; init-elisp ends here