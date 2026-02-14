;;; -*- lexical-binding: t -*-

(eval-when-compile
  (require 'macro_rc))

(rc/require "init")

(message (concat "%f seconds total") 
         (float-time (time-subtract (current-time)
                                    before-init-time)))
;; (use-package emacs
;;   :bind (("C-z" . nil)
;;   :custom
;;   (global-auto-revert-mode t)
;;   (indent-tabs-mode nil)
;;  ;;   (fill-column 80)
;;   (default-input-method "russian-computer")
;;   (auto-save-visited-mode t))

;; (use-package rainbow-mode
;;   :ensure t
;;   :defer t)

;; (use-package eglot
;;   :defer t)

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

;; ;; (use-package org-roam
;; ;;   :defer t
;; ;;   :ensure t
;; ;;   :pin "melpa"
;; ;;   :custom
;; ;;   (org-roam-directory "~/store/notes"))

;; (use-package caps-lock
;;   :ensure t
;;   :bind ("C-z" . caps-lock-mode))
