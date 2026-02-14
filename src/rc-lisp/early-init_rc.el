;; -*- lexical-binding: t; -*-

(eval-when-compile
  (require 'macro_rc))

(rc/require "faces")

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

(defun rc/startup ()
  (setq gc-cons-threshold 800000
	gc-cons-percentage 0.1))

(add-hook 'emacs-startup-hook #'rc/startup)

(defun rc/after-init ()
  (rc/set-face-attributes rc/default-face-specs)
  (rc/--frame-set-face-attributes)
  (add-hook 'after-make-frame-functions
            #'rc/--sway-frame-transfer-created)
  (add-hook 'before-make-frame-hook
            #'rc/--sway-frame-set-face-attributes))

(add-hook 'after-init-hook
          #'rc/after-init)

(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize t
      frame-title-format '("%b")
      initial-frame-alist nil
      default-frame-alist
      '((left-fringe . 12)
        (right-fringe . 0))
      inhibit-startup-screen t
      inhibit-x-resources t
      initial-scratch-message nil)

(put 'inhibit-startup-echo-area-message 'saved-value
     (setq inhibit-startup-echo-area-message (user-login-name)))

(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(provide 'early-init_rc)
