---
categories: [pkg-config]
date: 2014-09-11T10:19:05Z
title: I Am the Cure!
url: /2014/09/11/i-am-the-cure/
---

If you encounter such an error during the configure state of a package:

    ./configure: line foo: syntax error near unexpected token `something,'
    ./configure: line bar: `PKG_CHECK_MODULES(something, libsomething)'

that means [pkg-config][pkg-config] is not installed.

[pkg-config]: http://www.freedesktop.org/wiki/Software/pkg-config/
