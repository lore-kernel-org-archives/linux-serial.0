From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/9] Serial slave device bus
Date: Fri, 13 Jan 2017 08:48:31 -0600
Message-ID: <CAL_JsqKN8cjQgKWjVqQ3Z9nUE1pG3ve9qf-9rxgGYQmiMQYThA@mail.gmail.com>
References: <20170106162635.19677-1-robh@kernel.org> <8E1651EC-E9E5-4BB5-84CB-8CFEE08009BA@goldelico.com>
 <CAL_JsqL-VMQ+zCTN+4+PPPCY+-askp=H908s8R=EjjytzuC8yw@mail.gmail.com> <39C27218-E564-4C7D-A8CD-8D7F654EE2B3@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39C27218-E564-4C7D-A8CD-8D7F654EE2B3@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 13, 2017 at 5:22 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Hi Rob,
> was it intentional to answer privately only?

Damn gmail. Added everyone back.

>> Am 12.01.2017 um 23:07 schrieb Rob Herring <robh@kernel.org>:
>>
>> On Tue, Jan 10, 2017 at 5:44 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Hi Rob,
>>>
>>>> Am 06.01.2017 um 17:26 schrieb Rob Herring <robh@kernel.org>:
>>>>

[...]

>>> 2. When I try to open the tty from user space to fetch the serial data I
>>> just get
>>>
>>> root@letux:~# cat /dev/ttyO1
>>> [  659.290618] ttyO ttyO1: tty_open: tty->count(2) != #fd's(1)
>>> [  665.257232] ttyO ttyO1: tty_release: tty->count(2) != #fd's(1)
>>> ^C
>>> root@letux:~#
>>>
>>> So it does not seem to be possible to read the data from the tty any more.
>>>
>>> Maybe there can be some function serdev_device_set_shared(dev, flag).
>>> If set to exclusive the /dev node would be hidden from user-space.
>>
>> I don't think sharing should be allowed. Either you have an in-kernel
>> driver or you handle it in userspace. Sharing is just asking for
>> trouble IMO.
>
> My tty-slave patch series works and has no trouble with sharing (the UART)
> because it was designed with this in mind.
>
> The only trouble is that it did not find maintainer's acceptance...
>
>> Though it could be supported later.
>
> Firstly, let me point out once again that we have a mobile device, battery
> powered and every component should be and stay turned off, if not needed by
> any consumer.

That's every device...

> The only component that can reliably detect if there is no consumer in user-space
> is the kernel. Hence it must be a kernel driver that powers the device on/off.
>
> On the other side, it should simply pass data unmodified to user space (because the
> chip provides cooked data), so we do not need a driver for doing any data processing.
> The data stream is provided perfectly (without proper power control) by simply
> accessing /dev/ttyO1 from user-space.
>
> So if there were no power control topic, we would not even ask for a driver.

I think this reasoning is exactly why we have no proper subsystem
today. We *almost* don't need one. It all works fine except I have
this one GPIO to control. Oh, and a regulator and firmware and
suspend/resume control and ...

> We only need the driver to detect the power state of the chip by *monitoring*
> the data stream that goes to user space.
>
> Of course shared writing to the chip would give trouble, but we do not need it.
> Therefore I am happy if this sharing is an option (with a big WARNING sign).
>
> If we would try to achieve the same power management in user-space we would have
> to run a power-consuming daemon and make sure that it *never* crashes (or people
> come and complain about short battery life even if they think they have GPS
> turned off).
>
> And we need to be able to maintain the daemon for many different distributions
> people want to run on our device. This takes years to get it into Debian and
> others where we are not developers at all.

