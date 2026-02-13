;; -*- lexical-binding: t; -*-

(eval-when-compile (require 'cl-lib))

(defmacro rc/report-evaluation-time (message &rest body)
  (let ((msgsym (gensym))
        (timesym (gensym))
        (returnsym (gensym)))
    `(let ((,msgsym ,message)
           (,timesym (current-time))
           (,returnsym
            (progn
              ,@body)))
       (message (concat "%f seconds " ,msgsym)
                (float-time (time-subtract (current-time)
                                           ,timesym)))
       ,returnsym)))

(defconst rc/emacsdir
  (expand-file-name user-emacs-directory))

(defun rc/--expand-config-paths (basenames)
  (cl-loop for basename in basenames
           collect (concat rc/emacsdir basename)))

(defconst rc/config-paths
  (rc/--expand-config-paths
   '("minibuffer")))

(defconst rc/early-config-paths
  (rc/--expand-config-paths
   '("faces"
     "themes")))

(defconst rc/bootstrap-paths
  (rc/--expand-config-paths
   '("bootstrap"
     "real-early-init")))

(defun rc/--byte-compile-file (src native-comp-target)
  (byte-compile-file src)
  (ignore native-comp-target))

(defun rc/--byte-and-native-compile-file (src native-comp-target)
  (byte-compile-file src)
  (native-compile src native-comp-target))

(defconst rc/--compile-file-function
  (eval-when-compile
    (if (native-comp-available-p)
        #'rc/--byte-and-native-compile-file
      #'rc/--byte-compile-file)))

(defun rc/compile-anyway (paths)
  (dolist (path paths)
    (let ((src (concat path ".el"))
          (native-comp-target (concat path ".eln")))
      (funcall rc/--compile-file-function
               src native-comp-target))))

(defun rc/compile-update (paths)
  (dolist (path paths)
    (let* ((src (concat path ".el"))
           (byte-comp-target (concat path ".elc"))
           (native-comp-target (concat path ".eln"))
           (src-mod-time (file-attribute-modification-time
                          (file-attributes (file-chase-links src))))
           (byte-mod-time (file-attribute-modification-time
                           (file-attributes byte-comp-target))))
      (unless (and (file-exists-p byte-comp-target)
                   (time-less-p src-mod-time byte-mod-time))
        (byte-compile-file src)
        (native-compile src native-comp-target)))))

(defun rc/load (paths)
  (dolist (path paths)
    (load path)))

(defun rc/all-compile-anyway ()
  (interactive)
  (rc/compile-anyway rc/bootstrap-paths)
  (rc/compile-anyway rc/early-config-paths)
  (rc/compile-anyway rc/config-paths))
