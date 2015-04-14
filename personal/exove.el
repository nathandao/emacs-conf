;;; exove.el --- Custom Exove tasks
;;; Commentary:
;;; License:
;;; Code:

(require 'request)
;;(require 'notify)

;; Load confidential exove info
(add-to-list 'load-path "~/exoveconf")
(load "exoveconf")

;; Insert a task
(defun exove-task (task start end desc log-inside)
  (interactive
   (list (completing-read "Task name: " exove-task-list nil t "")
         (read-string "Start: " (format-time-string "%Y-%m-%d %H:%M"))
         (read-string "End: " (format-time-string "%H:%M"))
         (read-string "Description: " "")
         (read-string "Insert entry to inside? [y/n] [default n]: " "")))
  (let ((task-entry (concat (format "%s;" task)
                      (format "%s;" start)
                      (format "%s;" end)
                      (format "%s" desc))))
    (insert (concat (format "| %s |" start)
                    (format " %s |" end)
                    (format " %s |" task)
                    (format " %s |" desc)
                    (format " %s |" task-entry) "\n"))
    (cond ((equal log-inside "y")
           (exove-curl task-entry))
          (t
           (exove-fortune)
           (notify "Exove Inside" "Entry only added to text file")))))

;; Open the hour file
(defun exove-view ()
  (interactive)
  (find-file "~/Documents/hours.org"))

;; Custom curl call
(defun exove-curl (task-entry)
  (interactive)
  (let* ((exove-buffer (get-buffer-create "*exove*"))
         (exove-curl-cmd (concat curl-cmd " -F 'data=" task-entry "'"))
         (result (call-process-shell-command exove-curl-cmd nil exove-buffer t))
         (output (with-current-buffer exove-buffer (buffer-string))))
    (cond ((zerop result)
           (exove-fortune))
          (t
           (message nil)
           (split-window-vertically)
           (set-window-buffer (next-window) exove-buffer)))))

;; Fortune API url
(defvar fortune-url "http://fortunecookieapi.com/v1/fortunes")

;; Collect fortune cookies
(defun exove-fortune ()
  (interactive)
  (let* ((page (+ 1 (random 30)))
         (limit (+ 4 (random 10)))
         (skip (+ 1 (random 30)))
         (url-request-method "GET")
         (arg-stuff (concat "?limit=" (number-to-string limit)
                            "&page=" (number-to-string page)
                            "&skip=" (number-to-string skip))))
      (url-retrieve (concat fortune-url arg-stuff)
                    (lambda (status)
                      (goto-char url-http-end-of-headers)
                      (let ((result (json-read)))
                        (notify "Genghis Khan once said..." (cdr (assoc 'message (elt result 1)))))))))

;; Insert current date timestamp
(defun exove-today ()
  (interactive)
  (insert (format-time-string "%a %d-%m-%Y")))

;; Insert table header
(defun exove-hour-header ()
  (interactive)
  (insert "| Start | End | Task | Description | Log |"))

;;(provide 'exove)
;;; exove.el ends here
