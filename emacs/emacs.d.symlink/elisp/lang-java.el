;; ;;(require 'lsp-java)
;; (add-hook 'java-mode-hook #'lsp)

;; ;(use-package projectile)
;; ;(use-package flycheck)
;; ;(use-package yasnippet :config (yas-global-mode))
;; (use-package lsp-mode :hook ((lsp-mode . lsp-enable-which-key-integration))
;;   :config (setq lsp-completion-enable-additional-text-edit nil))
;; (use-package hydra)
;; (use-package company)
;; (use-package lsp-ui)
;; (use-package which-key :config (which-key-mode))
;; (use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))
;; (use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
;; (use-package dap-java :ensure nil)
;; (use-package helm-lsp)
;; ;(use-package helm
;; ;  :config (helm-mode))
;; ;(use-package lsp-treemacs)

;; ;;(require 'lsp-java-boot)
;; (add-hook 'java-mode-hook #'lsp)

;; ;; to enable the lenses
;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
(use-package helm-lsp
  :ensure t
  :after (lsp-mode)
  :commands (helm-lsp-workspace-symbol)
  :init (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))

(use-package lsp-mode
  :ensure t
  :hook (
	 (lsp-mode . lsp-enable-which-key-integration)
	 (java-mode . #'lsp-deferred)
	 )
  :init (setq
	 lsp-keymap-prefix "C-c l"              ; this is for which-key integration documentation, need to use lsp-mode-map
	 lsp-enable-file-watchers nil
	 read-process-output-max (* 1024 1024)  ; 1 mb
	 lsp-completion-provider :capf
	 lsp-idle-delay 0.500
	 )
  :config
  (setq lsp-intelephense-multi-root nil) ; don't scan unnecessary projects
  (with-eval-after-load 'lsp-intelephense
    (setf (lsp--client-multi-root (gethash 'iph lsp-clients)) nil))
  (define-key lsp-mode-map (kbd "C-c l") lsp-command-map)
  )

(use-package lsp-java
  :ensure t
  :config (add-hook 'java-mode-hook 'lsp)
  :init
  (setq lsp-java-java-path "C:/Program Files/Java/jdk1.8.0_202/bin/java.exe")
  )

(setq lsp-java-configuration-runtimes '[(:name "JavaSE-1.8"
					       :path "c:/Program Files/Java/jdk1.8.0_202")])

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references))
  :init (setq lsp-ui-doc-delay 1.5
	      lsp-ui-doc-position 'bottom
	      lsp-ui-doc-max-width 100
))

(use-package dap-mode
  :ensure t
  :after (lsp-mode)
  :functions dap-hydra/nil
  :config
  (require 'dap-java)
  :bind (:map lsp-mode-map
         ("<f5>" . dap-debug)
         ("M-<f5>" . dap-hydra))
  :hook ((dap-mode . dap-ui-mode)
    (dap-session-created . (lambda (&_rest) (dap-hydra)))
    (dap-terminated . (lambda (&_rest) (dap-hydra/nil)))))

(use-package dap-java :ensure nil)

(use-package company :ensure t)

(provide 'lang-java)
