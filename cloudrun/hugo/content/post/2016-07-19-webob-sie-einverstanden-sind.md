---
date: 2016-07-19T15:25:46Z
title: WebOb Sie Einverstanden Sind
url: /2016/07/19/webob-sie-einverstanden-sind/
---

You may encounter the following error if you try to use `python-novaclient` (`stable/mitaka` version) to interact with `nova` (also `stable/mitaka` version):

    $ nova list
    ERROR (AttributeError): 'unicode' object has no attribute 'get'

Specifically the versions are:

    $ nova --version
    3.3.2
    $ nova-api --version
    13.1.1

The culprit is this line from `novaclient.exceptions`

    if hasattr(body, 'keys'):
        error = body[list(body)[0]]
        message = error.get('message')
        details = error.get('details')

Which is in turn caused by a change in upstream [WebOb][1]. So this error should be only observable if your `WebOb` is of version `>=1.6.0` on the server side and you have a `python-novaclient` with a version of `<=3.4.0` on the client side. `python-novaclient` 3.4.0 contains a [fix][2] to handle this case:

    if hasattr(body, 'keys'):
        # NOTE(mriedem): WebOb<1.6.0 will return a nested dict structure
        # where the error keys to the message/details/code. WebOb>=1.6.0
        # returns just a response body as a single dict, not nested,
        # so we have to handle both cases (since we can't trust what we're
        # given with content_type: application/json either way.
        if 'message' in body:
            # WebOb 1.6.0 case
            message = body.get('message')
            details = body.get('details')
        else:
            # WebOb<1.6.0 where we assume there is a single error message
            # key to the body that has the message and details.
            error = body[list(body)[0]]
            message = error.get('message')
            details = error.get('details')

Since this behaviour is caused by an external dependency it will probably only come up for source installations where `pip` was allowed to go wild with the requirements.

[1]: http://webob.org/
[2]: http://git.openstack.org/cgit/openstack/python-novaclient/commit/?id=fa377e7fca44e81247639efebd7cae5cb377e57e
