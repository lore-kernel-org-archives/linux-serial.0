From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 7/9] serdev: Introduce new bus for serial attached devices
Date: Thu, 12 Jan 2017 14:13:42 -0600
Message-ID: <CAL_JsqJsCRgM2pkkvPyimhTi1SFVosas=6VwDyd5ZiOVbD_2tQ@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-8-robh@kernel.org>
 <1483797771.26691.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483797771.26691.1.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 7, 2017 at 8:02 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:
>> The serdev bus is designed for devices such as Bluetooth, WiFi, GPS
>> and NFC connected to UARTs on host processors. Tradionally these have
>> been handled with tty line disciplines, rfkill, and userspace glue
>> such
>> as hciattach. This approach has many drawbacks since it doesn't fit
>> into the Linux driver model. Handling of sideband signals, power
>> control
>> and firmware loading are the main issues.
>>
>> This creates a serdev bus with controllers (i.e. host serial ports)
>> and
>> attached devices. Typically, these are point to point connections, but
>> some devices have muxing protocols or a h/w mux is conceivable. Any
>> muxing is not yet supported with the serdev bus.

[...]

>> +static int of_serdev_register_devices(struct serdev_controller *ctrl)
>> +{
>> +     struct device_node *node;
>> +     struct serdev_device *serdev = NULL;
>> +     int err;
>> +     bool found = false;
>> +
>> +     for_each_available_child_of_node(ctrl->dev.of_node, node) {
>> +             if (!of_get_property(node, "compatible", NULL))
>> +                     continue;
>> +
>> +             dev_dbg(&ctrl->dev, "adding child %s\n", node-
>> >full_name);
>> +
>> +             serdev = serdev_device_alloc(ctrl);
>> +             if (!serdev)
>> +                     continue;
>> +
>> +             serdev->dev.of_node = node;
>> +
>> +             err = serdev_device_add(serdev);
>> +             if (err) {
>> +                     dev_err(&serdev->dev,
>> +                             "failure adding device. status %d\n",
>> err);
>> +                     serdev_device_put(serdev);
>> +             }
>>
>
>> +             found = true;
>
> Perhaps
>
> } else if (!found)
>  found = true;
>
> Otherwise if we end up with all devices not being added, called will not
> know about it.

At least for now, we really only support 1 device attached. I'm sure
someone will come up with h/w with more than one device. RS-485 allows
it I think or someone could have muxed access.

I just did "else found = true;" as there's no need to check the condition.

>
>
>> +     }
>> +     if (!found)
>> +             return -ENODEV;
>> +
>> +     return 0;
>> +}
>>
>
>
> +/**
>> + * serdev_controller_remove(): remove an serdev controller
>> + * @ctrl:    controller to remove
>> + *
>> + * Remove a serdev controller.  Caller is responsible for calling
>> + * serdev_controller_put() to discard the allocated controller.
>> + */
>> +void serdev_controller_remove(struct serdev_controller *ctrl)
>> +{
>> +     int dummy;
>> +
>>
>
>> +     if (!ctrl)
>> +             return;
>
> By the way, should we take care or caller? What is the best practice
> here?

If the caller, then every caller has to check. Better to check in one place.

Rob
