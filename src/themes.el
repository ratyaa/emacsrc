;; -*- lexical-binding: t; -*-

(eval-and-compile
  (require-theme 'modus-themes))

(defconst rc/modus-override
  modus-themes-preset-overrides-intense
  "I hate long names")

(setq
 modus-themes-common-palette-overrides rc/modus-override
 modus-themes-italic-constructs t
 modus-themes-bold-constructs t)

(load-theme 'modus-operandi)
