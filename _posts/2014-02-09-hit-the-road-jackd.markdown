---
layout: post
title: Hit the Road jackd
date: '2014-02-09 20:24:14'
---

If there are multiple sound devices, jack server should provided a parameter for which the server should be started:

`jackd -d alsa -d hw:1`

for starting for the `hw:1` device using alsa backend.

I really should go over my sound settings.