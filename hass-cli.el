;;; hass-cli.el --- Use hass-cli inside Emacs. -*- lexical-binding: t -*-

;; Copyright (C) 2021 Claes Hallström

;; Author: Claes Hallström <hallstrom.claes@gmail.com>
;; Created: 11 July 2021
;; Version 0.1
;; Homepage: https://github.com/claha/hass-cli.el

;;; Commentary:

;;; Code:
(defgroup hass-cli nil
  "Use hass-cli inside Emacs."
  :group 'tools)

(defcustom hass-cli-executable "hass"
  "Path to hass-cli executable."
  :type 'string
  :group 'hass-cli)

(defcustom hass-cli-server nil
  "Server where hass is running."
  :type 'string
  :group 'hass-cli)

(defcustom hass-cli-token nil
  "Long lasting token used to connect to server."
  :type 'string
  :group 'hass-cli)

(defun hass-cli-command (&rest args)
  "Execute command with extra ARGS."
  (message "executing hass-cli-command")
  (apply #'process-lines
         hass-cli-executable
         "--server"
         hass-cli-server
         "--token"
         hass-cli-token
         args))

(defun hass-cli-entity-list ()
  "Get entity list."
  (hass-cli-command "--no-headers"
                    "--columns"
                    "entity_id"
                    "entity"
                    "list"))

(defun hass-cli-insert-entity ()
  "Insert entity."
  (interactive)
  (let ((entities (hass-cli-entity-list)))
    (insert (completing-read "Entity: " entities))))

(provide 'hass-cli)
;;; hass-cli.el ends here
