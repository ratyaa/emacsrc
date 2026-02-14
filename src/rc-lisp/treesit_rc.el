;; -*- lexical-binding: t; -*-

(use-package treesit
  :config
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")))
  
  (dolist (language-source treesit-language-source-alist)
    (let ((language (car language-source)))
      (unless (treesit-language-available-p language)
        (treesit-install-language-grammar language))))

  :custom
  (treesit-font-lock-level 4))

(use-package c-ts-mode
  :defer t
  :mode ("\\.c\\'"
         "\\.h\\'")
  :custom
  (c-ts-mode-indent-style 'k&r)
  (c-ts-mode-indent-offset 8))

(provide 'treesit_rc)
