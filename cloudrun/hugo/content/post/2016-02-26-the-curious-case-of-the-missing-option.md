---
date: 2016-02-26T09:21:02Z
title: The Curious Case of the Missing Option
url: /2016/02/26/the-curious-case-of-the-missing-option/
---

So, for same reason I had to reinstall my OpenStack development environment and like a sane person, I decided to go with a virtualenv installation. However I wasn't able to start nova-compute because it failed with the following error (output is from a EC2 instance where I was able to replicate the behaviour with a global pip installation):

    2016-02-26 09:25:44.391 2188 CRITICAL nova [-] NoSuchOptError: no such option in group libvirt: rbd_user
    2016-02-26 09:25:44.391 2188 TRACE nova Traceback (most recent call last):
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/bin/nova-compute", line 10, in <module>
    2016-02-26 09:25:44.391 2188 TRACE nova     sys.exit(main())
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/cmd/compute.py", line 72, in main
    2016-02-26 09:25:44.391 2188 TRACE nova     db_allowed=CONF.conductor.use_local)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/service.py", line 277, in create
    2016-02-26 09:25:44.391 2188 TRACE nova     db_allowed=db_allowed)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/service.py", line 148, in __init__
    2016-02-26 09:25:44.391 2188 TRACE nova     self.manager = manager_class(host=self.host, *args, **kwargs)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/compute/manager.py", line 715, in __init__
    2016-02-26 09:25:44.391 2188 TRACE nova     self.driver = driver.load_compute_driver(self.virtapi, compute_driver)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/virt/driver.py", line 1389, in load_compute_driver
    2016-02-26 09:25:44.391 2188 TRACE nova     virtapi)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/oslo_utils/importutils.py", line 50, in import_object_ns
    2016-02-26 09:25:44.391 2188 TRACE nova     return import_class(import_value)(*args, **kwargs)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/oslo_utils/importutils.py", line 27, in import_class
    2016-02-26 09:25:44.391 2188 TRACE nova     __import__(mod_str)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/virt/libvirt/__init__.py", line 15, in <module>
    2016-02-26 09:25:44.391 2188 TRACE nova     from nova.virt.libvirt import driver
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/virt/libvirt/driver.py", line 97, in <module>
    2016-02-26 09:25:44.391 2188 TRACE nova     from nova.virt.libvirt import imagebackend
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/nova/virt/libvirt/imagebackend.py", line 80, in <module>
    2016-02-26 09:25:44.391 2188 TRACE nova     CONF.import_opt('rbd_user', 'nova.virt.libvirt.volume', group='libvirt')
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/oslo_config/cfg.py", line 2039, in import_opt
    2016-02-26 09:25:44.391 2188 TRACE nova     self._get_opt_info(name, group)
    2016-02-26 09:25:44.391 2188 TRACE nova   File "/usr/local/lib/python2.7/dist-packages/oslo_config/cfg.py", line 2384, in _get_opt_info
    2016-02-26 09:25:44.391 2188 TRACE nova     raise NoSuchOptError(opt_name, group)
    2016-02-26 09:25:44.391 2188 TRACE nova NoSuchOptError: no such option in group libvirt: rbd_user
    2016-02-26 09:25:44.391 2188 TRACE nova 

But strangely, I encountered no errors when I tried to run nova-compute installed via Ubuntu 14.04 Cloud Archive Packages. So I tried to pinpoint the problem. After almost a day of debugging `oslo.config` I found the culprit; this was a Kilo (2015.4) installation. However, I probably (mistakenly) installed Liberty or master from the cloned repo. So at some stage the build directory inside the repo contained packages for Liberty or later. Here is how the `nova.virt.libvirt` package on Liberty and later looks like:

    blockinfo.py  config.py    driver.py    guest.py  imagebackend.py  __init__.py            storage/  vif.py
    compat.py     designer.py  firewall.py  host.py   imagecache.py    instancejobtracker.py  utils.py  volume/

And for comparison, here is what it looks like on Kilo:

    blockinfo.py  config.py    dmcrypt.py  firewall.py  imagebackend.py  __init__.py            lvm.py      rbd_utils.py  utils.py  volume.py
    compat.py     designer.py  driver.py   host.py      imagecache.py    instancejobtracker.py  quobyte.py  remotefs.py   vif.py

So the volume module has been converted to a package after Kilo. But since I (probably) installed from master, then from Kilo, the build directory had an erroneous structure. That caused `oslo.config` to fail to register the required options because it failed to import the correct package. Even though I tried multiple virtualenv installations, I didn't clear the build directory so the error persisted through what I assumed were clean installations, but in fact had an incorrect package layout. As far as I could discover, at least two other people have been bitten by this behaviour:


[A bug report later deemed invalid by the reporter][bug]

[A help request on IRC (jschwarz around 15:25)][irc]

I'm typing this post with hopes that it may be helpful to anyone encountering this issue. Hopefully not for too long since Kilo will be EOL on May 2016, the 2nd.

The take-home lessons for me were:

* Clean your build directory if you are installing consirably different versions of a Python package.
* Actually, clean your build directory no matter what.
* More actually, design a propaganda poster to remind yourself to clean the build directory every time you run the setup script.


[bug]: https://bugs.launchpad.net/nova/+bug/1304762
[irc]: http://eavesdrop.openstack.org/irclogs/%23openstack-nova/%23openstack-nova.2015-08-17.log.html 
