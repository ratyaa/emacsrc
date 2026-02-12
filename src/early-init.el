;; -*- lexical-binding: t; -*-

(setopt frame-resize-pixelwise t
        frame-inhibit-implied-resize t
        frame-title-format '("%b")
        initial-frame-alist nil
        default-frame-alist
        '((left-fringe . 12)
          (right-fringe . 0))
        
        scroll-bar-mode nil
        menu-bar-mode nil
        tool-bar-mode nil)

(defvar rc/config-basenames nil)
(defvar rc/early-config-basenames
  '("faces"))

(declare-function rc/bootstrap-config-lib nil)

(load (concat user-emacs-directory "bootstrap"))

(rc/bootstrap-config-lib t)
(rc/load-config rc/early-config-basenames)

(declare-function rc/set-face-attributes nil)
(declare-function rc/--frame-set-face-attributes nil)
(declare-function rc/--sway-frame-transfer-created nil)
(declare-function rc/--sway-frame-set-face-attributes nil)

(defun rc/after-init ()
  (rc/set-face-attributes rc/default-face-specs)
  (rc/--frame-set-face-attributes)
  
  (add-hook 'after-make-frame-functions
            #'rc/--sway-frame-transfer-created)
  (add-hook 'before-make-frame-hook
            #'rc/--sway-frame-set-face-attributes))

(add-hook 'after-init-hook
          #'rc/after-init)

;; (add-hook
;;  'modus-themes-post-load-hook
;;  #'(lambda ()
;;      (setopt modus-themes-common-palette-overrides
;;              modus-themes-preset-overrides-intense
             
;;              modus-themes-italic-constructs t
;;              modus-themes-bold-constructs t)))

;;   (setq modus-themes-common-palette-overrides
;;         modus-themes-preset-overrides-intense)
;;   :custom
;;   (modus-themes-italic-constructs t)
;;   (modus-themes-bold-constructs t))

;;   (custom-file (concat user-emacs-directory "custom.el"))
;;   (use-dialog-box nil)
;;   (inhibit-startup-screen t)
;;   (initial-buffer-choice nil)
;;   (initial-major-mode 'fundamental-mode)

;;   (savehist-mode t)
;;   (global-auto-revert-mode t)
;;   (indent-tabs-mode nil)

;;   (fill-column 80)

;;   (default-input-method "russian-computer")
;;   (auto-save-visited-mode t)
