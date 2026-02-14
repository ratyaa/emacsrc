;; -*- lexical-binding: t; -*-

(defconst rc/lisp-directory
  (directory-file-name
   (expand-file-name
    (concat user-emacs-directory "rc-lisp"))))

(defun rc/recompile ()
  (interactive)
  (byte-recompile-directory rc/lisp-directory 0 nil t))

(push rc/lisp-directory load-path)

(require 'early-init_rc)
