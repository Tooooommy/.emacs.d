;; @see https://github.com/jrblevin/markdown-mode
;; @from centuar-emacs
(use-package markdown-mode
  :ensure t
  :defines flycheck-markdown-markdownlint-cli-config
  :preface
  ;; Lint: npm i -g markdownlint-cli
  (defun flycheck-enable-markdownlint ()
    "Set the `mardkownlint' config file for the current buffer."
    (let* ((md-lint ".markdownlint.json")
           (md-file buffer-file-name)
           (md-lint-dir (and md-file
                             (locate-dominating-file md-file md-lint))))
      (setq-local flycheck-markdown-markdownlint-cli-config
                  (concat md-lint-dir md-lint))))
  :hook ((markdown-mode . flyspell-mode)
         (markdown-mode . auto-fill-mode)
         (markdown-mode . flycheck-enable-markdownlint))
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  (setq
   markdown-command "pandoc"
   markdown-enable-wiki-links t
   markdown-italic-underscore t
   markdown-asymmetric-header t
   markdown-make-gfm-checkboxes-buttons t
   markdown-gfm-uppercase-checkbox t
   markdown-fontify-code-blocks-natively t
   markdown-enable-math t
   markdown-content-type "application/xhtml+xml"
   markdown-css-paths '("https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.min.css"
                        "https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/styles/github.min.css")
   markdown-xhtml-header-content "
  <meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>
  <style>
  body {
    box-sizing: border-box;
    max-width: 740px;
    width: 100%;
    margin: 40px auto;
    padding: 0 10px;
  }
  </style>
  <script src='https://cdn.jsdelivr.net/gh/highlightjs/cdn-release/build/highlight.min.js'></script>
  <script>
  document.addEventListener('DOMContentLoaded', () => {
    document.body.classList.add('markdown-body');
    document.querySelectorAll('pre[lang] > code').forEach((code) => {
      code.classList.add(code.parentElement.lang);
      hljs.highlightBlock(code);
    });
  });
  </script>
  ")
  :config
  ;; @see https://github.com/masasam/emacs-easy-hugo
  (use-package easy-hugo
    :ensure t
    :config
    (setq easy-hugo-basedir "~/bookshelf/"
          easy-hugo-url "https://yourid.github.io" ;; deploy on github page
          easy-hugo-sshdomain "blogdomain"
          easy-hugo-root "/home/blog/"
          easy-hugo-previewtime "300"))

  ;; @see https://github.com/ardumont/markdown-toc
  (use-package markdown-toc
    :ensure t
    :bind (:map markdown-mode-command-map
           ("r" . markdown-toc-generate-or-refresh-toc))))


(provide 'init-markdown)
;;; init-markdown ends here
