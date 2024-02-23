;;; flycheck-dart.el --- Flycheck for dart analyze  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  martin haesler
;; Copyright (C) 2024  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/jcs090218/flycheck-dart
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1") (flycheck "0.22") (dart-mode "0.11"))
;; Keywords: tools

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Flycheck for dart analyze.
;;

;;; Code:

(require 'flycheck)

(flycheck-define-checker dart
  "Dart static analyzer using dart analyze."
  :command ("dart" "analyze" "--format=machine" source)
  :error-patterns
  ((error line-start "ERROR" "|" (= 2 (+ (any "A-Z" "a-z" "0-9" "_")) "|")
          (file-name) "|" line "|" column "|" (one-or-more (any digit)) "|"
          (message) line-end)

   (warning line-start "WARNING" "|" (= 2 (+ (any "A-Z" "a-z" "0-9" "_")) "|")
            (file-name) "|" line "|" column "|" (one-or-more (any digit)) "|"
            (message) line-end)

   (info line-start "INFO" "|" (= 2 (+ (any "A-Z" "a-z" "0-9" "_")) "|")
         (file-name) "|" line "|" column "|" (one-or-more (any digit)) "|"
         (message) line-end))
  :modes (dart-mode))

;;;###autoload
(defun flycheck-dart-setup ()
  "Setup flycheck-package."
  (interactive)
  (add-to-list 'flycheck-checkers 'dart))

(provide 'flycheck-dart)
;;; flycheck-dart.el ends here
