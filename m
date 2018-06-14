From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via sysfs*
Date: Thu, 14 Jun 2018 13:06:59 +0200
Message-ID: <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com> <20180614104820.GC32411@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180614104820.GC32411@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Johan
On Thu, Jun 14, 2018 at 12:48 PM Johan Hovold <johan@kernel.org> wrote:
>
> Hi Ricardo,
>
> On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> > There are some situations where it is interesting to load/remove serdev
> > devices dynamically, like during board bring-up or when we are
> > developing a new driver or for devices that are neither described via
> > ACPI or device tree.
>
> First of all, this would be more appropriately labeled an RFC as this is
> far from being in a mergeable state. Besides some implementation issues,
> we need to determine if this approach is at all viable.

>From previous conversations with Greg it seemed that RFC labels was
something to avoid, but I do not mind reseding it as RFC on v3.

http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-March/018844.html

>
> Second, I wonder how you tested this given that this series breaks RX
> (and write-wakeup signalling) for serial ports (patch 19/24)?

I have a serdev device (led ctrls) that is dynamically enumerated with
something very similar to:

https://github.com/ribalda/linux/commit/415bb3f0076c2b846ebe5409589b8e1e3004f55a

and then I have a script that does adds and removes. For standard
serial port I was not testing the data path, just that the ttyS* was
enumerated fine.

But  yesterday I believe that we found the bug that you mentioned and
we have fixed it (check end of mail). I will patch the series and
resend after I get more feedback and also implement what Marcel
suggested.

WIP is at
https://github.com/ribalda/linux/tree/serdev3

Besides this bug, we have used the new driver for over a week now with
no issues.

>
> Third, and as Marcel already suggested, you need to limit your scope
> here. Aim at ten patches or so, and use a representative serdev driver
> as an example of the kind of driver updates that would be needed. It
> also looks like some patches should be squashed (e.g. the ones
> introducing new fields and the first one actually using them).

>
> > This implementation allows the creation of serdev devices via sysfs,
> > in a similar way as the i2c bus allows sysfs instantiation [1].
>
> Note that this is a legacy interface and not necessarily something that
> new interfaces should be modelled after.

I would not consider it legacy, it is the only way to use an i2c
module without writing your own driver and/or modifying ACPI/DT table.
Just google around for i2c linux...
Thanks!

>
> Johan
Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu Jun 14 11:30:27 2018 +0200

    serdev-ttydev: Restore/change ttyport client ops

diff --git a/drivers/tty/serdev/serdev-ttydev.c
b/drivers/tty/serdev/serdev-ttydev.c
index 180035e101dc..b151c9645a1d 100644
--- a/drivers/tty/serdev/serdev-ttydev.c
+++ b/drivers/tty/serdev/serdev-ttydev.c
@@ -16,14 +16,23 @@ static int ttydev_serdev_probe(struct serdev_device *serdev)
        struct serdev_controller *ctrl = serdev->ctrl;
        struct serport *serport;
        struct device *dev;
+       const struct tty_port_client_operations *serdev_ops;

        if (!ctrl->is_ttyport)
                return -ENODEV;

        serport = serdev_controller_get_drvdata(ctrl);

+       serdev_ops = serport->port->client_ops;
+
+       serport->port->client_ops = serport->tty_ops;
        dev = tty_register_device_attr(serport->tty_drv, serport->tty_idx,
-                                       &serdev->dev, NULL, NULL);
+                                      ctrl->dev.parent, NULL, NULL);
+
+       if (IS_ERR(dev))
+               serport->port->client_ops = serdev_ops;
+       else
+               serdev_device_set_drvdata(serdev, (void *)serdev_ops);

        return dev ? 0 : PTR_ERR(dev);
 }
@@ -35,6 +44,7 @@ static void ttydev_serdev_remove(struct serdev_device *serdev)

        serport = serdev_controller_get_drvdata(ctrl);
        tty_unregister_device(serport->tty_drv, serport->tty_idx);
+       serport->port->client_ops = serdev_device_get_drvdata(serdev);
 }



-- 
Ricardo Ribalda
