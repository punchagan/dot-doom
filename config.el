  ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

  ;;; DONOT EDIT THIS FILE DIRECTLY
  ;;; Generated from doom.org using org-babel-tangle

  ;; Place your private configuration here! Remember, you do not need to run 'doom
  ;; sync' after modifying this file!

  ;; Some functionality uses this to identify you, e.g. GPG configuration, email
  ;; clients, file templates and snippets. It is optional.
  ;; (setq user-full-name "John Doe"
  ;;       user-mail-address "john@doe.com")

  ;; Doom exposes five (optional) variables for controlling fonts in Doom:
  ;;
  ;; - `doom-font' -- the primary font to use
  ;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
  ;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
  ;;   presentations or streaming.
  ;; - `doom-symbol-font' -- for symbols
  ;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
  ;;
  ;; See 'C-h v doom-font' for documentation and more examples of what they
  ;; accept. For example:
  ;;
  ;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
  ;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
  ;;
  ;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
  ;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
  ;; refresh your font settings. If Emacs still can't find your font, it likely
  ;; wasn't installed correctly. Font issues are rarely Doom issues!

  ;; There are two ways to load a theme. Both assume the theme is installed and
  ;; available. You can either set `doom-theme' or manually load a theme with the
  ;; `load-theme' function. This is the default:
  ;; (setq doom-theme 'doom-one)

  ;; This determines the style of line numbers in effect. If set to `nil', line
  ;; numbers are disabled. For relative line numbers, set this to `relative'.
  ;; (setq display-line-numbers-type t)

  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  ;; (setq org-directory "~/org/")

  ;; Whenever you reconfigure a package, make sure to wrap your config in an
  ;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
  ;;
  ;;   (after! PACKAGE
  ;;     (setq x y))
  ;;
  ;; The exceptions to this rule:
  ;;
  ;;   - Setting file/directory variables (like `org-directory')
  ;;   - Setting variables which explicitly tell you to set them before their
  ;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
  ;;   - Setting doom variables (which start with 'doom-' or '+').
  ;;
  ;; Here are some additional functions/macros that will help you configure Doom.
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
  ;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
  ;; etc).
  ;;
  ;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
  ;; they are implemented.

  (defun pc/tangle-doom-org (&optional arg)
    "Tangle the file to update doom config files."
    (interactive "P")
    (let* ((time (current-time))
           (org-babel-tangle-comment-format-beg "%source-name starts here"))
      (when current-prefix-arg
        ;; Make and load init.el
        (org-babel-tangle)
        ;; Acknowledgement
        (message
         "Tangled config.el,init.el,packages.el, … %.06f seconds."
         (float-time (time-since time))))))

  (setq user-full-name    "Puneeth Chaganti"
        user-mail-address "punchagan@muse-amuse.in")

  (pcase (system-name)
    ("haalbai" (setq pc/code-directory "~/code/"))
    ("chandrahara" (setq pc/code-directory "~/software/")))

  (after! auth-source
          (setq auth-sources '("~/.authinfo.gpg")))

  (defun pc/get-random-quote ()
    (require 'json)
    (let ((json-array-type 'list)
          (quotes-file (expand-file-name "quotes.json" user-emacs-directory)))
      (when (file-exists-p quotes-file)
        (let* ((quotes (json-read-file quotes-file))
               (n (random (length quotes)))
               (q (nth n quotes))
               (text (cdr (assoc 'body q)))
               (source (cdr (assoc 'source q))))
          (format "%s — %s" text source)))))

  (unless (boundp 'pc/quotes-timer)
    (setq pc/quotes-timer
          (run-with-idle-timer
           300
           'repeat-forever
           (lambda () (message (pc/get-random-quote))))))

  ;; No startup message
  (setq inhibit-startup-message t)

  (setq-default
   initial-scratch-message
   (format ";; Happy hacking, %s - Emacs ♥ you!\n\n" user-login-name))

  ;; No tool-bar, menu-bar and scroll-bar
  (tool-bar-mode   -1)
  (menu-bar-mode   -1)
  (scroll-bar-mode -1)

  ;; More prominent window divider
  (window-divider-mode 1)

  ;; Basic preferences (taken from purcell)
  (setq-default
   bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
   buffers-menu-max-size 30
   case-fold-search t
   column-number-mode t
   confirm-kill-emacs nil
   indent-tabs-mode nil
   create-lockfiles nil
   auto-save-default nil
   mouse-yank-at-point t
   save-interprogram-paste-before-kill t
   scroll-preserve-screen-position 'always
   set-mark-command-repeat-pop t
   tooltip-delay 1.5
   truncate-lines nil
   truncate-partial-width-windows nil)

  (add-hook 'after-init-hook 'delete-selection-mode)

  (add-hook 'after-init-hook 'global-auto-revert-mode)
  (setq global-auto-revert-non-file-buffers t
        auto-revert-verbose nil)

  (add-hook 'after-init-hook 'transient-mark-mode)

;; change all prompts to y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; Enable all ‘possibly confusing commands’ such as helpful but
;; initially-worrisome “narrow-to-region”, C-x n n.
(setq-default disabled-command-function nil)

  (set-default-coding-systems 'utf-8-unix)

  ;; Don't prompt to confirm theme safety. This avoids problems with
  ;; first-time startup on Emacs > 26.3.
  (setq custom-safe-themes t)

(setq doom-theme 'doom-solarized-dark)

  (when (boundp 'display-fill-column-indicator)
    (setq-default indicate-buffer-boundaries 'left)
    (setq-default display-fill-column-indicator-character ?│)
    (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode))

  (when (fboundp 'so-long-enable)
    (add-hook 'after-init-hook 'so-long-enable))

  (defun ffap-vlf ()
    "Find file at point with VLF."
    (interactive)
    (let ((file (ffap-file-at-point)))
      (unless (file-exists-p file)
        (error "File does not exist: %s" file))
      (vlf file)))

  ;; New location for backups.
  (setq backup-directory-alist
        `(("." . ,(expand-file-name "backups" user-emacs-directory))))

  ;; Silently delete execess backup versions
  (setq delete-old-versions t)

  ;; Only keep the last 3 backups of a file.
  (setq kept-old-versions 3)

  ;; Even version controlled files get to be backed up.
  (setq vc-make-backup-files t)

  ;; Use version numbers for backup files.
  (setq version-control t)

(add-hook 'before-save-hook 'whitespace-cleanup)

  (setq-default fill-column 79)

  (defun pc/screenshot-svg ()
    "Save a screenshot of the current frame as an SVG image.
  Saves to a temp file and puts the filename in the kill ring."
    (interactive)
    (let* ((filename (make-temp-file "Emacs" nil ".svg"))
           (data (x-export-frames nil 'svg)))
      (with-temp-file filename
        (insert data))
      (kill-new filename)
      (message filename)))

  (use-package! magit
    :bind
    ("C-x g" . magit-status-here)
    ("C-c B" . magit-blame)
    :custom
    ;; Show word diffs for current hunk
    (magit-diff-refine-hunk t)
    (magit-repository-directories `((,pc/code-directory . 3)
                                    ("~" . 0)
                                    ("~/.life-in-plain-text/" . 0)))
    ;; Do not ask about this variable when cloning.
    (magit-clone-set-remote.pushDefault t))

  ;; Incremental blame?
  (use-package! git-blamed
    :defer t)

  ;; Major mode for editing git configuration files
  (use-package! git-modes
    :defer t)

  ;; Highlight diffs
  (use-package! diff-hl
    :defer
    :config
    (global-diff-hl-mode))

  (use-package magit-todos
    :config
    (setq magit-todos-exclude-globs '("*.css.map")))

(which-function-mode)

  (use-package! projectile
    :custom
    (projectile-project-search-path `((,pc/code-directory . 4)))
    (projectile-indexing-method 'alien)
    (projectile-sort-order 'recently-active)
    :bind (:map projectile-mode-map
                ("C-c p" . projectile-command-map)))

  (use-package! ag
    :defer t)

  (setq js-indent-level 2)

  (defun pc/enable-minor-mode (my-pair)
    "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
    (if (buffer-file-name)
        (if (string-match (car my-pair) buffer-file-name)
            (funcall (cdr my-pair)))))

  (defun pc/disable-whitespace-cleanup ()
    "Set whitespace-style to nil locally."
    (interactive)
    (setq-local whitespace-style nil))

  (use-package! prettier-js
    :defer t
    :config
    (add-hook 'js-mode-hook 'prettier-js-mode)
    (add-hook 'js-mode-hook #'pc/disable-whitespace-cleanup)
    (add-hook 'js-jsx-mode-hook 'prettier-js-mode)
    (add-hook 'js-jsx-mode-hook #'pc/disable-whitespace-cleanup)
    (add-hook 'js2-mode-hook 'prettier-js-mode)
    (add-hook 'js2-mode-hook #'pc/disable-whitespace-cleanup)
    (add-hook 'typescript-mode-hook 'prettier-js-mode)
    (add-hook 'typescript-mode-hook #'pc/disable-whitespace-cleanup)
    (add-hook 'web-mode-hook #'(lambda ()
                                 (pc/enable-minor-mode
                                  '("\\.jsx?\\'" . prettier-js-mode)))))

  (use-package! typescript-mode
    :defer t)

(use-package! ocaml-eglot
  :ensure t
  :after tuareg
  :hook
  (tuareg-mode . ocaml-eglot)
  (ocaml-eglot . eglot-ensure))

(use-package! reason-mode
  :hook (reason-mode . setup-reason-mode)

  :config
  (defun setup-reason-mode ()
    "Setup function for Reason mode."
    ;; Enable merlin-mode for OCaml/ReasonML integration
    (merlin-mode)
    ;; Ensure that refmt is run before saving Reason files
    (add-hook 'before-save-hook #'refmt-before-save nil 'local)))

(use-package! dune-format
  :hook (dune-mode . dune-format-on-save-mode))

(use-package! merlin
  :hook (tuareg-mode . merlin-mode))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(use-package! okra
  :custom
  (okra-tarides-admin-repo "~/code/segfault/admin")
  (okra-username "punchagan")
  (okra-team-members '("Alizter" "ElectreAAS" "art-w" "Leonidas-from-XIV" "punchagan" "shonfeder" "Sudha247")))

(use-package! org
  :bind (("C-c c" . org-capture)
         (:map org-mode-map
               ("C-c C-q" . counsel-org-tag))))

(setq org-directory "~/.life-in-plain-text/src/")
(setq org-return-follows-link t)
(setq org-insert-heading-respect-content nil)

  (defun pc/html2org-clipboard ()
    "Convert clipboard contents from HTML to Org and then paste (yank)."
    (interactive)
    (kill-new (shell-command-to-string "xclip -o -t text/html | pandoc -f html -t org"))
    (yank))

  (setq org-complete-tags-always-offer-all-agenda-tags t)

  (setq org-agenda-files
        (expand-file-name "agenda-files.org" org-directory))

  ;; Enable a bunch of things, since we are going to use them, anyway..
  (require 'org-clock)
  (require 'org-agenda)
  (require 'org-capture)

  (setq org-enforce-todo-dependencies t)

  ;; Add a note whenever a task's deadline or scheduled date is changed.
  (setq org-log-redeadline 'time)
  (setq org-log-reschedule 'time)

  ;; How many days early a deadline item will begin showing up in your agenda list.
  (setq org-deadline-warning-days 7)

  ;; In the agenda view, days that have no associated tasks will still have a line showing the date.
  (setq org-agenda-show-all-dates t)

  ;; Scheduled items marked as complete will not show up in your agenda view.
  (setq org-agenda-skip-scheduled-if-done t)
  (setq org-agenda-skip-deadline-if-done t)

(use-package! org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode 1))

  (defun pc/agenda-skip-unless-needs-review ()
    "Skip the entry unless it's a DRAFT, or a TODO with no date."
    (let ((keyword (org-get-todo-state)))
      (if (or (equal keyword "DRAFT")
              ;; Should this be only TODO?
              (and (equal keyword "TODO")
                   (not (org-entry-get nil "SCHEDULED"))
                   (not (org-entry-get nil "DEADLINE"))))
          nil
        (save-excursion (or (outline-next-heading) (point-max))))))

  (defun pc/agenda-cmp-drafts-first (a b)
    "Sort DRAFT entries before everything else; no preference otherwise."
    (let ((a-draft (equal (get-text-property 0 'todo-state a) "DRAFT"))
          (b-draft (equal (get-text-property 0 'todo-state b) "DRAFT")))
      (cond ((and a-draft (not b-draft)) -1)
            ((and b-draft (not a-draft)) 1))))

  (setq org-agenda-custom-commands
        '(("a" "Daily driver"
           ((agenda ""
                    ((org-agenda-span 'day)
                     (org-super-agenda-groups
                      '((:name "Habits" :habit t)
                        (:name "Important" :priority "A")
                        ;; A missed deadline needs urgent action; a missed
                        ;; schedule just needs a new date -- kept separate.
                        (:name "Overdue" :deadline past)
                        (:name "Reschedule" :scheduled past)
                        (:name "Upcoming" :deadline future :scheduled future)
                        ;; Catch-all so today's ordinary items get a real
                        ;; label instead of falling into the unnamed
                        ;; default bucket. Matches John's "Tasks" group.
                        (:name "Tasks" :not (:habit t))))))
            (tags "LEVEL>0"
                  ((org-agenda-overriding-header "Needs review")
                   (org-agenda-skip-function
                    #'pc/agenda-skip-unless-needs-review)
                   (org-agenda-cmp-user-defined #'pc/agenda-cmp-drafts-first)
                   (org-agenda-sorting-strategy '(user-defined-up))))))))

  (add-to-list 'org-capture-templates
               '("j"
                 "Journal"
                 entry
                 (file+olp+datetree pc/current-journal-file)
                 "* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n%a\n"))

(defun pc/journal (&optional mode)
  "Open a new frame for journaling.

  If MODE is 'journal opens to the current day in the journal, and
  creates a new day entry if not already present.

  If MODE is 'clock jumps to the currently clocked entry, or prompt
  one from the last few."
  (interactive)
  (pc/select-window-by-name "What are you doing?")
  ;; Display agenda...
  (let ((org-agenda-span 'day))
    (org-agenda nil "a")
    (org-agenda-log-mode t)
    (org-agenda-goto-today))
  (delete-other-windows)
  (split-window-right)
  ;; Perform next action based on mode
  (cond
   ;; Show a capture buffer for a new journal entry
   ((equal mode 'journal)
    (org-capture nil "j"))
   ;; Show the current clock entry, if there's one. Otherwise prompt!
   ((equal mode 'clock)
    (org-clock-goto (not (org-clocking-p)))
    (org-narrow-to-subtree)
    (outline-show-subtree)
    (goto-char (buffer-end 1)))
   ;; Show today in the journal
   (t
    (org-capture-goto-target "j")
    (org-narrow-to-subtree))))

(defun pc/get-frame-by-name (title)
  "Return frame with the given TITLE.
  If no such frame exists, creates a new frame."
  (or
   (car (filtered-frame-list
         (lambda (f)
           (string= title (cdr (assq 'title (frame-parameters f)))))))
   (make-frame
    `((title . ,title)
      (fullscreen . maximized)))))

(defun pc/select-window-by-name (title)
  "Raise the window with the specified TITLE."
  (let ((frame (pc/get-frame-by-name title)))
    (select-frame frame)
    (select-frame-set-input-focus (selected-frame))))

  (defun pc/work-today ()
    "Create a journal entry with today's work tasks"
    (interactive)
    (let* ((date (format-time-string "%Y-%m-%d"))
           (title "Notes for Today")
           (org-last-tags-completion-table
            (org-global-tags-completion-table
             (org-agenda-files)))
           (tags
            (org-completing-read "Tags:" #'org-tags-completion-function))
           (headlines (org-ql-query
                        :select '(org-get-heading t t t t)
                        :from (org-agenda-files)
                        :where `(and (clocked :on ,date) (tags tags)))))

      ;; Exit early if no matching headlines
      (when (not headlines)
        (user-error "No matching headlines"))

      (when (org-clocking-p)
        (org-clock-out))
      (pc/journal)
      (end-of-buffer)
      (org-insert-heading-after-current)
      (insert title)
      (org-set-tags tags)
      (end-of-buffer)
      (mapc (lambda (item) (insert (format "- %s\n" (org-no-properties item)))) headlines)))

  (defun pc/current-task-to-status ()
    (interactive)
    (if (fboundp 'org-clocking-p)
        (if (org-clocking-p)
            (call-process "dconf" nil nil nil "write"
                          "/org/gnome/shell/extensions/simple-message/message"
                          (concat "'" (org-clock-get-clock-string) "'"))
          (call-process "dconf" nil nil nil "write"
                        "/org/gnome/shell/extensions/simple-message/message"
                        "'No active clock'"))))
  (run-with-timer 0 60 #'pc/current-task-to-status)
  (add-hook 'org-clock-in-hook #'pc/current-task-to-status)
  (add-hook 'org-clock-out-hook #'pc/current-task-to-status)
  (add-hook 'org-clock-cancel-hook #'pc/current-task-to-status)
  (add-hook 'org-clock-goto-hook #'pc/current-task-to-status)

(use-package! zulip-helpers)

  (defun pc/zulip-to-org (begin end)
    (interactive "r")
    (when (use-region-p)
      (shell-command-on-region begin end "pandoc -r markdown -w org" t t)))

  (require 'org-protocol)

  (add-to-list
     'org-capture-templates
     '("p"
       "Protocol"
       entry
       (file+olp+datetree pc/current-journal-file)
       "* %:description\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n%:link\n\n#+begin_quote\n%i\n#+end_quote\n"))

  (require 'org-tempo)

  (setq org-babel-load-languages '((emacs-lisp . t)
                                   (python . t)
                                   (sh . t)))

  (require 'ob-emacs-lisp)
  (require 'ob-python)

(use-package! ox-reveal
  :after org)

(use-package! ox-gist)

  (use-package! markdown-mode :defer t)

  (use-package! markdown-toc :defer t)

(use-package! ox-hugo
  :after ox)

(defun org-hugo-new-subtree-post-capture-template ()
  "Returns `org-capture' template string for new Hugo post."
  (let* ((date (format-time-string (org-time-stamp-format :long :inactive) (org-current-time)))
         (title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
         (fname (org-hugo-slug title)))
    (mapconcat #'identity
               `(
                 ,(concat "* DRAFT " title " :noexport:")
                 ":PROPERTIES:"
                 ,(concat ":EXPORT_FILE_NAME: " fname)
                 ,(concat ":EXPORT_DATE: " date) ;Enter current date and time
                 ":EXPORT_DESCRIPTION:"
                 ":EXPORT_HUGO_CUSTOM_FRONT_MATTER:"
                 ":END:"
                 "- [ ] Add an image and maybe even og:image stuff"
                 "%?\n")          ;Place the cursor here finally
               "\n")))

(add-to-list 'org-capture-templates
             '("b"
               "Blog post for punchagan.muse-amuse.in"
               entry
               (file "draft-blog-posts.org")
               (function org-hugo-new-subtree-post-capture-template)
               :prepend t))

(defun pc/set-export-file-name-from-heading ()
  "Set EXPORT_FILE_NAME to org-hugo-slug of the current heading title."
  (interactive)
  (let ((heading (org-get-heading t t t t))) ; Get the heading title with `TODO`, priority, and tags stripped
    (if heading
        (let ((slug (org-hugo-slug heading)))
          (org-set-property "EXPORT_FILE_NAME" slug)
          (message "EXPORT_FILE_NAME set to '%s'" slug))
      (message "No heading found at point."))))

(org-link-set-parameters "hugo" :export #'pc/org-hugo-link-export-to-md)

(defun pc/org-hugo-link-export-to-md (path desc backend &optional info)
  "Export a link to a Hugo blog link in markdown format."
  (message (format "path: %s, desc: %s, backend: %s" path desc backend))
  (cond
   ((eq backend 'md)
    (if (equal org-export-current-backend 'hugo)
        (format "[%s]({{< relref \"%s\" >}})" desc path)
      (error "Cannot export Hugo link to non-Hugo backend")))
   (t (error "Cannot export Hugo link to non-Hugo backend"))))

(defun pc/get-blog-headline-links (filename)
  "Return a list of cons cells of headline text and EXPORT_FILE_NAME links in FILENAME."
  (with-temp-buffer
    (insert-file-contents filename)
    (save-restriction
      (widen)
      (seq-filter
       #'identity
       (org-element-map (org-element-parse-buffer 'headline) 'headline
         (lambda (hl)
           (let ((export-file-name (org-element-property :EXPORT_FILE_NAME hl))
                 (headline-text (org-element-property :raw-value hl)))
             (when export-file-name
               (cons (format "%s (%s)" headline-text export-file-name)
                     (concat "hugo:" export-file-name))))))))))

(defun pc/insert-hugo-cross-link ()
  "Insert a link with the 'hugo:' protocol.

The link completion will include all headlines with an
EXPORT_FILE_NAME tag. If a region is selected, replace it with the link."
  (interactive)
  (let* ((blog-files
          (mapcar
           (lambda (x) (expand-file-name x org-directory))
           '("draft-blog-posts.org" "blog-posts.org")))
         (headline-links
          (apply 'append (mapcar 'pc/get-blog-headline-links blog-files)))
         ;; Prompt the user to select a link
         (selected-link (completing-read "Select link: " (mapcar 'car headline-links))))
    (when selected-link
      (let ((link (cdr (assoc selected-link headline-links)))
            (description (if (use-region-p)
                             (buffer-substring-no-properties (region-beginning) (region-end))
                           (read-string "Description: "))))
        (if (use-region-p)
            (delete-region (region-beginning) (region-end)))
        (insert (format "[[%s][%s]]" link description))))))

(defun pc/entry-date-at-point ()
  "Return the day number (see `time-to-days') for the entry at point.
Prefers the :CREATED: property. Falls back to the nearest ancestor
heading that looks like a datetree day heading (\"YYYY-MM-DD ...\"),
since journal entries filed under a datetree don't carry their own
:CREATED: property."
  (or (let ((created (org-entry-get nil "CREATED" t)))
        (and created (time-to-days (org-time-string-to-time created))))
      (save-excursion
        (let (date)
          (while (and (not date) (org-up-heading-safe))
            (let ((heading (org-get-heading t t t t)))
              (when (string-match "^\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)" heading)
                (setq date (time-to-days
                            (org-time-string-to-time (match-string 1 heading)))))))
          date))))

(defun pc/strip-property-drawer (entry)
  "Return ENTRY (a subtree's text) with its own property drawer, if
any, removed entirely."
  (with-temp-buffer
    (org-mode)
    (insert entry)
    (goto-char (point-min))
    (forward-line 1)
    (when (looking-at org-property-drawer-re)
      (delete-region (point) (min (point-max) (1+ (match-end 0)))))
    (buffer-string)))

(defun pc/collect-tagged-subtrees (tag start-day end-day)
  "Return the full text of every entry tagged TAG across
`org-agenda-files' whose date (`pc/entry-date-at-point') falls
between START-DAY and END-DAY, inclusive. Entries are left in place;
this only reads and copies. Each entry's own property drawer is
stripped from the copy."
  (let (entries)
    (org-map-entries
     (lambda ()
       (let ((date (pc/entry-date-at-point)))
         (when (and date (<= start-day date end-day))
           (push (pc/strip-property-drawer
                  (buffer-substring-no-properties
                   (point) (save-excursion (org-end-of-subtree t t) (point))))
                 entries))))
     tag 'agenda)
    (nreverse entries)))

(defun pc/create-weekly (tag start end)
  "Collect every entry tagged TAG across `org-agenda-files' dated
between START and END (inclusive) and drop them, as level-2 child
subtrees, into a new draft Hugo post created via the \"b\" capture
template. Sources are left untouched; entries are copied, not
refiled.

Interactively prompts for TAG, defaulting the range to the last 7
days."
  (interactive
   (list (read-string "Tag: ")
         (org-read-date nil t nil "Start date"
                         (time-subtract (current-time) (days-to-time 7)))
         (org-read-date nil t nil "End date")))
  (let* ((start-day (time-to-days start))
         (end-day (time-to-days end))
         (entries (pc/collect-tagged-subtrees tag start-day end-day)))
    (unless entries
      (user-error "No entries tagged :%s: between %s and %s" tag
                  (format-time-string "%Y-%m-%d" start)
                  (format-time-string "%Y-%m-%d" end)))
    (org-capture nil "b")
    (org-entry-put (point) "EXPORT_OPTIONS" "H:0 tags:nil")
    (dolist (entry entries)
      (org-paste-subtree 2 entry))
    (org-capture-finalize)))

(defun pc/journal-file-for-time (time)
  "Return the journal file that should hold an entry dated TIME.
Every year's entries go to their own journal-<year>.org."
  (expand-file-name
   (format-time-string "journal-%Y.org" time)
   org-directory))

(defun pc/current-journal-file ()
  "Return the journal file for the current year, for use as an
`org-capture-templates' file target."
  (pc/journal-file-for-time (current-time)))

(defun pc/org-refile-subtree-to-journal ()
  "Refile a subtree to the journal datetree matching its CREATED timestamp.
Entries are filed to journal-<year>.org matching their year."
  (interactive)
  (let ((entry-date (org-entry-get nil "CREATED" t)))
    (when entry-date
      (let* ((time (apply #'encode-time (org-parse-time-string entry-date)))
             (journal-file (pc/journal-file-for-time time))
             (journal-buf (find-file-noselect journal-file)))
        (org-cut-subtree)
        ;; Set the continuation position when this function is called from org-map-entries
        (setq org-map-continue-from (point))
        (save-mark-and-excursion
          (set-buffer journal-buf)
          (org-datetree-find-date-create
           (calendar-gregorian-from-absolute (time-to-days time)))
          (org-narrow-to-subtree)
          (org-show-subtree)
          (org-end-of-subtree t)
          (newline)
          (goto-char (point-max))
          (org-paste-subtree 4)
          (widen)
          (save-buffer))))))

  (defun pc/org-refile-inbox ()
    (interactive)
    (require 'dash)
    (require 's)
    (org-map-entries
     #'pc/org-refile-subtree-to-journal
     nil
     (-filter (lambda (x) (s-contains? "Inbox.org" x)) (org-agenda-files))))

(require 'org-crypt)

(after! org
  (require 'org-bookmark-heading))

(use-package! elfeed-web)

(use-package! elfeed-goodies
  :bind
  (:map elfeed-show-mode-map
        ("q" . elfeed-goodies/delete-pane)))

(defun pc/set-elfeed-feeds ()
  "Set elfeed-feeds from the org file."
  (interactive)
  (rmh-elfeed-org-process rmh-elfeed-org-files rmh-elfeed-org-tree-id))

(defvar pc/elfeed-db-save-timer nil
  "Timer for debounced elfeed database saves.")

(defun pc/elfeed-db-save-and-backup ()
  "Save the elfeed database and commit to git."
  (when (and (boundp 'elfeed-db) elfeed-db)
    (elfeed-db-save)
    (let ((default-directory elfeed-db-directory))
      (when (file-exists-p ".git")
        (call-process "git" nil "*elfeed-db-backup*" nil "add" "-A")
        (call-process "git" nil "*elfeed-db-backup*" nil "commit" "-m" "auto-backup")
        (call-process "git" nil "*elfeed-db-backup*" nil "push" "origin" "main")))))

(defun pc/elfeed-db-save-soon ()
  "Schedule a database save after 10 seconds of idle."
  (interactive)
  (when pc/elfeed-db-save-timer
    (cancel-timer pc/elfeed-db-save-timer))
  (setq pc/elfeed-db-save-timer
        (run-with-idle-timer 10 nil #'pc/elfeed-db-save-and-backup)))

;; Save and backup when tags change (covers elfeed-web usage)
(add-hook 'elfeed-tag-hooks   (lambda (&rest _) (pc/elfeed-db-save-soon)))
(add-hook 'elfeed-untag-hooks (lambda (&rest _) (pc/elfeed-db-save-soon)))

;; Save and backup when new entries are added
(add-hook 'elfeed-db-update-hook #'pc/elfeed-db-save-soon)

(use-package! org-contacts
  :after org)

(add-to-list 'auto-mode-alist '("\\.org\\.txt\\'" . org-mode))

(after! org
  (setq org-contacts-files
        `(,(expand-file-name "contacts.org.txt" org-directory))))

(use-package! howdy
  :custom
  (howdy-max-contacts 0)
  :bind
  (:map org-agenda-mode-map
        ("C-c H" . howdy-agenda-contacted)
        ("C-c U" . howdy-agenda-untrack-contact)))

(use-package! org-social
  :after org
  :custom
  ;; Required: Set the path to your social feed file
  (org-social-file (expand-file-name "social.org" org-directory))

  ;; Required: Configure Org Social Relay server
  ;; See public relay list: https://github.com/tanrax/org-social/blob/main/org-social-relay-list.txt
  (org-social-relay "https://org-social-relay.andros.dev/")

  ;; Required: Set your public social.org URL (where others can access your feed)
  (org-social-my-public-url "https://muse-amuse.in/~punchagan/social.org"))

(use-package! org-novelist
  :custom
    (org-novelist-author "Puneeth Chaganti")  ; The default author name to use when exporting a story. Each story can also override this setting
    (org-novelist-author-email "punchagan@muse-amuse.in")  ; The default author contact email to use when exporting a story. Each story can also override this setting
    (org-novelist-automatic-referencing-p nil)  ; Set this variable to 't' if you want Org Novelist to always keep note links up to date. This may slow down some systems when operating on complex stories. It defaults to 'nil' when not set
  :bind (("C-c n n s" . org-novelist-new-story)
          :map org-novelist-mode-map
          ("C-c n n c" . org-novelist-new-chapter)
          ("C-c n d c" . org-novelist-destroy-chapter)
          ("C-c n r c" . org-novelist-rename-chapter)
          ("C-c n n a" . org-novelist-new-character)
          ("C-c n d a" . org-novelist-destroy-character)
          ("C-c n r a" . org-novelist-rename-character)
          ("C-c n n p" . org-novelist-new-prop)
          ("C-c n d p" . org-novelist-destroy-prop)
          ("C-c n r p" . org-novelist-rename-prop)
          ("C-c n n l" . org-novelist-new-place)
          ("C-c n d l" . org-novelist-destroy-place)
          ("C-c n r l" . org-novelist-rename-place)
          ("C-c n u"   . org-novelist-update-references)
          ("C-c n r s" . org-novelist-rename-story)
          ("C-c n e"   . org-novelist-export-story)
          ("C-c n l l" . org-novelist-link-to-story)
          ("C-c n l u" . org-novelist-unlink-from-story)
          ("C-c n t"   . org-novelist-toggle-automatic-referencing)))
