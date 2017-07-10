---
layout: post
title: How Great Is jq?
date: 2014-09-11 12-18-54
categories: jq
---
[jq][jq] is such a good being that it allows you to make sense of your crowded, stringified and escaped json messages, which you may collect via [logstash][logstash], if you desire:

{% highlight bash %}
    logstash agent --quiet | jq -S '.foo | fromjson | {custom_label: .["@rubydebug_label"], another_custom_label: .["@another_rubydebug_label"], yacl: .["@yarl"].subfield, you_get_the_idea: true'
{% endhighlight %}

[jq]: http://stedolan.github.io/jq/
[logstash]: http://logstash.net/