Exactly one of the problems we're trying to solve. With your desired
approach though, you are still leaving the problem of having to know
which tty device the GPS chip is connected to which varies with each
board. Either you hardcode the tty device in userspace, provide some
sysfs file with the tty name (like TI-ST) or link, provide the tty
name in DT (which I'll NAK) or have userspace parse the DT to find the
connection. I've seen all but the last case. I want to solve this
problem, too, such that userspace just opens the BT, WiFi, GPS, etc.
device.

> So this data stream sharing/monitoring is the most important part for getting our
> chip supported by a kernel driver.
>
>>
>> I've updated the series to skip creating the /dev nodes.
>
> That is exactly what we do NOT need for this chip. Now I can't even access it
> any more when powered on...

It's a minor change. Essentially, it is call tty_register_device_attr
or not. There's the issue of the file open count warning which I don't
know how to solve.

>>> 3. for completely implementing my w2sg0004 driver (and two others) it would
>>> be nice to have additional serdev_device_ops:
>>>
>>> a) to be notified about user-space clients doing open/close on the tty
>>> b) and/or to be notified about user-space tcsetattr or TIOCMSET (for DTR)
>>>
>>> There may be other means (ldisc?) to get these notifications, but that
>>> needs the serdev driver to register with two different subsystems.
>>>
>>> Another approach could be to completely rewrite the driver so that it wraps
>>> and hides the /dev/ttyO1 and registers its own /dev/gps tty port for user-space
>>> communication. Then it would be notified for all user-space and serial
>>> interface activities as a man-in-the-middle.
>>
>> This was my thinking. If we only need data read and write, I don't
>> think we gain much using a tty vs. a new char dev.
>
> We gain re-use of the existing tty for its key purpose to mediate between an uart
> device and user-space.
>
> I have looked into the chardev approach and it appears to be quite some overkill
> to copy serial data from the UART to a user space file handle.
>
> About buffering: with the chardev approach we have to implement our own buffer
> in the driver and decide what happens on overflow while the tty layer already
> efficiently handles this.

Not exactly. There's already buffering in tty_buffer.c. That handles
overflow of the UART. Then there is a 4K circular buffer in n_tty. The
question really is how much of the per character and flag processing
of n_tty do you need as that is where the complexity is. I'd guess not
much of it. If it is needed, then perhaps n_tty.c could be refactored
to provide common functions.

> And it is a little strange that the device can either be accessed through
> /dev/ttyO1 if the driver is not loaded and only through /dev/gps if it is.

We have similar things with SPI, I2C, and USB. Either you have a
kernel driver or you have a userspace driver. The userspace drivers
have limitations and if those limitations are a problem, we right
kernel drivers instead.

> New problems arise if there were two such chips. Then we must be prepared
> that several instances provide different /dev/gps[1-9] nodes and that they
> can be identified and are stable. Maybe we have to introduce udev-rules...

That's a solved problem generally (though not all like the answer).

> So what seems to be an obvious and straightforward solution (from serdev perspective)
> is not, if we look into implementation details of the driver.

I can't solve all problems for all possible drivers on day one. It
does provide a solution for drivers that are already in the kernel.
I'd suggest we debate adding sharing capability vs. a GPS subsystem
separately. If there was already a GPS subsystem there would be no
debate. I don't think what's here is preventing either case.
Similarly, I don't pretend the configuration API (baud rate and
flow-control) is complete. I'm sure someone will need additional
functions, but those can all be incrementally added as needed.

>>> But I expect that it delays the communication and is quite some overhead.
>>>
>>>
>>> 4. It seems as if I have to modprobe the driver explicitly (it is not
>>> located and loaded automatically based on the compatible string in DT
>>> like i2c clients).
>>
>> I've added what I think should be needed for that. I pushed out a new
>> branch[1]. Can you give it a try?
>
> Yes, sure. I have tried and now our driver module is loaded as expected :)
>
> But in general we are turning away from a solution for our w2sg0004 driver
> (see above).
>
> BTW: I see an issue in our kernel (config?) that the console and initd
> blocks for approx. 60 seconds during boot when serdev is merged (even
> if not configured). This issue disappears when using the omap2plus_defconfig.
>
> But I have not digged into that (because it may be spurious or EPROBE_DEFER
> related).

I've not seen anything like that. Do you have a diff of your configs?
And what is your init system?

Rob
