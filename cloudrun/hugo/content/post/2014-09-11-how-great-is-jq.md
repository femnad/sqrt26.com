---
categories: [jq]
date: 2014-09-11T00:00:00Z
title: How Great Is jq?
url: /2014/09/11/how-great-is-jq/
---

[jq][jq] is such a good being that it allows you to make sense of your crowded, stringified and escaped json messages, which you may collect via [logstash][logstash], if you desire:

{{< highlight bash >}}
    logstash agent --quiet | jq -S '.foo | fromjson | {custom_label: .["@rubydebug_label"], another_custom_label: .["@another_rubydebug_label"], yacl: .["@yarl"].subfield, you_get_the_idea: true'
{{< / highlight >}}

[jq]: http://stedolan.github.io/jq/
[logstash]: http://logstash.net/
