# quick-repl-history-search

**quick-repl-history-search** is a Emacs library that provides quick search around any Emacs REPL history.

## Get started

* Download **quick-repl-history-search** and set-up your load path. [(Find out more.)](http://www.emacswiki.org/emacs/InstallingPackages)
* To auto-start **quick-repl-history-search** every time you open Emacs add these lines to your `.emacs` file:

```lisp
(require 'quick-repl-history-search)
```
* Run one of the supported REPLs
* Press `C-r` to start search
* Enter the required input substring
* Press `C-r` or `C-s` to move between history items
* Press `RET` to send selected input
* Press `C-RET` to insert selected input without sending
* Press `C-SPC` to start/stop after change update
* Press `G-g` to abort

## Supported REPLs

* Comint
* Coffee
* Eshell
* IELM
* nREPL
* Skewer
* SLiME
