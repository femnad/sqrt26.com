---
date: 2015-05-14T19:41:11Z
title: Take These Too!
url: /2015/05/14/take-these-too!/
---

So, you are getting pretty good at leeching of [gmane][gmane] with the unsatiable straw (as in enabler of feeding?) that is [tin][tin]. But, you must also be getting pretty tired of those prompts asking for what to do if there is an attached signature or the message is multipart. Also, while it was done with best intentions, setting a mailcap file for several extensions with empty viewers is a worst practice. So, I give you .tinrc, saviour of fingers which are tasked with pressing 'n':

    # set this to blank
    metamail_prog=--internal

    # or this to off
    ask_for_metamail=ON

[gmane]: http://www.gmane.org/
[tin]: http://tin.org/
