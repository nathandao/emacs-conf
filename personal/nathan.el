;;; nathan ---- Custom cosmatic stuff
;;; Commentary:
;;; Code:

;; notify
;;(require 'notify)
;;(setq notify-method 'notify-via-dbus)
;;(set-face-attribute 'highlight nil :background "#ebebeb")

(setq x-select-enable-primary 't)
(setq x-select-enable-clipboard 'nil)
(setq frame-tile-format "%b - Emacs")

;; Custom key-binding
(key-chord-define-global "SS" 'switch-window)
;;(key-chord-define-global "FF" 'new-frame)
(key-chord-define-global "LL" 'linum-mode)

;; Change line spacing
(setq-default line-spacing 5)
;; Load workgroups
;;(add-to-list 'load-path "~/.emacs.d/workgroups")
;;(require 'workgroups)
;;(workgroups-mode 1)
;;(setq wg-morph-on nil)
;;(wg-load "~/eworkg")

;; Load Desktop presets
;;(desktop-read)
;;(toggle-frame-fullscreen)

(eval-after-load "menu-bar" '(require 'menu-bar+))
(setq frame-title-format '((:eval default-directory)))

;; org-jira custom variables
(setq jiralib-url "http://exovecom.atlassian.net")
(setq jiralib-wsdl-descriptor-url "https://exovecom.atlassian.net/rpc/soap/jirasoapservice-v2?wsdl")

(require 'skype)
(setq skype--my-user-handle "nathan_daoo]")

(require 'skype)
(setq skype--my-user-handle "nathan_daoo")
(setq skype--com-handlers 'skype--com-handlers-py)

;; Jabber notify
;;(require 'notify)

(defun notify-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via notify.el"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify (format "(PM) %s"
                        (jabber-jid-displayname (jabber-jid-user from)))
                (format "%s: %s" (jabber-jid-resource from) text)))
    (notify (format "%s" (jabber-jid-displayname from))
            text)))

(add-hook 'jabber-alert-message-hooks 'notify-jabber-notify)

;;(provide 'nathan)

;;; nathan ends here
