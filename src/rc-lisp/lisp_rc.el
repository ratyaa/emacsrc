;; -*- lexical-binding: t; -*-

;; (macroexpand-1 '(use-package slime
;;   :defer t
;;   :ensure t
;;   :pin "nongnu"
;;   :custom
;;   (inferior-lisp-program "sbcl")))

;; (progn
;;   (use-package-pin-package 'slime "nongnu")
;;   (use-package-ensure-elpa 'slime '(t) 'nil)
;;   (progn
;;     (use-package-pin-package 'slime "nongnu")
;;     (use-package-ensure-elpa 'slime '(t) 'nil)
;;     (defvar use-package--warning23
;;       #'(lambda (keyword err)
;;           (let ((msg (format "%s/%s: %s" 'slime keyword (error-message-string err))))
;;             (display-warning 'use-package msg :error))))
;;     (condition-case-unless-debug err
;;         (let ((custom--inhibit-theme-enable nil))
;;           (unless (memq 'use-package custom-known-themes)
;;             (deftheme use-package)
;;             (enable-theme 'use-package)
;;             (setq custom-enabled-themes (remq 'use-package custom-enabled-themes)))
;;           (custom-theme-set-variables 'use-package '(inferior-lisp-program "sbcl" nil nil "Customized with use-package slime")))
;;       (error (funcall use-package--warning23 :catch err))))

;; (progn
;;   (use-package-pin-package 'slime "nongnu")
;;   (use-package-ensure-elpa 'slime '(t) 'nil)
;;   (defvar use-package--warning20 
;;     #'(lambda (keyword err)
;;         (let ((msg (format "%s/%s: %s" 'slime keyword (error-message-string err))))
;;           (display-warning 'use-package msg :error))))
;;   (condition-case-unless-debug err
;;       (eval-after-load 'slime
;;         '(condition-case-unless-debug err (progn
;;                                             (setopt inferior-lisp-program "sbcl") t)
;;            (error (funcall use-package--warning20 :config err))))
;;     (error (funcall use-package--warning20 :catch err))))

(provide 'lisp_rc)
