;; -*- lexical-binding: t; -*-

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
  (eval-when-compile
    (expand-file-name user-emacs-directory))
  "Emacs directory absolute path.")

(define-inline rc/--expand-config-path (basename)
  (inline-letevals (basename
                    (emacsdir (inline-const-val rc/emacsdir)))
    (inline-quote (concat ,emacsdir ,basename))))

(defconst rc/config-paths
  (eval-when-compile
    (mapcar
     #'rc/--expand-config-path
     '("themes"))))

(defconst rc/early-config-paths
  (eval-when-compile
    (mapcar
     #'rc/--expand-config-path
     '("faces"))))

(defconst rc/--bootstrap-path
  (eval-when-compile (rc/--expand-config-path "bootstrap")))
(defconst rc/--bootstrap-src
  (eval-when-compile (concat rc/--bootstrap-path ".el")))
(defconst rc/--bootstrap-src-expanded
  (eval-when-compile (expand-file-name rc/--bootstrap-src)))
(defconst rc/--bootstrap-byte-comp-target
  (eval-when-compile (concat rc/--bootstrap-path ".elc")))
(defconst rc/--bootstrap-native-comp-target
  (eval-when-compile (concat rc/--bootstrap-path ".eln")))

(defconst rc/--early-init-path
  (eval-when-compile (rc/--expand-config-path "real-early-init")))
(defconst rc/--early-init-src
  (eval-when-compile (concat rc/--early-init-path ".el")))
(defconst rc/--early-init-src-expanded
  (eval-when-compile (expand-file-name rc/--early-init-src)))
(defconst rc/--early-init-byte-comp-target
  (eval-when-compile (concat rc/--early-init-path ".elc")))
(defconst rc/--early-init-native-comp-target
  (eval-when-compile (concat rc/--early-init-path ".eln")))

(define-inline rc/--byte-compile-file (src native-comp-target)
  (byte-compile-file src)
  (ignore native-comp-target))

(defsubst rc/--byte-and-native-compile-file (src native-comp-target)
  (byte-compile-file src)
  (native-compile src native-comp-target))

(defconst rc/--compile-file-function
  (eval-when-compile
    (if (native-comp-available-p)
        #'rc/--byte-and-native-compile-file
      #'rc/--byte-compile-file)))

(defun rc/bootstrap-compile-anyway ()
  (funcall rc/--compile-file-function
           rc/--bootstrap-src
           rc/--bootstrap-native-comp-target))

(defsubst rc/bootstrap-compile-update ()
  (let ((src-mod-time
         (file-attribute-modification-time
          (file-attributes rc/--bootstrap-src-expanded)))
        (byte-mod-time
         (file-attribute-modification-time
          (file-attributes rc/--bootstrap-byte-comp-target))))
    (unless (and (file-exists-p rc/--bootstrap-byte-comp-target)
                 (time-less-p src-mod-time byte-mod-time))
      (funcall rc/--compile-file-function
               rc/--bootstrap-src
               rc/--bootstrap-native-comp-target))))

(defun rc/early-init-compile-anyway ()
  (funcall rc/--compile-file-function
           rc/--early-init-src
           rc/--early-init-native-comp-target))

(defsubst rc/early-init-compile-update ()
  (let ((src-mod-time
         (file-attribute-modification-time
          (file-attributes rc/--early-init-src-expanded)))
        (byte-mod-time
         (file-attribute-modification-time
          (file-attributes rc/--early-init-byte-comp-target))))
    (unless (and (file-exists-p rc/--early-init-byte-comp-target)
                 (time-less-p src-mod-time byte-mod-time))
      (funcall rc/--compile-file-function
               rc/--early-init-src
               rc/--early-init-native-comp-target))))

(defun rc/compile-anyway (paths)
  (dolist (path paths)
    (let ((src (concat path ".el"))
          (native-comp-target (concat path ".eln")))
      (funcall rc/--compile-file-function
               src native-comp-target))))

(defsubst rc/compile-update (paths)
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

(defsubst rc/load (paths)
  (dolist (path paths)
    (load path)))

(defun rc/all-compile-anyway ()
  (interactive)
  (rc/bootstrap-compile-anyway)
  (rc/early-init-compile-anyway)
  (rc/compile-anyway rc/early-config-paths)
  (rc/compile-anyway rc/early-config-paths))
