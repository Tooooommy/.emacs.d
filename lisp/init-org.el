;; @see https://orgmode.org
(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :config
  ;; To speed up startup, don't put to init section
  (setq org-agenda-files '("~/Documents/org/agenda")
        org-todo-keywords
        '((sequence "TODO(t)" "DOING(i)" "HANGUP(h)" "|" "DONE(d)" "CANCEL(c)")
          (sequence "#(T)" "@(I)" "❓(H)" "|" "✔(D)" "✘(C)"))
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

  (add-to-list 'org-structure-template-alist '("n" . "note"))

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


  ;; @see https://github.com/integral-dw/org-superstar-mode
  (use-package org-superstar
    :ensure t
    :defer t
    :hook (org-mode . org-superstar-mode)
    :init
    (setq org-superstar-prettify-item-bullets t
          org-superstar-headline-bullets-list '("◉" "✸" "⚫" "○" "•")
          org-superstar-leading-bullet ?\s
          org-hide-leading-stars t
          org-superstar-item-bullet-alist        '((?* . ?●)
                                                   (?+ . ?➤)
                                                   (?- . ?—))))

  (use-package evil-org
    :ensure t
    :defer t
    :after org evil
    :config
    (add-hook 'org-mode-hook 'evil-org-mode)
    (add-hook 'evil-org-mode-hook
              (lambda ()
                (evil-org-set-key-theme)))
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))

  ;; @see https://github.com/louietan/anki-editor
  (use-package anki-editor
    :ensure t
    :defer t
    :hook (org-mode . anki-editor-mode)
    :custom
    (anki-editor-create-decks t))

  ;; @see https://github.com/kaushalmodi/ox-hugo
  (use-package ox-hugo
    :ensure t
    :after ox)

  ;; @see https://github.com/abo-abo/org-download
  (use-package org-download
    :ensure t
    :config
    (setq org-download-image-dir "~/Documents/org/images/"))

  ;; @see https://github.com/alphapapa/org-ql
  (use-package org-ql
    :ensure t
    :defer t)

  ;; @see https://github.com/Kungsgeten/org-brain
  (use-package org-brain
    :ensure t
    :init
    (setq org-brain-path "~/Documents/org/brain/"))

  ;; Rich text clipboard
  ;; @see https://github.com/unhammer/org-rich-yank
  (use-package org-rich-yank
    :ensure t
    :bind (:map org-mode-map
           ("C-M-y" . org-rich-yank)))

  ;; Table of contents
  ;; @see https://github.com/snosov1/toc-org
  (use-package toc-org
    :ensure t
    :hook (org-mode . toc-org-mode))

  ;; @see https://github.com/lujun9972/org-preview-html
  (use-package org-preview-html
    :ensure t
    :diminish))

(provide 'init-org)

;;; init-org.el ends here
