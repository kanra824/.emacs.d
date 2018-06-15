;; utf-8
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; タブにスペースを使用する
;;(setq indent-line-function 'tab-to-tab-stop)
(setq default-tab-width 4)
;(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 列数を表示する
(column-number-mode t)

;; 行数を表示する
(global-linum-mode t)


;; 対応する括弧を光らせる
(show-paren-mode 1)

;; ウィンドウ内に収まらないときだけ、カッコ内も光らせる
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "grey")
(set-face-foreground 'show-paren-match-face "black")

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; シフト＋矢印で範囲選択
(setq pc-select-selection-keys-only t)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;;; dired設定
(require 'dired-x)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; beep音を消す
(defun my-bell-function ()
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; カーソル点滅オフ
(blink-cursor-mode 0)



(setq package-user-dir "~/.emacs.d/elisp/elpa/")
(setq package-archives
      '(("gnu"   . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org"   . "http://orgmode.org/elpa/")))
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents))
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

;; smartparens
(require 'smartparens)
(smartparens-global-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Tuareg
;;(setenv "PATH" (concat "/usr/bin" ":" (getenv "PATH")))
;;(setq tuareg-interactive-program "/usr/bin/ocaml")

(setq load-path (cons "~/.emacs.d/elisp/elpa/tuareg-mode" load-path))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'run-ocaml "tuareg" "startup a Caml toplevel" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
                                  "Configuration of imenu for tuareg" t)

(add-hook 'tuareg-mode-hook
(function (lambda ()
  (setq tuareg-in-indent 0)
  (setq tuareg-let-always-indent t)
  (setq tuareg-let-indent tuareg-default-indent)
  (setq tuareg-with-indent 0)
  (setq tuareg-function-indent 0)
  (setq tuareg-fun-indent 0)
  (setq tuareg-parser-indent 0)
  (setq tuareg-match-indent 0)
  (setq tuareg-begin-indent tuareg-default-indent)
  (setq tuareg-parse-indent tuareg-default-indent); .mll
  (setq tuareg-rule-indent  tuareg-default-indent)

  (setq tuareg-font-lock-symbols nil)
      )))



(setq auto-mode-alist 
    (append '(
        ("\\.C$"    . c++-mode)
        ("\\.cc$"   . c++-mode)
        ("\\.cpp$"  . c++-mode)
        ("\\.hh$"   . c++-mode)
        ("\\.c$"    . c-mode)
        ("\\.h$"    . c-mode)
        ("\\.m$"    . objc-mode)
        ("\\.java$" . java-mode)
        ("\\.pl$"   . cperl-mode)
        ("\\.perl$" . cperl-mode)
        ("\\.tex$"  . yatex-mode)
        ("\\.sty$"  . yatex-mode)
        ("\\.cls$"  . yatex-mode)
        ("\\.clo$"  . yatex-mode)
        ("\\.dtx$"  . yatex-mode)
        ("\\.fdd$"  . yatex-mode)
        ("\\.ins$"  . yatex-mode)
        ("\\.s?html?$" . html-helper-mode)
        ("\\.php$" . html-helper-mode)
        ("\\.jsp$" . html-helper-mode)
        ("\\.css$"  . css-mode)
        ("\\.js$"   . java-mode)
        ("\\.el$"   . emacs-lisp-mode)
	  ("\\.lisp$" . lisp-mode)
	  ("\\.ml[ilyp]?$" . tuareg-mode) ;<-この行を追加
    ) auto-mode-alist)
    )

(add-to-list 'load-path "~/.emacs.d/elisp/elpa/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;;; racerやrustfmt、コンパイラにパスを通す
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
;;; rust-modeでrust-format-on-saveをtにすると自動でrustfmtが走る
(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))
;;; rustのファイルを編集するときにracerとflycheckを起動する
(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)
                            (flycheck-rust-setup)))
;;; racerのeldocサポートを使う
(add-hook 'racer-mode-hook #'eldoc-mode)
;;; racerの補完サポートを使う
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode)
                             ;;; この辺の設定はお好みで
                             (set (make-variable-buffer-local 'company-idle-delay) 0.1)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 0)))
