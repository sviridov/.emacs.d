# ido-ql-quickload

**ido-ql-quickload** is a enhancement for SLiME and Quicklisp. Built on top of Ido, it provides a convenient interface to your recently and most frequently loaded systems. And to all the other systems, too.

## Get started

* Download **ido-ql-quickload** and set-up your load path. [(Find out more.)](http://www.emacswiki.org/emacs/InstallingPackages)

* To auto-start **ido-ql-quickload** every time you open Emacs add these lines to your `.emacs` file:

```lisp
(require 'ido-ql-quickload)
(ido-ql-quickload-initialize)
```

* Run SLiME
* Type `M-x ql:quickload`

The systems are displayed in an Ido completion buffer, ordered by relevance. The 5 most recently loaded systems come first, the rest are sorted by location (local systems come before Quicklisp systems), frequency of use and in alphabetical order.

One can also use `M-x ql:quickload` as a replacement for `ql:system-apropos`.

## Learn more

### Persistence
**ido-ql-quickload** keeps a file to save its state between Emacs sessions. The default path is `"~/.ido-ql-quickload"`. One can change it by setting the variable `ido-ql-quickload-save-file`. 

**Note:** One should change `ido-ql-quickload-save-file` before `(ido-ql-quickload-initialize)`.

### History
Set `ido-ql-quickload-max-history-size` to change the number of recent systems that **ido-ql-quickload** keeps track of.

### Order
To ignore **ido-ql-quickload** history set `ido-ql-quickload-max-history-size` to `0`.

To ignore system location set `ido-ql-quickload-ignore-local-projects-priority` to `t`.

### Aborting

To abort `M-x ql:quickload` type `C-g`.

### Suppression of output

To disable switching to `slime-repl` buffer and to suppress output of `ql:quickload` set `ido-ql-quickload-suppress-output` to `t`
