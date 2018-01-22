From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Mon, 22 Jan 2018 14:15:21 +0200
Message-ID: <1516623321.7000.1175.camel@linux.intel.com>
References: <20180121214645.15004-1-hdegoede@redhat.com>
         <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
         <769dd32b-425e-3002-50b5-0d3c707706d4@redhat.com>
         <1516614127.7000.1152.camel@linux.intel.com>
         <0160ba20-9dc9-9921-ab12-3ac58b33e9ae@redhat.com>
         <1516620806.7000.1165.camel@linux.intel.com>
         <0cae9024-887a-45f7-7710-1684f9c0e54e@redhat.com>
         <83ACB297-D092-4512-AC5B-3AF1137BE194@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <83ACB297-D092-4512-AC5B-3AF1137BE194@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Hans de Goede <hdegoede@redhat.com>, Ferry Toth gmail <fntoth@gmail.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-01-22 at 13:01 +0100, Marcel Holtmann wrote:

> > > > Anyways it looks like this will be really hard to do without
> > > > access
> > > > to the hardware.
> > > 
> > > I can do a BAT.
> > 
> > Right, sorry I was not clear, when I was talking about hardware
> > access I was not (not only) referring to testing.
> > 
> > The problem is that to figure out how to hook all this together
> > will require poking around on the hardware, looking in sysfs,
> > finding
> > some id we can use in a pci_serdev_register_devices() to add to
> > drivers/tty/serdev/core.c so that it only turns the serial port on
> > the Edison into a serdev and not somewhere else, etc.
> > 
> > But thinking about this more, I too have higher priority items on
> > my TODO list, so as much as I would like to see this cleaned up,
> > lets shelf this for now until you have time to look into this.
> > 
> > When you do find time, if you've any questions I'm happy to help.
> 
> so in theory the Edison board has SFI. Problem is just that I am not
> sure the SFI on the board is fully correct and contains enough
> information to identify the serial port correctly.

Unfortunately SFI was so badly designed that board (hard coded) data is
needed.

> If no one is willing to help port this over to serdev, then one option
> is just to rip it out and see who complains.

Me in the first place. + I guess at least couple of users as of my
knowledge. + Undefined amount of swindled users of Edison who is trying
or already did a switch to vanilla kernel.

>  Or include a version that is trying its best and see who reports
> issues and who helps to fix it. I am now regretting that I accepted
> the Edison support in the first place, but sadly serdev was not yet
> fully baked at that point.

+Cc: Ferry, who might be interested in the helping with it.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
