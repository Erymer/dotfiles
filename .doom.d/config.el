;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Para saber que variables están disponibles C-h v
;; Para activar funciones en buffer M-x

(setq-default evil-escape-key-sequence "cg")
(setq abbrev-file-name "~/.config/abbreviations/abbrev_defs")
(setq-default abbrev-mode t) ;; abbrev-mode activado

;; Different size for different header levels in org mode
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.15))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.13))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)
(setq-default org-startup-folded t) ;; Abre archivos org con los temas fold
(setq org-hide-emphasis-markers t)
(setq org-hide-leading-stars t)

(global-set-key (kbd "C-c h") 'unexpand-abbrev)

(use-package org-roam
  :ensure t
  :custom
  ;; (org-roam-directory "~/tests/roam")
  (org-roam-directory "~/Documents/DnD/stars-without-numbers/Wiki")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))


(defun mag-text-mode () ;; auto wrap
  (setq fill-column 80)
  (setq flyspell-mode t)
  (setq flyspell-default-dictionary "spanish")
  (auto-fill-mode t))

(add-hook 'text-mode-hook #'mag-text-mode)

(require 'ledger-mode)
(add-to-list 'auto-mode-alist '("\\.ldg\\'" . ledger-mode))

(add-to-list 'auto-mode-alist '("\\.beancount\\'" . org-mode))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marcelo Galvan"
      user-mail-address "marcelog06@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Fira Mono" :size 13 :weight 'light)
       doom-variable-pitch-font (font-spec :family "sans" :size 10))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; Mas temas en https://github.com/hlissner/emacs-doom-themes
(setq doom-theme 'doom-old-hope)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
