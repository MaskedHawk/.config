;package MALPA
;(add-to-list 'package-archives'("melpa" . "http://melpa.org/packages/"))
;disable backup

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq backup-inhibited t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(ac-config-default)

;Two spaces tabulation
(setq tab-width 4)
;Highlight selected zone
(transient-mark-mode 1)
;Show paren-mode
(setq show-paren-face 'modeline)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages (quote (auto-complete)))
 '(show-paren-mode t nil (paren))
 '(show-paren-style (quote parenthesis)))

;Color and revert
(setq global-font-lock-mode t)
(setq global-auto-revert-mode t)

;Show column and line
(column-number-mode t)
(line-number-mode t)

;Avoid useless new line when line is too long
(setq truncate-partial-width-windows nil)

;Remove trailing whitespace on save
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

;Remove last trailing new line
(defun my-other-delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file, even the last one"
  (interactive)
  (save-excursion
	(save-restriction
	  (widen)
	  (goto-char (point-max))
	  (delete-blank-lines)
	  (let ((trailnewlines (abs (skip-chars-backward "\n\t"))))
		(if (> trailnewlines 0)
			(progn
			    (delete-char trailnewlines)))))))
;Alt + Arrows -> Change buffer
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;Set scrolling 1 line by 1, the default configuration is confusing
(setq scroll-step 1)

;'y or n' instead of 'yes or no'
(fset 'yes-or-no-p 'y-or-n-p)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
