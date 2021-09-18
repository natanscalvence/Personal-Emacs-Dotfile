;; Configure the interface

(scroll-bar-mode -1) ; disable scrollbar
(tool-bar-mode -1) ; remove the toolbar
(tooltip-mode -1) ; disable tooltips
(set-fringe-mode 10) ; give some breathing room
(setq visible-bell t) ; set up the visible bell

;; Configure the theme

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'mac-classic t)

;; Configure the packages

(eval-and-compile
  (require 'package)
  (setq package-archives '(("elpa" . "https://elpa.gnu.org/packages/")
			   ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  ;; i always fetch the archive contents on startup and during compilation, which is slow
  (package-refresh-contents)
  (unless (package-installed-p 'use-package)
    (package-install 'use-package))
  (require 'use-package)
  ;; i don't really know why this isn't the default...
  (setf use-package-always-ensure t))

;; Configuration of dashboard

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-banner-logo-title "svn is better than git")
(setq dashboard-startup-banner "~/.emacs.d/assets/image.png")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (sr-speedbar flycheck rtags ggtags lorem-ipsum use-package dashboard-ls))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Configure srefactor

(use-package srefactor
  :ensure t
  :config
  (semantic-mode 1)
  (define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  (define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  )

;; configure the speedbar

(use-package sr-speedbar
  :ensure t
  :config)

;; Configure ggtags

;; You can insert this → "(require 'ggtags)" if you install ggtags from source

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;; Configure the flycheck

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq flycheck-display-errors-function
	#'flycheck-display-error-messages-unless-error-list)

  (setq flycheck-indication-mode nil))

(use-package flycheck-pos-tip
  :ensure t
  :after flycheck
  :config
  (flycheck-pos-tip-mode))

;; configure the lorem-ipsum

(lorem-ipsum-use-default-bindings) ;; "C-c l p" inserts a new paragraph

;; C-c l s inserts a sentences, and C-c l l inserts a list.
