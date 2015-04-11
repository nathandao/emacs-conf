;;; mu4econf --- specific mu4e conf
;;
;;; Commentary:
;; Mu4e configurations
;;
;;; Code:

;;----------------------------------------------------------
;; ---- BEGIN Email client ----
;;----------------------------------------------------------
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-drafts-folder "/GuyNathan/drafts")
(setq mu4e-user-mail-address-list (list "nathan@guynathan.com" "nathan@exove.fi"))
(setq message-kill-buffer-on-exit t)
(setq mu4e-mu-binary "/usr/local/bin/mu")

;; Use fancy chars
(setq mu4e-use-fancy-chars t)

;; Shortcuts
(setq mu4e-maildir-shortcuts
      '(("/Exove/inbox" . ?e)
        ("/GuyNathan/inbox" . ?g)))

;; Smart refile locations
(setq mu4e-refile-folder
      (lambda (msg)
        (cond
         ;; messages sent directly to me go to /archive
         ;; also 'mu4e-user-mail-address-regexp' can be used
         ((mu4e-message-contact-field-matches msg :to "nathan@guynathan.com")
          "/GuyNathan/archive")
         ((mu4e-message-contact-field-matches msg :to "nathan@exove.fi")
          "/Exove/archive")
         ;; everything else goes to /archive
         ;; important to have a catch-all at the end!
         (t  "/Gmail/archive"))))

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; Try to display images in mu4e
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)

;; sending mail
(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/local/bin/msmtp"
      user-full-name "Nathan Dao")

(setq mu4e-confirm-quit nil
      mu4e-headers-date-format "%d/%b/%Y %H:%M" ; date format
      mu4e-html2text-command "html2text -utf8 -width 72"
      )

(setq message-kill-buffer-on-exit t)

;; Borrowed from http://ionrock.org/emacs-email-and-mu.html
;; Choose account label to feed msmtp -a option based on From header
;; in Message buffer; This function must be added to
;; message-send-mail-hook for on-the-fly change of From address before
;; sending message since message-send-mail-hook is processed right
;; before sending message.
;;(defun choose-msmtp-account ()
;;  (if (message-mail-p)
;;      (save-excursion
;;        (let*
;;            ((from (save-restriction
;;                     (message-narrow-to-headers)
;;                     (message-fetch-field "from")))
;;             (account
;;              (cond
;;               ((string-match "nathan@guynathan.com" from) "gmail")
;;               ((string-match "nathan@exove.fi" from) "exove"))))
;;          (setq message-sendmail-extra-arguments (list '"-a" account))))))

(setq message-sendmail-envelope-from 'header)

;;(add-hook 'message-send-mail-hook 'choose-msmtp-account)

;;(add-to-list 'mu4e-bookmarks
;;             '("maildir:/Exove/inbox flag:unread" "Business as usual?" ?b))
;;(add-to-list 'mu4e-bookmarks
;;             '("maildir:/GuyNathan/inbox flag:unread" "Yo, it's all personal. Biatch" ?m))


(add-hook 'mu4e-compose-pre-hook
          (defun my-set-from-address ()
            (let ((msg mu4e-compose-parent-message)) ;; msg is shorter...
              (if msg
                  (setq user-mail-address
                        (cond
                         ((mu4e-message-contact-field-matches msg :to "nathan@guynathan.com")
                          "nathan@guynathan.com")
                         ((mu4e-message-contact-field-matches msg :to "nathan@exove.fi")
                          "nathan@exove.fi")
                         (t "nathan@guynathan.com")))))))


;; Use os not
;;(defun notify-mu4e-notify (from buf text proposed-alert)
;;  "(mu4e.el hook) Notify of new Mu4e chat messages via notify.el"
;;  (when (or mu4e-message-alert-same-buffer
;;            (not (memq (selected-window) (get-buffer-window-list buf))))
;;    (if (mu4e-muc-sender-p from)
;;        (notify (format "(PM) %s"
;;                        (mu4e-jid-displayname (mu4e-jid-user from)))
;;                (format "%s: %s" (mu4e-jid-resource from) text)))
;;    (notify (format "%s" (mu4e-jid-displayname from))
;;            text)))
;;
;;(add-hook 'mu4e-alert-message-hooks 'notify-mu4e-notify)


;; Support attachments
(require 'gnus-dired)
;; make the gnus-dired-mail-buffers function also work on
; message-mode derived modes, such as mu4e-compose-modes
(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
        (set-buffer buffer)
        (when (and (derived-mode-p 'message-mode)
                   (null message-sent-message-via))
          (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'mu4e-user-agent)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)
;;----------------------------------------------------------
;; ---- END Email client ----
;;----------------------------------------------------------
