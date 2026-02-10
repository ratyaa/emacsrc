;; -*- lexical-binding: t; -*-

(defun yo/compile-config ()
  "Compile configuration files."
  (interactive)
    (dolist (basename yo/config-basenames)
      (let* ((src (concat yo/emacsdir basename "-init.el"))
             (lib (concat src yo/compile-suffix))
             (src-t (file-attribute-modification-time
                     (file-attributes (file-chase-links src))))
             (lib-t (file-attribute-modification-time
                     (file-attributes lib))))
        (unless (file-exists-p src)
          (user-error "Configuration file `%s' wasn't found" basename))
        (unless (and (file-exists-p lib)
                     (time-less-p src-t lib-t))
          (apply yo/compile-function (list src lib))
          (message (format-message "`%s' compiled" basename))))))

(defun yo/load-config ()
  "Load configuration files."
  (interactive)
  (dolist (basename yo/config-basenames)
    (let ((lib (concat yo/emacsdir basename "-init.el" yo/compile-suffix)))
      (apply yo/load-function (list lib)))))
