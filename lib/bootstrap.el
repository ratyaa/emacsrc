;; -*- lexical-binding: t; -*-

(defvar yo/compile-function #'native-compile
  "Function used to compile elisp files.")

(defvar yo/load-function #'native-elisp-load
  "Function used to load compiled elisp files.")

(defvar yo/compile-suffix "n"
  "Compiled elisp files extension suffix.")

(defvar yo/emacsdir
  (expand-file-name user-emacs-directory)
  "Emacs directory absolute path.")

(unless (native-comp-available-p)
  (setq yo/compile-function #'(lambda (src target)
                                (byte-compile-file src)
                                (ignore target))
        yo/load-function #'load-file
        yo/compile-suffix "c"))

(defun yo/bootstrap-config-lib ()
  "Bootstrap configuration management library."
  (interactive)
  (let* ((src (concat yo/emacsdir "config-init.el"))
         (lib (concat src yo/compile-suffix)))
    (unless (file-exists-p src)
      (user-error "Configuration management library wasn't found"))
    (unless (file-exists-p lib)
      (apply yo/compile-function (list src lib)))
    (apply yo/load-function (list lib))))
