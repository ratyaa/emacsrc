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

;; redefine things to work with emacs w/o native compilation
(unless (native-comp-available-p)
  (setq yo/load-function #'load-file
        yo/compile-suffix "c"
        yo/compile-function #'(lambda (src target)
                                (byte-compile-file src)
                                (ignore target))))

(defun yo/bootstrap-config-lib ()
  "Bootstrap configuration management library."
  (interactive)
  (let* ((src (concat yo/emacsdir "lib/config.el"))
         (lib (concat src yo/compile-suffix)))
    (unless (file-exists-p src)
      (user-error "Configuration management library wasn't found"))
    (unless (file-exists-p lib)
      (apply yo/compile-function (list src lib)))
    (apply yo/load-function (list lib))))
