From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Mon, 22 Jan 2018 13:33:26 +0200
Message-ID: <1516620806.7000.1165.camel@linux.intel.com>
References: <20180121214645.15004-1-hdegoede@redhat.com>
         <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
         <769dd32b-425e-3002-50b5-0d3c707706d4@redhat.com>
         <1516614127.7000.1152.camel@linux.intel.com>
         <0160ba20-9dc9-9921-ab12-3ac58b33e9ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <0160ba20-9dc9-9921-ab12-3ac58b33e9ae@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-01-22 at 12:27 +0100, Hans de Goede wrote:
> On 22-01-18 10:42, Andy Shevchenko wrote:
> > On Mon, 2018-01-22 at 09:23 +0100, Hans de Goede wrote:
> > > On 22-01-18 03:24, Marcel Holtmann wrote:

> > > Andy, I see that you added support for bcm bluetooth over a tty
> > > using
> > > platform_data instead of ACPI enumeration. Can you change the code
> > > instantiating the device to instead instantiate a serdev, so that
> > > we
> > > kill the platform device support in hci_bcm.c and so that users
> > > don't
> > > need to do a btattach, but instead the kernel will do the attach
> > > itself
> > > and things will just work ?
> > 
> > I'm sorry, I can't do this soon, other more priority tasks in a
> > pocket.
> > 
> > The instantiation of the driver is happened in
> > arch/x86/platform/intel-
> > mid/device_libs/platform_bt.c
> > 
> > I would help with review of any patches till I would able to look at
> > it
> > myself.
> 
> If I manage to come up with patches do you have hardware and time to
> test?

Yes and I would find half an hour for sure.

> First point of order to get this working as serdev I think is to
> modify drivers/tty/serdev/core.c a and then the
> serdev_controller_add()
> function to somehow recognize the serial port in question, so
> something akin to the of_serdev_register_devices(ctrl) /
> acpi_serdev_register_devices(ctrl) functions for platform_devs,
> assuming
> the tty-parent-dev on the Edison SOM is a platform_dev ?

tty parent is PCI device there.

> Anyways it looks like this will be really hard to do without access
> to the hardware.

I can do a BAT.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
