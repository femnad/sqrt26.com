---
date: 2015-03-26T19:22:22Z
title: You Are a Bad Confluence on Me
url: /2015/03/26/you-are-a-bad-confluence-on-me/
---

In order to access pages from your hosted Atlassion Confluence on GNU Emacs via [confluence-el][confluence-el] mode, the `confluence-url` variable should be set thusly (assuming it's placed within `custom-set-variables` arguments):

     '(confluence-url "https://<hosted-site>/wiki/rpc/xmlrpc")

Where `<hosted-site>` is probably somewhere.atlassian.net. Or not. At least in my experience, 100% of the cases (actually a case) it was that way.

[confluence-el]: http://sourceforge.net/p/confluence-el/wiki/Home/
