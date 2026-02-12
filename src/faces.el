;; -*- lexical-binding: t; -*-

(defvar rc/default-face-specs
  '((pgtk
     (default :family "IBM Plex Mono")
     (font-lock-string-face  :foreground "#0000b0"
                             :background "#ccdfff")
     (font-lock-number-face :foreground "#0000b0"
                            :background "#ccdfff")
     (font-lock-escape-face :background "#ffddff")
     (font-lock-constant-face :foreground "#0000b0")
     (font-lock-preprocessor-face :foreground "#7f0000"
                                  :background "#ffe8e8")
     (font-lock-variable-name-face :foreground "#005077"
                                   :background "#d1f4ff")
     (font-lock-function-name-face :background "#ffddff")
     (font-lock-type-face :foreground "#000000"
                          :background "#ffffff"
                          :weight regular)
     (font-lock-punctuation-face :foreground "#595959")
     (font-lock-variable-use-face :foreground "#000000"
                                  :background "#ffffff")
     (font-lock-function-call-face :foreground "#000000"
                                   :background "#ffffff")
     (font-lock-keyword-face :background "#ffddff"
                             :weight regular)
     (font-lock-comment-face :foreground "#006800"
                             :background "#e0f6e0"
                             :slant normal)
     (show-paren-match :background "#f3d000"))))

(defvar rc/monitor-face-specs
  `(("ZQE-CBA" .
     ((pgtk
       (default :font ,(font-spec :size 18))
       (line-number :font ,(font-spec :size 17)))))
    ("0x092F" .
     ((pgtk
       (default :font ,(font-spec :size 18))
       (line-number :font ,(font-spec :size 17)))))))

(defun rc/set-face-attributes (spec-config &optional frame)
  (let* ((terminal-type (terminal-live-p (frame-terminal frame)))
         (specs (alist-get terminal-type spec-config)))
    (dolist (spec specs)
      (apply #'set-face-attribute
             (append (list (car spec) frame)
                     (cdr spec))))))

(defun rc/--frame-set-face-attributes (&optional frame)
  (let* ((monitor (alist-get 'name (frame-monitor-attributes frame)))
         (monitor-config (alist-get monitor rc/monitor-face-specs
                                    nil nil #'equal)))
    (rc/set-face-attributes monitor-config frame)
    (message (concat "yo nigga "
                     (prin1-to-string
                      monitor-config)))))

(defvar rc/--frame-created-mutex
  (make-mutex))

(defvar rc/--frame-appeared-mutex
  (make-mutex))

(defvar rc/--frame-created-cond
  (make-condition-variable rc/--frame-created-mutex))

(defvar rc/--frame-appeared-cond
  (make-condition-variable rc/--frame-appeared-mutex))

(defvar rc/--frame-created? nil)

(defvar rc/--frame-appeared? nil)

(defvar rc/--just-created-frame nil)

(defun rc/--sway-frame-transfer-created (frame)
  (make-thread
   #'(lambda ()
       (with-mutex rc/--frame-appeared-mutex
         (while (not rc/--frame-appeared?)
           (condition-wait rc/--frame-appeared-cond)))
       (with-mutex rc/--frame-created-mutex
         (setq rc/--just-created-frame frame)
         (setq rc/--frame-created? t)
         (condition-notify rc/--frame-created-cond)))))

(defun rc/--sway-frame-set-face-attributes ()
  (let* ((buffer (generate-new-buffer "rc/make-frame" t))
         (cmdstr "swaymsg -mt subscribe '[\"window\"]'")
         (filter-visible
          #'(lambda (proc string)
              (when (string-search "\"visible\": true" string)
                (make-thread
                 #'(lambda ()
                     (kill-buffer (process-buffer proc))
                     (kill-process proc)
                     (with-mutex rc/--frame-appeared-mutex
                       (setq rc/--frame-appeared? t)
                       (condition-notify rc/--frame-appeared-cond))
                     (with-mutex rc/--frame-created-mutex
                       (while (not rc/--frame-created?)
                         (condition-wait rc/--frame-created-cond)))
                     (rc/--frame-set-face-attributes
                      rc/--just-created-frame)
                     (setq rc/--frame-appeared? nil)
                     (setq rc/--frame-created? nil))))))
         (filter-new
          #'(lambda (proc string)
              (when (string-search "\"change\": \"new\"" string)
                (funcall filter-visible proc string)
                (set-process-filter proc filter-visible)))))
    (make-process
     :name "rc/sway-wait-for-appear"
     :buffer buffer
     :command (split-string-shell-command cmdstr)
     :connection-type 'pipe
     :filter filter-new)))
