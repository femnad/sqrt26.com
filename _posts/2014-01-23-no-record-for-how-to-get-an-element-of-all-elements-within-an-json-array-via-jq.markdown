---
layout: post
title: No Record for 'How to Get an Element of all Elements within an JSON Array via
  jq'
date: '2014-01-23 12:27:53'
---

Assuming you have a JSON array, each of which has a field labeled "foo", you get all "foo" fields thusly:


    <output JSON string to stdout> | jq '.[] | {"foo"}'
    
Why do I keep forgetting this?


Hat tip: http://stedolan.github.io/jq/