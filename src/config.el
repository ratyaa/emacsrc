;; -*- lexical-binding: t; -*-

(defun rc/compile-config ()
  "Compile configuration files."
  (interactive)
  (let ((basenames (append rc/early-config-basenames
                           rc/config-basenames)))
    (dolist (basename basenames)
      (let* ((src (concat rc/emacsdir basename ".el"))
             (lib (concat src rc/compile-suffix))
             (src-t (file-attribute-modification-time
                     (file-attributes (file-chase-links src))))
             (lib-t (file-attribute-modification-time
                     (file-attributes lib))))
        (unless (file-exists-p src)
          (user-error "Configuration file `%s' wasn't found" basename))
        (unless (and (file-exists-p lib)
                     (time-less-p src-t lib-t))
          (apply rc/compile-function (list src lib))
          (message (format-message "`%s' compiled" basename)))))))

(defun rc/load-config (basenames)
  "Load configuration files."
  (interactive)
  (dolist (basename basenames)
    (let ((lib (concat rc/emacsdir basename ".el" rc/compile-suffix)))
      (apply rc/load-function (list lib)))))
