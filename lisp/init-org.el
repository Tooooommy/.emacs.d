;; @see https://orgmode.org
(use-package org
  :ensure t
  :defer 3
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c b" . org-switchb)
         ("C-c w" . org-refile))
  :config
  ;; To speed up startup, don't put to init section
  (setq org-agenda-files '("~/Documents/org/agenda")
        org-todo-keywords
        '((sequence "TODO" "DOING" "DELAY" "|" "DONE" "CANCEL"))
        org-todo-keyword-faces
        '(("TODO" . (:foreground "#FF4500" :weight bold))
          ("DOING" . (:foreground "#33cc33" :weight bold))
          ("DELAY" . (:foreground "black" :weight bold))
          ("DONE" . (:foreground "#27AE60" :weight bold))
          )
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

  (setq org-capture-templates
        '(("i" "inbox" entry (file+headline "~/Documents/org/agenda/inbox.org" "inbox")
           "* TODO [#B] %U %i%?" :empty-lines 1)
          ("s" "someday" entry (file+headline "~/Documents/org/agenda/someday.org" "some day")
           "* TODO [#C] %U %i%?" :empty-lines 1)
          ("g" "GTD" entry (file+datetree "~/Documents/org/agenda/gtd.org")
           "* TODO [#B] %U %i%?" :empty-lines 1)
          ))
  (setq org-refile-targets
        '(("~/Documents/org/agenda/someday.org" :level . 1)
          ("~/Documents/org/agenda/gtd.org" :maxlevel . 3))))

;; @see https://github.com/marcinkoziej/org-pomodoro
(use-package org-pomodoro
  :ensure t
  :defer 3
  )

;; Babel
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

;; @see https://github.com/integral-dw/org-superstar-mode
(use-package org-superstar
  :ensure t
  :defer 3
  :hook (org-mode . org-superstar-mode)
  :init
  (setq org-superstar-prettify-item-bullets t
        org-superstar-headline-bullets-list '("◉" "✸" "⚫" "○" "•")
        org-superstar-leading-bullet ?\s
        org-hide-leading-stars t
        org-superstar-item-bullet-alist        '((?* . ?●)
                                                 (?+ . ?➤)
                                                 (?- . ?—))))

;; (use-package evil-org
;;   :ensure t
;;   :defer 3
;;   :after org evil
;;   :config
;;   (add-hook 'org-mode-hook 'evil-org-mode)
;;   (add-hook 'evil-org-mode-hook
;;             (lambda ()
;;               (evil-org-set-key-theme)))
;;   (require 'evil-org-agenda)
;;   (evil-org-agenda-set-keys))

;; @see https://github.com/louietan/anki-editor
(use-package anki-editor
  :ensure t
  :defer 3
  :hook (org-mode . anki-editor-mode)
  :custom
  (anki-editor-create-decks t))

;; @see https://github.com/kaushalmodi/ox-hugo
(use-package ox-hugo
  :ensure t
  :defer 3
  :after ox)

;; @see https://github.com/abo-abo/org-download
(use-package org-download
  :ensure t
  :defer 3    
  :config
  (setq org-download-image-dir "~/Documents/org/images/"))

;; Rich text clipboard
;; @see https://github.com/unhammer/org-rich-yank
(use-package org-rich-yank
  :ensure t
  :defer 3
  :bind (:map org-mode-map
         ("C-M-y" . org-rich-yank)))

;; Table of contents
;; @see https://github.com/snosov1/toc-org
(use-package toc-org
  :ensure t
  :defer 3
  :hook (org-mode . toc-org-mode))

(provide 'init-org)
;;; init-org.el
