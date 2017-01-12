From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
Date: Thu, 12 Jan 2017 10:01:45 -0600
Message-ID: <CAL_JsqJtJaadieC2PSe6YV9pvvv8TXTM-hSDR5MZR+n-aRWo1g@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-9-robh@kernel.org>
 <1483798314.26691.3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483798314.26691.3.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 7, 2017 at 8:11 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
>> Add a serdev controller driver for tty ports.
>>
>> The controller is registered with serdev when tty ports are registered
>> with the TTY core. As the TTY core is built-in only, this has the side
>> effect of making serdev built-in as well.
>>
>>
>
>> +if SERIAL_DEV_BUS
>> +
>> +config SERIAL_DEV_CTRL_TTYPORT
>> +     bool "Serial device TTY port controller"
>> +     depends on TTY
>
>> +     depends on SERIAL_DEV_BUS=y
>
> Do you need one?

Yes, otherwise the bus can be built as a module and this driver can
still be enabled breaking the build. I could drop supporting building
the bus as a module because as long as this is the only controller
driver, it all has to be built-in. Is there any desire/plan to make
the TTY layer buildable as a module?


>> +     mutex_unlock(&serport->lock);
>> +     return count;
>> +}
>> +
>> +static void ttyport_write_wakeup(struct tty_port *port)
>> +{
>> +     struct serdev_controller *ctrl = port->client_data;
>> +     struct serport *serport =
>> serdev_controller_get_drvdata(ctrl);
>> +
>> +     clear_bit(TTY_DO_WRITE_WAKEUP, &port->tty->flags);
>
> This doesn't prevent to be called this function in parallel. Is it okay?

I believe it should be fine. This is essentially what all the wakeup
callbacks do for the ldisc based drivers.


>> +int serdev_tty_port_register(struct tty_port *port, struct device
>> *parent,
>> +                         struct tty_driver *drv, int idx)
>> +{
>> +     struct serdev_controller *ctrl;
>> +     struct serport *serport;
>> +     int ret;
>> +
>> +     if (!port || !drv || !parent || !parent->of_node)
>
> And if it's ACPI? Perhaps last is redundant.

Yes, fixed. We should only have the matching details in the core.

>
>> +             return -ENODEV;
>> +
>> +     ctrl = serdev_controller_alloc(parent, sizeof(struct
>> serport));
>> +     if (!ctrl)
>> +             return -ENOMEM;
>> +     serport = serdev_controller_get_drvdata(ctrl);
>> +
>> +     mutex_init(&serport->lock);
>> +     serport->port = port;
>> +     serport->tty_idx = idx;
>> +     serport->tty_drv = drv;
>> +
>> +     ctrl->ops = &ctrl_ops;
>> +
>> +     ret = serdev_controller_add(ctrl);
>> +     if (ret)
>> +             goto err;
>> +
>> +     printk(KERN_INFO "serdev: Serial port %s\n", drv->name);
>
> Hmm... It's not a debug message, why not use pr_info()?

Converted to dev_info().


>> +     serdev_controller_put(ctrl);
>> +     return ret;
>> +}
>> +
>> +void serdev_tty_port_unregister(struct tty_port *port)
>> +{
>> +     struct serdev_controller *ctrl = port->client_data;
>> +     struct serport *serport =
>> serdev_controller_get_drvdata(ctrl);
>> +
>>
>
>> +     if (!serport)
>> +             return;
>
> Same question, whose responsibility to do this?

I don't get the question. ctrl and serport can be NULL here so the
caller can call this unconditionally.

Rob
