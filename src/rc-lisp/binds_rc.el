;; -*- lexical-binding: t; -*-

(eval-when-compile
  (require 'macro_rc))

(rc/bind-global
 ("C-h" delete-backward-char)
 ("C-+" text-scale-increase)
 ("C--" text-scale-decrease)
 ("C-c h" help-command))

(provide 'binds_rc)
