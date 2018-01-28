---
date: 2014-02-09T20:24:14Z
title: Hit the Road jackd
url: /2014/02/09/hit-the-road-jackd/
---

If there are multiple sound devices, jack server should provided a parameter for which the server should be started:

`jackd -d alsa -d hw:1`

for starting for the `hw:1` device using alsa backend.

I really should go over my sound settings.