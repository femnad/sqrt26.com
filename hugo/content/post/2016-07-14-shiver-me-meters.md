---
date: 2016-07-14T15:31:54Z
title: Shiver Me Meters
url: /2016/07/14/shiver-me-meters/
---

When you want to make use of event based meters (like `vcpus`) in your OpenStack Nova installation, make sure that the Nova compute service is telemetry enabled, i.e. its `nova.conf` has:

    [DEFAULT]
    ...
    instance_usage_audit = True
    instance_usage_audit_period = hour
    notify_on_state_change = vm_and_task_state
    notification_driver = messagingv2

After performing this change you'll have to restart the Ceilometer compute agent (which you can run with the `ceilometer-polling --polling-namespaces compute` command, by the way) and the Nova compute service.

Always true to form, I probabably forgot this simple configuration step for 5 or 10 times now and have built several widow's walks while waiting for those elusive `vcpus` samples.

Relevant documentation: [OpenStack Installation Guide for Ubuntu](http://docs.openstack.org/mitaka/install-guide-ubuntu/ceilometer-nova.html)
