---
layout: post
title: Sleep Well My Child
date: '2014-01-04 11:49:05'
---

To prevent instant waking after suspension when using pm-utils, add modules that need to be unloaded before suspension to `/etc/pm/config.d/modules`. Most likely candidates are: `usb` and `ehci` related modules and their dependencies. Check for dependencies by trying remove modules with `rmmod <module>`. Also remember to unload wifi related modules since they may have problems after resume, as mentioned here:

[Arch Linux Wiki - Pm-utils](https://wiki.archlinux.org/index.php/Pm-utils#Standby.2Fsuspend_to_RAM)

