;;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(defvar yo/config-basenames
  '("org"
    "faces"
    "vc")
  "Basenames of my configuration files, without `-init' suffix.
Order matters.")

(load (concat user-emacs-directory "bootstrap"))

(declare-function yo/bootstrap-config-lib nil)
(declare-function yo/load-config nil)

(yo/bootstrap-config-lib)
(yo/load-config)

(use-package modus-themes
  :defer t
  :config
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)
  :custom
  (modus-themes-italic-constructs t)
  (modus-themes-bold-constructs t))

(use-package use-package
  :custom
  (use-package-always-pin "gnu"))

(use-package emacs
  :bind (("C-z" . nil)

         ("C-h" . delete-backward-char)

         ("C-+" . text-scale-increase)
         ("C--" . text-scale-decrease)

         ("C-c h" . help-command))

  :custom
  (custom-file (concat user-emacs-directory "custom.el"))

  (use-dialog-box nil)

  (inhibit-startup-screen t)
  (initial-buffer-choice nil)
  (initial-major-mode 'fundamental-mode)

  (menu-bar-mode nil)
  (tool-bar-mode nil)
  (scroll-bar-mode nil)
  (savehist-mode t)
  (global-auto-revert-mode t)

  (indent-tabs-mode nil)

  (default-frame-alist
   '((left-fringe . 12)
     (right-fringe . 0)
     (vertical-scroll-bars . nil)
     (horizontal-scroll-bars . nil)))

  (frame-resize-pixelwise t)

  (fill-column 80)

  (custom-enabled-themes '(modus-operandi))

  (default-input-method "russian-computer")

  (auto-save-visited-mode t))

(use-package rainbow-delimiters
  :ensure t
  :pin "nongnu"
  :defer t
  :hook (emacs-lisp-mode))

(use-package rainbow-mode
  :ensure t
  :defer t)

(use-package elisp-mode
  :defer t
  :config
  (keymap-set emacs-lisp-mode-map "M-q"
	      #'lisp-fill-paragraph))

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
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure t
  :bind
  (("C-c c i" . consult-info)
   ("C-c c m" . consult-man))
  :custom
  (consult-async-refresh-delay 0))

(use-package nix-mode
  :ensure t
  :pin "nongnu"
  :defer t)

(use-package eglot
  :defer t)

(use-package display-line-numbers
  :defer t
  :hook (prog-mode))

(use-package electric-pair
  :defer t
  :hook (prog-mode))

(use-package auto-fill-mode
  :defer t
  :hook (org-mode))

(use-package denote
  :ensure t
  :hook
  (dired-mode . denote-dired-mode)
  :bind
  (("C-c n n" . denote)
   ("C-c n r" . denote-rename-file)
   ("C-c n l" . denote-link)
   ("C-c n b" . denote-backlinks)
   ("C-c n d" . denote-dired)
   ("C-c n g" . denote-grep))
  :custom
  (denote-directory (expand-file-name "~/store/notes")))

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

(use-package show-paren
  :defer t)

;; (use-package org-roam
;;   :defer t
;;   :ensure t
;;   :pin "melpa"
;;   :custom
;;   (org-roam-directory "~/store/notes"))

;; startup time ---
;; (defvar current-init-timestamp before-init-time)
;; (defun emacs-report-init-timestamp ()
;;   (let* ((time (current-time))
;; 	 (str (format "%f seconds"
;; 		      (float-time (time-subtract time
;; 						 current-init-timestamp)))))
;;     (setq current-init-timestamp time)
;;     (message "%s" str)))
;; (add-hook 'after-init-hook #'emacs-report-init-timestamp)
;; ----------------

(use-package caps-lock
  :ensure t
  :bind ("C-z" . caps-lock-mode))
