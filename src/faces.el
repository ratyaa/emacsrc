;; -*- lexical-binding: t; -*-

(let ((custom-faces
       '(;; emacs ---
         (default :family "IBM Plex Mono"
                  :height 110)

         ;; font-lock ---
         (font-lock-string-face :foreground "#0000b0"
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
         
         ;; misc ---
         (show-paren-match :background "#f3d000")
         (line-number :height 90))))
  
  (dolist (face custom-faces)
    (face-spec-set (car face)
                   `((t ,(cdr face))))))
