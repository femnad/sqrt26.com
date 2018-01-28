---
date: 2016-07-29T08:04:14Z
title: Router? I Hardly Knew Her!
url: /2016/07/29/router--i-hardly-knew-her-/
---

So, you want enable router and NAT functionality for your Neutron installation so that anyone would be able to create and manage routers? This setup is described as self-service networks by the OpenStack documentation and requires you to have the `router` service\_plugin enabled. So in the neutron.conf the line:

    service_plugins = router

should be present. If the `router` functionality is not enabled you won't be able to run the L3 agent correctly since the relevant RPC message queues won't be usable:

    2016-07-29 08:24:33.487 18859 ERROR neutron.common.rpc [req-3a888cc9-76de-4daa-ada4-f00b3025f60f - - - - -] Timeout in RPC method get_service_plugin_list. Waiting for 25 seconds before next attempt. If the server is not down, consider increasing the rpc_response_timeout option as Neutron server(s) may be overloaded and unable to respond quickly enough.
    2016-07-29 08:24:33.489 18859 WARNING neutron.common.rpc [req-3a888cc9-76de-4daa-ada4-f00b3025f60f - - - - -] Increasing timeout for get_service_plugin_list calls to 120 seconds. Restart the agent to restore it to the default value.

and the router resource won't be available from the Neutron server:

    $ neutron router-list
    The resource could not be found.<br /><br />



    Neutron server returns request_ids: ['req-7951788b-35ed-474a-a3b0-fa58649215fc']

This step is correctly described in the [documentation][doc] but if you change setups a lot, just skim the documentation because you've gone over it a few times before or are somewhat absent minded like me you may miss it.

[doc]: http://docs.openstack.org/mitaka/install-guide-ubuntu/neutron-controller-install-option2.html
