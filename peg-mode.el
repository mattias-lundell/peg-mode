(require 'treesit)

(defgroup peg nil
  "peg major mode"
  :group 'languages)

(defvar peg--treesit-font-lock-setting
  (treesit-font-lock-rules

   :feature 'comment
   :language 'peg
   '((comment) @font-lock-comment-face)

   :feature 'alias
   :language 'peg
   '((alias (identifier) @font-lock-string-face))

   :feature 'definition
   :language 'peg
   '((definition identifier: (identifier) @font-lock-type-face _))

   :feature 'action
   :language 'peg
   '((action) @font-lock-comment-face)

   :feature 'literal
   :language 'peg
   '([(class) (literal)] @font-lock-string-face)

   :feature 'prefix-suffix
   :language 'peg
   '([(prefix) (suffix)] @font-lock-builtin-face)

   :feature 'identifier
   :language 'peg
   '((identifier) @font-lock-variable-name-face))

  "tree-sitter font-lock settings")

;; (use-package treesit
;;   :straight nil
;;   :ensure nil
;;   :commands (treesit-install-language-grammar)
;;   :init
;;   (setq treesit-language-source-alist
;;         ('(peg . ("https://github.com/mattias-lundell/tree-sitter-peg")))))

;;;###autoload
(define-derived-mode peg-mode fundamental-mode "peg"
  "peg mode"

  (when (treesit-ready-p 'peg)
    (treesit-parser-create 'peg)


    (setq-local treesit-font-lock-settings peg--treesit-font-lock-setting)
    (setq-local treesit-font-lock-feature-list
                '((prefix-suffix comment action identifier literal alias definition)))

    (treesit-major-mode-setup)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.\\(peg\\|pegjs\\)\\'" . peg-mode))

(provide 'peg-mode)

(treesit-language-available-p 'peg)
