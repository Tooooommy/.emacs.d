;; @see https://orgmode.org
(use-package org
  :ensure t
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-switchb))
  :config
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

  ;; Add gfm/md backends
  (use-package ox-gfm
    :ensure t
    :config
    (add-to-list 'org-export-backends 'md))

  ;; @see https://github.com/integral-dw/org-superstar-mode
  (use-package org-superstar
    :ensure t
    :hook (org-mode . org-superstar-mode))

  ;; @see https://github.com/louietan/anki-editor
  (use-package anki-editor
    :ensure t)

  ;; @see https://github.com/kaushalmodi/ox-hugo
  (use-package ox-hugo
    :ensure t)

  ;; @see https://github.com/abo-abo/org-download
  (use-package org-download
    :ensure t)
  ;; @see https://github.com/alphapapa/org-ql
  (use-package org-ql
    :ensure t)

  ;; @see https://github.com/alphapapa/org-super-agenda
  (use-package org-super-agenda
    :ensure t)

  ;; @see https://github.com/Kungsgeten/org-brain
  (use-package org-brain
    :ensure t)

  ;; @see https://github.com/rexim/org-cliplink
  (use-package org-cliplink
    :ensure t)

  ;; @see https://github.com/weirdNox/org-noter
  (use-package org-noter
    :ensure t)

  ;; @see https://github.com/jethrokuan/org-roam

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

  ;; Preview
  ;; @see https://github.com/lujun9972/org-preview-html
  (use-package org-preview-html
    :ensure t
    :diminish))

(provide 'init-org)

;;; init-org.el ends here
