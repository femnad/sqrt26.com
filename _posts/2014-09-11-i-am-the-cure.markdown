---
layout: post
title:  "I Am the Cure!"
date:   2014-09-11 10:19:05
categories: pkg-config
---
If you encounter such an error during the configure state of a package:

    ./configure: line foo: syntax error near unexpected token `something,'
    ./configure: line bar: `PKG_CHECK_MODULES(something, libsomething)'

that means [pkg-config][pkg-config] is not installed.

[pkg-config]: http://www.freedesktop.org/wiki/Software/pkg-config/
