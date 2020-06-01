(package-initialize)
(elpy-enable)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/e-stuff/")

(require 'org-journal)

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [C-tab] nil)))

;; KEY STUFF
;; kill bindings
;;(define-key elpy-mode-map (kbd "<M-up>") nil)
;;(define-key elpy-mode-map (kbd "<M-down>") nil)
(define-key elpy-mode-map (kbd "<C-up>") nil)
(define-key elpy-mode-map (kbd "<C-down>") nil)

;; text stuff
(global-set-key (kbd "s-r") 'kill-word)

;; movements
(global-set-key (kbd "<C-up>") 'xah-backward-block)
(global-set-key (kbd "<C-down>") 'xah-forward-block)

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(add-hook 'text-mode-hook
          (lambda() (setq indent-line-function 'insert-tab)))

;; buffers
(global-set-key [C-tab] 'ace-window)
(global-set-key (kbd "M-ö") 'shrink-window-horizontally)
(global-set-key (kbd "C-ö") 'enlarge-window-horizontally)
(global-set-key (kbd "s-w") 'next-buffer)
(global-set-key (kbd "s-q") 'previous-buffer)
(global-set-key (kbd "C-z") 'kill-this-buffer)
;;(global-set-key (kbd "s-b") 'switch-to-buffer)
(global-set-key (kbd "s-b") 'buffer-list)

;; brackets etc
(global-set-key (kbd "M-1") (lambda () (interactive) (insert "[")))
(global-set-key (kbd "M-2") (lambda () (interactive) (insert "]")))
(global-set-key (kbd "M-3") (lambda () (interactive) (insert "{")))
(global-set-key (kbd "M-4") (lambda () (interactive) (insert "}")))
(global-set-key (kbd "M-8") (lambda () (interactive) (insert "(")))
(global-set-key (kbd "M-9") (lambda () (interactive) (insert ")")))

;; IVY 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    
;; global settings
(desktop-save-mode 1)
(global-linum-mode t)
(show-paren-mode 1)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(require 'powerline)
(powerline-vim-theme)

;; python stuff
(add-hook 'python-mode-hook 'pretty-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
;;(setq elpy-rpc-backend "jedi")
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook
    (lambda ()
        (local-set-key (kbd "s-y") 'yas-insert-snippet)))

;; movement functions
(defun xah-backward-block (&optional n)
  "Move cursor to previous text block.
See: `xah-forward-block'
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n))
        ($i 1))
    (while (<= $i n)
      (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
          (progn (skip-chars-backward "\n\t "))
        (progn (goto-char (point-min))
               (setq $i n)))
      (setq $i (1+ $i)))))

(defun xah-forward-block (&optional n)
  "Move cursor beginning of next text block.
A text block is separated by blank lines.
This command similar to `forward-paragraph', but this command's behavior is the same regardless of syntax table.
URL `http://ergoemacs.org/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" n)))
    
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(ansi-term-color-vector
   [unspecified "#FFFFFF" "#d15120" "#5f9411" "#d2ad00" "#6b82a7" "#a66bab" "#6b82a7" "#505050"])
 '(beacon-color "#eab4484b8035")
 '(blink-cursor-mode nil)
 '(company-quickhelp-color-background "#b0b0b0")
 '(company-quickhelp-color-foreground "#232333")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (acme)))
 '(custom-safe-themes
   (quote
    ("5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea" "c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c" "5bd7060386f1237b8934b29a77ee91f21c120ee0a8ec3ba3332a366e30367e47" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "fa05a45863d7ecf001e0b4f7919403a337bb66a9536b44e258e9007cdf9627c6" "f39b5d2d370752da4d2df5ac25051ded1c6350ed571cfab291266b9e2b5a3217" "00661f8d5c4aaca490f996b1ed7f565e2820e58518832b182b0d54b2d716f380" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "53993d7dc1db7619da530eb121aaae11c57eaf2a2d6476df4652e6f0bd1df740" "ea44def1fa1b169161512d79a65f54385497a6a5fbc96d59c218f852ce35b2ab" "1f36ca86913068b7d8377a327394eecfff71be34119619f779cb229875ceec0c" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "ac1845e5e6f910a540a32c3a0d57878155c9b2eba9e922c639a34d4cc81d10db" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "7533e1fc8345739ea0ace60330ebffdf9da46398490b4c36c7e48775e5621052" "b69323309e5839676409607f91c69da2bf913914321c995f63960c3887224848" "a70b47c87e9b0940f6fece46656200acbfbc55e129f03178de8f50934ac89f58" "f47f2c6b2052c81ecf8f2da64f481a92b53a3fd17680b054ea9b81c916dee4b9" "2f945b8cbfdd750aeb82c8afb3753ebf76a1c30c2b368d9d1f13ca3cc674c7bc" "0eb3c0868ff890b0c4ee138069ce2a8936a8a69ba150efa6bfb9fb7c05af5ec3" "2b9dc43b786e36f68a9fd4b36dd050509a0e32fe3b0a803310661edb7402b8b6" "8f97d5ec8a774485296e366fdde6ff5589cf9e319a584b845b6f7fa788c9fa9a" "a9bea6e08d4be42bc8d2949300825a5ee6a2058bab8d4f8bbe05feb8cf8b8724" "902755e0f38fef8c3625cc5cb4948ac80103f163713a7023b51dd02495a3c238" "3ee39fe8a6b6e0f1cbdfa33db1384bc778e3eff4118daa54af7965e9ab8243b3" "8e797edd9fa9afec181efbfeeebf96aeafbd11b69c4c85fa229bb5b9f7f7e66c" "b583823b9ee1573074e7cbfd63623fe844030d911e9279a7c8a5d16de7df0ed0" "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "03f28a4e25d3ce7e8826b0a67441826c744cbf47077fb5bc9ddb18afe115005f" "eb2af3dab07c8013742dec174bc1045569dd69d1185ef591c5e50139fcd3121f" "bc11fcb7307785506677eebc18a3085c7ab64d018291afa6fb5dbe6e06c94cc7" "677663ad3785881b4ae6055594407f29f7f3ed20a96942da6e322973df1401b7" "eecb5845e8076a5f60424900bf0c5177fe58f7345d35ee47cdfd4148c69279b7" "33d9e4e01648c9866935ffd0485e7a20d0b31a0578715a3089287450cbd6e4e0" "70fb495329d0f57c65a62dad5dba93396b9b15c9583109ddcc33f6a206ce5f3d" "f3b3b97fd458d16c6cca5179c45ca3f366b4c33cebbf35372379c8ecbef455f6" "0e521b84cac9d603f9eda08ae55c2daf81ad1e233f578bb9690b664de7440f23" "4d4148de4ba4797c309372642975dddeb692973845cd7f2c212825fd0f662632" "eb6f74f0afa65239d5c77a5fd55045d567519351c88c665418eba6059000f4c7" "f12f6f41496ae060837fb062b2e8569776626706f93b99632098fdd57e821b98" "bbfeae42e5dee1225ed58ae1c5aaa6a1d1bb3a668e2664bd9e5481eb33a98091" "3c1ff15b016db2ce3b316ede3fd1d6f3741df47a5dff6be1e9857be1d67dc583" "bb00fb54d99b76d8fcbe5a585e4406f0c45f9350af3a08f76cd26f41fe8b210b" "04ab31d40c6b4a0071dcdc15418b30361018b9448cdb19dbd56b456f2032b45b" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "4fad7b76d4ba092d519b4da4f93ba264e0d2081c40dbc96ff16d861e16948bfe" "72b5e3ae3fa89ab40aff15c0f75ba3763ec3ece9e3e238523f98463d2dad3657" "af6d045e678f37d548bad4829c09e4ee57841fb0fc94138cbee3a49ec8417177" "88657dd9f890b231c85c88147dac3ba588d7baabddc981db0e312b9155eee5c7" "d1c875cd726c8ea0065e95a6fbe5976425bd33ce393aac0b90f473c1db445a8c" "236fd59ab72a726c1fed23db95aa9d3afb1b38d0876560792dd9c0f611d8c3e9" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(electric-indent-mode t)
 '(elpy-modules
   (quote
    (elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-yasnippet elpy-module-django elpy-module-autodoc elpy-module-sane-defaults)))
 '(evil-emacs-state-cursor (quote ("#E57373" hbar)))
 '(evil-insert-state-cursor (quote ("#E57373" bar)))
 '(evil-normal-state-cursor (quote ("#FFEE58" box)))
 '(evil-visual-state-cursor (quote ("#C5E1A5" box)))
 '(fci-rule-character-color "#d9d9d9")
 '(fci-rule-color "#6a737d")
 '(flymake-error-bitmap
   (quote
    (flymake-double-exclamation-mark modus-theme-fringe-red)))
 '(flymake-note-bitmap (quote (exclamation-mark modus-theme-fringe-cyan)))
 '(flymake-warning-bitmap (quote (exclamation-mark modus-theme-fringe-yellow)))
 '(font-use-system-font t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-indent-guides-auto-enabled nil)
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-background-colors (quote ("#e8fce8" "#c1e7f8" "#f8e8e8")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(hl-sexp-background-color "#efebe9")
 '(hl-todo-keyword-faces
   (quote
    (("HOLD" . "#714900")
     ("TODO" . "#721045")
     ("NEXT" . "#5317ac")
     ("THEM" . "#8f0075")
     ("PROG" . "#005589")
     ("OKAY" . "#185870")
     ("DONT" . "#305c00")
     ("FAIL" . "#a80000")
     ("DONE" . "#005f00")
     ("NOTE" . "#804000")
     ("KLUDGE" . "#8b3800")
     ("HACK" . "#8b3800")
     ("TEMP" . "#4d0006")
     ("FIXME" . "#a0132f")
     ("XXX+" . "#972500")
     ("REVIEW" . "#005a68")
     ("DEPRECATED" . "#001170"))))
 '(ibuffer-deletion-face (quote dired-flagged))
 '(ibuffer-filter-group-name-face (quote dired-mark))
 '(ibuffer-marked-face (quote dired-marked))
 '(ibuffer-title-face (quote dired-header))
 '(ivy-mode nil)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#032f62" "#6a737d" "#d73a49" "#6a737d" "#005cc5" "#6f42c1" "#d73a49" "#6a737d")))
 '(org-support-shift-select t)
 '(package-selected-packages
   (quote
    (apropospriate-theme modus-operandi-theme colorless-themes smart-mode-line-powerline-theme kaolin-themes counsel spaceline solarized-theme python pretty-mode org-journal nofrils-acme-theme material-theme magit jedi haskell-mode gruvbox-theme flycheck ess elpy company-jedi auctex anaconda-mode ace-window)))
 '(pdf-view-midnight-colors (quote ("#6a737d" . "#fffbdd")))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sml/active-background-color "#c1e7f8")
 '(sml/active-foreground-color "#000000")
 '(sml/inactive-background-color "#0067a8")
 '(sml/inactive-foreground-color "#000000")
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote sml/global)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(tabbar-background-color "#353335333533")
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(vc-annotate-background "#3390ff")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#6a737d")
     (40 . "#032f62")
     (60 . "#6a737d")
     (80 . "#6a737d")
     (100 . "#6a737d")
     (120 . "#d73a49")
     (140 . "#6a737d")
     (160 . "#6a737d")
     (180 . "#6a737d")
     (200 . "#6a737d")
     (220 . "#22863a")
     (240 . "#005cc5")
     (260 . "#6f42c1")
     (280 . "#6a737d")
     (300 . "#005cc5")
     (320 . "#6a737d")
     (340 . "#d73a49")
     (360 . "#6a737d"))))
 '(vc-annotate-very-old-color "#6a737d")
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))


(put 'dired-find-alternate-file 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
