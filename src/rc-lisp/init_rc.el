;; -*- lexical-binding: t; -*-

(eval-when-compile
  (require 'macro_rc))

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(rc/require "minibuffer"
	    "themes"
	    "binds"
	    "consult"
	    "vc"
	    "rainbow-delimiters"
	    "elisp"
	    "nix"
	    "org"
	    "lisp"
	    "treesit")

(setq use-package-always-pin "gnu")

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'electric-pair-mode)

(setq custom-file (concat user-emacs-directory "custom.el"))
(setq indent-tabs-mode nil)

(savehist-mode)

(provide 'init_rc)
