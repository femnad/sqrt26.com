---
date: 2014-01-23T12:27:53Z
title: No Record for 'How to Get an Element of all Elements within an JSON Array via
  jq'
url: /2014/01/23/no-record-for-how-to-get-an-element-of-all-elements-within-an-json-array-via-jq/
---

Assuming you have a JSON array, each of which has a field labeled "foo", you get all "foo" fields thusly:


    <output JSON string to stdout> | jq '.[] | {"foo"}'
    
Why do I keep forgetting this?

Hat tip: [jq][jq]

[jq]: http://stedolan.github.io/jq/
