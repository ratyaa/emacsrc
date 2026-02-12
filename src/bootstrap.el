;; -*- lexical-binding: t; -*-

(defvar rc/compile-function #'native-compile
  "Function used to compile elisp files.")

(defvar rc/load-function #'native-elisp-load
  "Function used to load compiled elisp files.")

(defvar rc/compile-suffix "n"
  "Compiled elisp files extension suffix.")

(defvar rc/emacsdir
  (expand-file-name user-emacs-directory)
  "Emacs directory absolute path.")

;; redefine things to work with emacs w/o native compilation
(unless (native-comp-available-p)
  (setq rc/load-function #'load-file
        rc/compile-suffix "c"
        rc/compile-function #'(lambda (src target)
                                (byte-compile-file src)
                                (ignore target))))

(defun rc/bootstrap-config-lib (&optional not-recompilep)
  "Bootstrap configuration management library."
  (interactive)
  (let* ((src (concat rc/emacsdir "config.el"))
         (lib (concat src rc/compile-suffix)))
    (unless (file-exists-p src)
      (user-error "Configuration management library wasn't found"))
    (unless (and (file-exists-p lib)
                 not-recompilep)
      (apply rc/compile-function (list src lib)))
    (apply rc/load-function (list lib))))
