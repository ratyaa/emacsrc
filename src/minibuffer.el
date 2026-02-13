;; -*- lexical-binding: t; -*-

(use-package vertico
  :ensure t
  :init
  (setq vertico-count 20)
  (vertico-mode))

(use-package marginalia
  :ensure t
  :init
  (keymap-set minibuffer-local-map "M-a"
	      #'marginalia-cycle)
  (marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))
