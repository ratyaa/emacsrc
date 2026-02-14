;; -*- lexical-binding: t; -*-

(eval-when-compile
  (require 'macro_rc))

(rc/require "faces")

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
      
      scroll-bar-mode nil
      menu-bar-mode nil
      tool-bar-mode nil)

(provide 'early-init_rc)
