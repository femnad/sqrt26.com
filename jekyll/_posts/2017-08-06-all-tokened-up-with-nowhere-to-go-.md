---
layout: post
title: All tokened up with nowhere to go.
date: '2017-08-06 15:24:42'
---
So, running OpenStack services from a non-root user's home makes sense, right? No need for additional privileges, everything available right under home and plays well with virtualenv directories in home. However, if you are not careful (like me), this endeavor might result in some bumps along the way. Here's one:

Even though the keystone service is successfully bootstrapped and authentications with username and password are valid, the issued tokens may not function correctly, with the usual unauthorized error message:

    2017-08-06 14:56:35.047 13173 WARNING keystone.common.wsgi [req-3944a452-23e2-4512-9241-9809023f5928 - - - - -] Authorization failed. The request you have made requires authentication. from 127.0.0.1: keystone.exception.Unauthorized: The request you have made requires authentication

The reason? Well, if you are using the fernet repositoty, the directory for it should be accessible by the user running the service. Thankfully, keystone logs are really helpful in this case:

    2017-08-06 15:03:12.262 7554 ERROR keystone.common.fernet_utils [-] Either [fernet_tokens] key_repository does not exist or Keystone does not have sufficient permission to access it: /etc/keystone/fernet-keys/

The solution is specifying a directory which is accessible by that user as the fernet repository, e.g.: in `keystone.conf`

    [fernet_tokens]
    key_repository = <user-accessible-directory>

