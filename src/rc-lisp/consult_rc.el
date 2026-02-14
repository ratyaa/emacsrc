;; -*- lexical-binding: t; -*-

(use-package consult
  :ensure t
  :bind
  (("C-c c i" . consult-info)
   ("C-c c m" . consult-man))
  :custom
  (consult-async-refresh-delay 0))

(provide 'consult_rc)
