---
date: 2015-11-14T06:30:31Z
title: Yeah, Don't Run RabbitMQ on a Floppy Disk
url: /2015/11/14/yeah,-don't-run-rabbitmq-on-a-floppy-disk/
---

If you observe that OpenStack Nova processes (Nova Compute in this case) are stuck while doing something like this:

    2015-11-26 10:31:33.521 7750 INFO oslo.messaging._drivers.impl_rabbit [req-a66f13cc-4e26-43c6-98bd-fcd89164072c ] Connecting to AMQP server on localhost:5672
    2015-11-26 10:31:33.545 7750 INFO oslo.messaging._drivers.impl_rabbit [req-a66f13cc-4e26-43c6-98bd-fcd89164072c ] Connected to AMQP server on localhost:5672
    2015-11-26 10:31:33.550 7750 INFO oslo.messaging._drivers.impl_rabbit [req-a66f13cc-4e26-43c6-98bd-fcd89164072c ] Connecting to AMQP server on localhost:5672
    2015-11-26 10:31:33.565 7750 INFO oslo.messaging._drivers.impl_rabbit [req-a66f13cc-4e26-43c6-98bd-fcd89164072c ] Connected to AMQP server on localhost:5672

And all the RabbitMQ connections seem to be blocked or blocking:

    $ sudo rabbitmqctl list_connections
    Listing connections ...
    guest   127.0.0.1       41017   blocked
    guest   127.0.0.1       41022   blocking
    guest   127.0.0.1       41023   blocking
    guest   127.0.0.1       41024   blocking
    guest   127.0.0.1       41025   blocking
    guest   127.0.0.1       41028   blocked
    guest   127.0.0.1       41030   blocked
    guest   127.0.0.1       41034   blocked
    guest   127.0.0.1       41036   blocked
    guest   127.0.0.1       41037   blocking
    guest   127.0.0.1       41038   blocked
    ...done.

Then it probably means that you have almost ran out of hard disk space.

As always, I constantly forget this and start debugging Nova Compute until I think of listing RabbitMQ connections and try to find out why they are blocked. But the moment you clear enough disk space and the debug statements in the Nova process start to flow again is pretty enjoyable to watch.
