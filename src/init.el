;;; -*- lexical-binding: t -*-

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(eval-when-compile
  (require 'macro_rc))

(setq use-package-always-pin "gnu")

(rc/require "minibuffer"
	    "themes"
	    "binds"
	    "consult"
	    "vc")

(message (concat "%f seconds total") 
         (float-time (time-subtract (current-time)
                                    before-init-time)))

;; (use-package emacs
;;   :bind (("C-z" . nil)
;;   :custom
;;   (custom-file (concat user-emacs-directory "custom.el"))

;;   (use-dialog-box nil)

;;   (inhibit-startup-screen t)
;;   (initial-buffer-choice nil)
;;   (initial-major-mode 'fundamental-mode)

;;   (menu-bar-mode nil)
;;   (tool-bar-mode nil)
;;   (scroll-bar-mode nil)
;;   (savehist-mode t)
;;   (global-auto-revert-mode t)

;;   (indent-tabs-mode nil)

;;   (default-frame-alist
;;    '((left-fringe . 12)
;;      (right-fringe . 0)
;;      (vertical-scroll-bars . nil)
;;      (horizontal-scroll-bars . nil)))

;;   (frame-resize-pixelwise t)

;;   (fill-column 80)

;;   (custom-enabled-themes '(modus-operandi))

;;   (default-input-method "russian-computer")

;;   (auto-save-visited-mode t))

;; (use-package rainbow-delimiters
;;   :ensure t
;;   :pin "nongnu"
;;   :defer t
;;   :hook (emacs-lisp-mode))

;; (use-package rainbow-mode
;;   :ensure t
;;   :defer t)

;; (use-package elisp-mode
;;   :defer t
;;   :config
;;   (keymap-set emacs-lisp-mode-map "M-q"
;; 	      #'lisp-fill-paragraph))

;; (use-package nix-mode
;;   :ensure t
;;   :pin "nongnu"
;;   :defer t)

;; (use-package eglot
;;   :defer t)

;; (use-package display-line-numbers
;;   :defer t
;;   :hook (prog-mode))

;; (use-package electric-pair
;;   :defer t
;;   :hook (prog-mode))

;; (use-package auto-fill-mode
;;   :defer t
;;   :hook (org-mode))

;; (use-package denote
;;   :ensure t
;;   :hook
;;   (dired-mode . denote-dired-mode)
;;   :bind
;;   (("C-c n n" . denote)
;;    ("C-c n r" . denote-rename-file)
;;    ("C-c n l" . denote-link)
;;    ("C-c n b" . denote-backlinks)
;;    ("C-c n d" . denote-dired)
;;    ("C-c n g" . denote-grep))
;;   :custom
;;   (denote-directory (expand-file-name "~/store/notes")))

;; (use-package treesit
;;   :config
;;   (setq treesit-language-source-alist
;;         '((c "https://github.com/tree-sitter/tree-sitter-c")
;;           (cpp "https://github.com/tree-sitter/tree-sitter-cpp")))
  
;;   (dolist (language-source treesit-language-source-alist)
;;     (let ((language (car language-source)))
;;       (unless (treesit-language-available-p language)
;;         (treesit-install-language-grammar language))))

;;   :custom
;;   (treesit-font-lock-level 4))

;; (use-package c-ts-mode
;;   :defer t
;;   :mode ("\\.c\\'"
;;          "\\.h\\'")
;;   :custom
;;   (c-ts-mode-indent-style 'k&r)
;;   (c-ts-mode-indent-offset 8))

;; (use-package show-paren
;;   :defer t)

;; ;; (use-package org-roam
;; ;;   :defer t
;; ;;   :ensure t
;; ;;   :pin "melpa"
;; ;;   :custom
;; ;;   (org-roam-directory "~/store/notes"))

;; ;; startup time ---
;; ;; (defvar current-init-timestamp before-init-time)
;; ;; (defun emacs-report-init-timestamp ()
;; ;;   (let* ((time (current-time))
;; ;; 	 (str (format "%f seconds"
;; ;; 		      (float-time (time-subtract time
;; ;; 						 current-init-timestamp)))))
;; ;;     (setq current-init-timestamp time)
;; ;;     (message "%s" str)))
;; ;; (add-hook 'after-init-hook #'emacs-report-init-timestamp)
;; ;; ----------------

;; (use-package caps-lock
;;   :ensure t
;;   :bind ("C-z" . caps-lock-mode))
