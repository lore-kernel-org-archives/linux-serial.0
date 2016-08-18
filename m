From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 12:30:32 +0200
Message-ID: <FC1D6B2F-E06B-4D8F-90BA-4D6F20F2507A@holtmann.org>
References: <20160818011445.22726-1-robh@kernel.org> <20160818102208.GA20476@kroah.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818102208.GA20476@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Loic Poulain <loic.poulain@intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

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
>>  hoping all that complexity is from the tty layer and not needed here.
> 
> It should be.
> 
>> - Split out the controller for uart_ports into separate driver. Do we see
>>  a need for controller drivers that are not standard serial drivers?
> 
> What do you mean by "controller" drivers here?  I didn't understand them
> in the code.
> 
>> - Implement/test the removal paths
>> - Fix the receive callbacks for more than character at a time (i.e. DMA)
>> - Need better receive buffering than just a simple circular buffer or
>>  perhaps a different receive interface (e.g. direct to client buffer)?
> 
> Why?  Is the code as-is slow?
> 
>> - Test with other UART drivers
>> - Convert a real driver/line discipline over to UART bus.
> 
> That's going to be the real test, I recommend trying that as soon as
> possible as it will show where the real pain points are :)

maybe we can get the Intel LnP driver ported over and see how that one works out. It is one of the more complex ones when it comes to bootloader and firmware loading. Maybe Loic can take a stab at this. We would then also see how we can map the ACPI tables into a driver.

>> Before I spend more time on this, I'm looking mainly for feedback on the
>> general direction and structure (the interface with the existing serial
>> drivers in particular).
> 
> Yes, I like the idea (minor nit, you still have SPMI in a lot of places
> instead of UART), so I recommend keeping going with it.
> 
>> drivers/uart/Kconfig             |  17 ++
>> drivers/uart/Makefile            |   3 +
>> drivers/uart/core.c              | 458 +++++++++++++++++++++++++++++++++++++++
>> drivers/uart/loopback.c          |  72 ++++++
> 
> Why not just put this in drivers/tty/uart/ ?

Is it really then a TTY at all. Would be the UART become the basic core for a TTY? Having tty/uart/ seems a bit backward. Then again, it is just a directory name ;)

Regards

Marcel
