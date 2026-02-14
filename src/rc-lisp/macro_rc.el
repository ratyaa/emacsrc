;; -*- lexical-binding: t; -*-

(eval-when-compile
  (require 'cl-lib))

(defmacro rc/bind-global (&rest binds)
  (let ((result ()))
    (dolist (bind binds)
      (push `(keymap-global-set ,(car bind)
                                (function ,(cadr bind)))
            result))
    (push 'progn result)))

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

(defmacro rc/require (&rest modules)
  (cons 'progn
	(cl-loop for module in modules
		 collect `(require
			   (quote
			    ,(intern (concat module "_rc")))))))

(provide 'macro_rc)
