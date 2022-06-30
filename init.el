;; -*- coding: latin-1; -*-
;; Alice Balard emacs configuration
;; thanks to amazing Susana Ferreira, from code of Emanuel Heitlinger cleaned

;; ===================
;; Basic Customization
;; ===================
(setq user-mail-address "alice.cam.balard@gmail.com")
(setq inhibit-startup-message t)

(require 'package)
;;; Standard package repositories
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(package-initialize)

(setq load-path
      (append (list nil
		    ;;    "~/.emacs.d"
		    "~/.emacs.d/elpa/ess-18.10.2")
	                    load-path))

;; solve some issues when installing packages, related tp TLS
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; reassign suspend emacs to something else
(global-set-key (kbd "C-M-z") 'suspend-emacs)

;; line-numbers, very sophisticated function to make the numbering right-justified and the column the right size
(require 'linum)
(setq
 linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string
																	   w) "d ")) line) 'face 'linum)))
(global-set-key [f1] 'linum-mode)

;; highlight region between point and mark
(transient-mark-mode t)

;; kill whole lines with C-k
(setq kill-whole-line 1)

;; write y instead of yes
(fset 'yes-or-no-p 'y-or-n-p)

;; parentheses highlighting
;; (require 'highlight-parentheses)
;; (setq hl-paren-colors '("red"  "green" "color-93" "cyan" "color-153" "color-200" "color-154" "color-118"))
;; (define-globalized-minor-mode
;;  global-highlight-parentheses-mode
;;  highlight-parentheses-mode
;;  highlight-parentheses-mode)
;; (global-highlight-parentheses-mode)

;; =========================
;; Window and buffer general
;; =========================
;; Easy between windows
(defun select-next-window ()
  "Switch to the next window"
  (interactive)
  (select-window (next-window)))

(defun select-previous-window ()
  "Switch to the previous window"
  (interactive)
  (select-window (previous-window)))
(global-set-key "\C-xo" 'select-next-window)
(global-set-key "\C-xO" 'select-previous-window)

;; =============
;; ESS stuff (R)
;; =============
(require 'ess-site)
;; ;; set the help right to open text
(setq inferior-ess-r-help-command "help(\"%s\", help_type=\"text\")\n")

;; ;; always scroll to output and input
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)

(setq ess-tab-complete-in-script t)
(require 'color)

;; Sweave .Rnw mode stuff.
(require 'ess-noweb)
 (autoload 'R-mode "ess-site.el" "ESS" t)

;;show matching parentheses
(show-paren-mode 1)

;; restore frames from previos session)
(desktop-save-mode)   
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ess-smart-underscore highlight-parentheses tabbar session pod-mode muttrc-mode mutt-alias markdown-mode magit initsplit htmlize graphviz-dot-mode folding eproject diminish csv-mode browse-kill-ring boxquote bm bar-cursor apache-mode virtualenvwrapper pyenv-mode jedi gruvbox-theme gruber-darker-theme ess elpy dracula-theme darktooth-theme badwolf-theme auctex))))

;; from R-internals manual: properly setup the indent in R
(add-hook 'ess-mode-hook
	  (lambda ()
	    (ess-set-style 'C++ 'quiet)
	    (add-hook 'local-write-file-hooks
		      (lambda ()
			(ess-nuke-trailing-whitespace)))))

;; do not indent single # comment to the far right (annoying default)
(setq ess-fancy-comments nil)

;; ============
;; Python stuff
;; ============
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    material-theme                  ;; Theme
    )
  )

;; =================
;; Development Setup
;; =================
;; Enable elpy
;; (require 'elpy)
;; (elpy-enable)

;; User-Defined init.el ends here
