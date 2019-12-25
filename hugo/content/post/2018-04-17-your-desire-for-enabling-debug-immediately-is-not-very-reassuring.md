---
title: "Your Desire for Enabling Debug Immediately Is Not Very Reassuring"
date: 2018-04-17T00:31:34+01:00
---
You're lost again when trying to send handcrafted packages to a syslog server, right? Luckily, for [Rsyslog](https://www.rsyslog.com),  [Rainer Gerhards](http://blog.gerhards.net/) is here to help with the debug format template:

http://blog.gerhards.net/2013/06/rsyslog-how-can-i-see-which-field.html

The link provides example usage of the template for the legacy configuration language, therefore allow me to specify it in the modern syntax (because what's another minute when you're six levels deep into yak shaving?):

```action(type="omfile" File="/var/log/yak-shavers-anonymous" Template="RSYSLOG_DebugFormat")```
