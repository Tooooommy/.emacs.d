;; @see https://orgmode.org
;; @see https://github.com/kaushalmodi/ox-hugo
;; @see https://github.com/larstvei/Focus

;; @from centuar emacs
;; (use-package org
;;   :ensure t)

;; @see https://github.com/kaushalmodi/ox-hugo
;; (use-package ox-hugo
;;  :ensure t)

;; @see https://github.com/larstvei/Focus
;; (use-package focus
;;  :ensure t)

(use-package org
  :ensure t
  :custom-face (org-ellipsis ((t (:foreground nil))))
  :preface
  (defun hot-expand (str &optional mod)
    "Expand org template.
STR is a structure template string recognised by org like <s. MOD is a
string with additional parameters to add the begin line of the
structure element. HEADER string includes more parameters that are
prepended to the element after the #+HEADER: tag."
    (let (text)
      (when (region-active-p)
        (setq text (buffer-substring (region-beginning) (region-end)))
        (delete-region (region-beginning) (region-end)))
      (insert str)
      (if (fboundp 'org-try-structure-completion)
          (org-try-structure-completion) ; < org 9
        (progn
          ;; New template expansion since org 9
          (require 'org-tempo nil t)
          (org-tempo-complete-tag)))
      (when mod (insert mod) (forward-line))
      (when text (insert text))))
  ;; :pretty-hydra
  ;; ((:title (pretty-hydra-title "Org Template" 'fileicon "org")
  ;;   :color blue :quit-key "q")
  ;;  ("Basic"
  ;;   (("a" (hot-expand "<a") "ascii")
  ;;    ("c" (hot-expand "<c") "center")
  ;;    ("C" (hot-expand "<C") "comment")
  ;;    ("e" (hot-expand "<e") "example")
  ;;    ("E" (hot-expand "<E") "export")
  ;;    ("h" (hot-expand "<h") "html")
  ;;    ("l" (hot-expand "<l") "latex")
  ;;    ("n" (hot-expand "<n") "note")
  ;;    ("o" (hot-expand "<q") "quote")
  ;;    ("v" (hot-expand "<v") "verse"))
  ;;   "Head"
  ;;   (("i" (hot-expand "<i") "index")
  ;;    ("A" (hot-expand "<A") "ASCII")
  ;;    ("I" (hot-expand "<I") "INCLUDE")
  ;;    ("H" (hot-expand "<H") "HTML")
  ;;    ("L" (hot-expand "<L") "LaTeX"))
  ;;   "Source"
  ;;   (("s" (hot-expand "<s") "src")
  ;;    ("m" (hot-expand "<s" "emacs-lisp") "emacs-lisp")
  ;;    ("y" (hot-expand "<s" "python :results output") "python")
  ;;    ("p" (hot-expand "<s" "perl") "perl")
  ;;    ("r" (hot-expand "<s" "ruby") "ruby")
  ;;    ("S" (hot-expand "<s" "sh") "sh")
  ;;    ("g" (hot-expand "<s" "go :imports '\(\"fmt\"\)") "golang"))
  ;;   "Misc"
  ;;   (("u" (hot-expand "<s" "plantuml :file CHANGE.png") "plantuml")
  ;;    ("Y" (hot-expand "<s" "ipython :session :exports both :results raw drawer\n$0") "ipython")
  ;;    ("P" (progn
  ;;           (insert "#+HEADERS: :results output :exports both :shebang \"#!/usr/bin/env perl\"\n")
  ;;           (hot-expand "<s" "perl")) "Perl tangled")
  ;;    ("<" self-insert-command "ins"))))
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb)
         :map org-mode-map
         ("<" . (lambda ()
                  "Insert org template."
                  (interactive)
                  (if (or (region-active-p) (looking-back "^\s*" 1))
                      (org-hydra/body)
                    (self-insert-command 1)))))
  :hook ((org-mode . (lambda ()
                       "Beautify org symbols."
                       (setq prettify-symbols-alist
                             (append centaur-prettify-org-symbols-alist
                                     prettify-symbols-alist))
                       (prettify-symbols-mode 1)))
         (org-indent-mode . (lambda()
                              (diminish 'org-indent-mode)
                              ;; WORKAROUND: Prevent text moving around while using brackets
                              ;; @see https://github.com/seagle0128/.emacs.d/issues/88
                              (make-variable-buffer-local 'show-paren-mode)
                              (setq show-paren-mode nil))))
  :config
  ;; To speed up startup, don't put to init section
  (setq org-agenda-files '("~/org")
        org-todo-keywords
        '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")
          (sequence "⚑(T)" "🏴(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
        org-todo-keyword-faces '(("HANGUP" . warning)
                                 ("❓" . warning))
        org-priority-faces '((?A . error)
                             (?B . warning)
                             (?C . success))
        org-tags-column -80
        org-log-done 'time
        org-catch-invisible-edits 'smart
        org-startup-indented t
        org-ellipsis (if (char-displayable-p ?) "  " nil)
        org-pretty-entities nil
        org-hide-emphasis-markers t)

  ;; Add new template
  (add-to-list 'org-structure-template-alist '("n" . "note"))

  ;; Use embedded webkit browser if possible
  (when (featurep 'xwidget-internal)
    (push '("\\.\\(x?html?\\|pdf\\)\\'"
            .
            (lambda (file _link)
              (xwidget-webkit-browse-url (concat "file://" file))
              (let ((buf (xwidget-buffer (xwidget-webkit-current-session))))
                (when (buffer-live-p buf)
                  (and (eq buf (current-buffer)) (quit-window))
                  (pop-to-buffer buf)))))
          org-file-apps))

  ;; Add gfm/md backends
  (use-package ox-gfm :ensure t)
  (add-to-list 'org-export-backends 'md)

  (with-eval-after-load 'counsel
    (bind-key [remap org-set-tags-command] #'counsel-org-tag org-mode-map))

  ;; Prettify UI
  (use-package org-bullets
    :ensure t
    :if (char-displayable-p ?⚫)
    :hook (org-mode . org-bullets-mode)
    :init (setq org-bullets-bullet-list '("⚫" "⚫" "⚫" "⚫")))

  (use-package org-fancy-priorities
    :ensure t
    :diminish
    :hook (org-mode . org-fancy-priorities-mode)
    :init (setq org-fancy-priorities-list
                (if (char-displayable-p ?⯀)
                    '("⯀" "⯀" "⯀" "⯀")
                  '("HIGH" "MEDIUM" "LOW" "OPTIONAL"))))

  ;; Babel
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t)

  (defvar load-language-list '((emacs-lisp . t)
                               (perl . t)
                               (python . t)
                               (ruby . t)
                               (js . t)
                               (css . t)
                               (sass . t)
                               (C . t)
                               (java . t)
                               (plantuml . t)))

  (use-package ob-go
    :ensure t
    :init (cl-pushnew '(go . t) load-language-list))

  (use-package ob-rust
    :ensure t
    :init (cl-pushnew '(rust . t) load-language-list))

  (use-package ob-ipython
    :ensure t
    :if (executable-find "jupyter")     ; DO NOT remove
    :init (cl-pushnew '(ipython . t) load-language-list))

  (org-babel-do-load-languages 'org-babel-load-languages
                               load-language-list)

  ;; Rich text clipboard
  (use-package org-rich-yank
    :ensure t
    :bind (:map org-mode-map
           ("C-M-y" . org-rich-yank)))

  ;; Table of contents
  (use-package toc-org
    :ensure t
    :hook (org-mode . toc-org-mode))

  ;; Export text/html MIME emails
  (use-package org-mime
    :ensure t
    :bind (:map message-mode-map
           ("C-c M-o" . org-mime-htmlize)
           :map org-mode-map
           ("C-c M-o" . org-mime-org-buffer-htmlize)))

  ;; Preview
  (use-package org-preview-html
    :ensure t
    :diminish)

  ;; Presentation
  (use-package org-tree-slide
    :ensure t
    :diminish
    :functions (org-display-inline-images
                org-remove-inline-images)
    :bind (:map org-mode-map
           ("C-<f7>" . org-tree-slide-mode)
           :map org-tree-slide-mode-map
           ("<left>" . org-tree-slide-move-previous-tree)
           ("<right>" . org-tree-slide-move-next-tree)
           ("S-SPC" . org-tree-slide-move-previous-tree)
           ("SPC" . org-tree-slide-move-next-tree))
    :hook ((org-tree-slide-play . (lambda ()
                                    (text-scale-increase 4)
                                    (org-display-inline-images)
                                    (read-only-mode 1)))
           (org-tree-slide-stop . (lambda ()
                                    (text-scale-increase 0)
                                    (org-remove-inline-images)
                                    (read-only-mode -1))))
    :config
    (org-tree-slide-simple-profile)
    (setq org-tree-slide-skip-outline-level 2))

  ;; Pomodoro
  (use-package org-pomodoro
    :ensure t
    :custom-face
    (org-pomodoro-mode-line ((t (:inherit warning))))
    (org-pomodoro-mode-line-overtime ((t (:inherit error))))
    (org-pomodoro-mode-line-break ((t (:inherit success))))
    :bind (:map org-agenda-mode-map
           ("P" . org-pomodoro))))

(provide 'init-org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; init-org.el ends here
