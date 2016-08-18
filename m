From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 08:15:02 -0500
Message-ID: <CAL_Jsq+Va2OF1pYTivH8YN1GKsiaT1eTOaSv607K_V+H+0Buvw@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818102208.GA20476@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818102208.GA20476@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 5:22 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
>> Currently, devices attached via a UART are not well supported in the
>> kernel. The problem is the device support is done in tty line disciplines,
>> various platform drivers to handle some sideband, and in userspace with
>> utilities such as hciattach.
>>
>> There have been several attempts to improve support, but they suffer from
>> still being tied into the tty layer and/or abusing the platform bus. This
>> is a prototype to show creating a proper UART bus for UART devices. It is
>> tied into the serial core (really struct uart_port) below the tty layer
>> in order to use existing serial drivers.
>>
>> This is functional with minimal testing using the loopback driver and
>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
>> device). It still needs lots of work and polish.
>>
>> TODOs:
>> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
>>   hoping all that complexity is from the tty layer and not needed here.
>
> It should be.
>
>> - Split out the controller for uart_ports into separate driver. Do we see
>>   a need for controller drivers that are not standard serial drivers?
>
> What do you mean by "controller" drivers here?  I didn't understand them
> in the code.

The host uart driver. It's basically a wrapper around struct
uart_port, but may need to evolve to have its own ops if we want to
make using struct uart_port for driver. Maybe host would be a better
name.

>> - Implement/test the removal paths
>> - Fix the receive callbacks for more than character at a time (i.e. DMA)
>> - Need better receive buffering than just a simple circular buffer or
>>   perhaps a different receive interface (e.g. direct to client buffer)?
>
> Why?  Is the code as-is slow?

No, the code should be fast as it is so simple. I assume there is some
reason the tty buffering is more complex than just a circular buffer.
My best guess is because the tty layer has to buffer things for
userspace and userspace can be slow to read? Do line disciplines make
assumptions about the tty buffering? Is 4KB enough buffering?

Also, the current receive implementation has no concept of blocking or
timeout. Should the uart_dev_rx() function return when there's no more
data or wait (with timeout) until all requested data is received?
(Probably do all of them is my guess).

>
>> - Test with other UART drivers
>> - Convert a real driver/line discipline over to UART bus.
>
> That's going to be the real test, I recommend trying that as soon as
> possible as it will show where the real pain points are :)
>
>> Before I spend more time on this, I'm looking mainly for feedback on the
>> general direction and structure (the interface with the existing serial
>> drivers in particular).
>
> Yes, I like the idea (minor nit, you still have SPMI in a lot of places
> instead of UART), so I recommend keeping going with it.
>
>>  drivers/uart/Kconfig             |  17 ++
>>  drivers/uart/Makefile            |   3 +
>>  drivers/uart/core.c              | 458 +++++++++++++++++++++++++++++++++++++++
>>  drivers/uart/loopback.c          |  72 ++++++
>
> Why not just put this in drivers/tty/uart/ ?

Because it has nothing to do with the tty layer. If anything, I think
the direction would be move drivers/tty/serial/ to drivers/uart/
(didn't they used to be in drivers/serial/? :)) i'm not proposing we
do that though.

Rob
