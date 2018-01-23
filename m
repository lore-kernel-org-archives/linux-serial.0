From: Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Wed, 24 Jan 2018 00:49:05 +0100
Message-ID: <2372310.Qjp4y9WXno@chromium>
References: <20180121214645.15004-1-hdegoede@redhat.com> <83ACB297-D092-4512-AC5B-3AF1137BE194@holtmann.org> <1516623321.7000.1175.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1516623321.7000.1175.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Hans de Goede <hdegoede@redhat.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

Op maandag 22 januari 2018 13:15:21 CET schreef Andy Shevchenko:
> On Mon, 2018-01-22 at 13:01 +0100, Marcel Holtmann wrote:
> > > > > Anyways it looks like this will be really hard to do without
> > > > > access
> > > > > to the hardware.
> > > > 
> > > > I can do a BAT.
> > > 
> > > Right, sorry I was not clear, when I was talking about hardware
> > > access I was not (not only) referring to testing.
> > > 
> > > The problem is that to figure out how to hook all this together
> > > will require poking around on the hardware, looking in sysfs,
> > > finding
> > > some id we can use in a pci_serdev_register_devices() to add to
> > > drivers/tty/serdev/core.c so that it only turns the serial port on
> > > the Edison into a serdev and not somewhere else, etc.
> > > 
> > > But thinking about this more, I too have higher priority items on
> > > my TODO list, so as much as I would like to see this cleaned up,
> > > lets shelf this for now until you have time to look into this.
> > > 
> > > When you do find time, if you've any questions I'm happy to help.
> > 
> > so in theory the Edison board has SFI. Problem is just that I am not
> > sure the SFI on the board is fully correct and contains enough
> > information to identify the serial port correctly.
> 
> Unfortunately SFI was so badly designed that board (hard coded) data is
> needed.
> 
> > If no one is willing to help port this over to serdev, then one option
> > is just to rip it out and see who complains.
> 
> Me in the first place. + I guess at least couple of users as of my
> knowledge. + Undefined amount of swindled users of Edison who is trying
> or already did a switch to vanilla kernel.
> 
> >  Or include a version that is trying its best and see who reports
> > 
> > issues and who helps to fix it. I am now regretting that I accepted
> > the Edison support in the first place, but sadly serdev was not yet
> > fully baked at that point.
> 
> +Cc: Ferry, who might be interested in the helping with it.

I would be glad to help. Keep in mind I'm not a kernel developer and need 
someone to hold my hand. All this in my free time of course, but can 
spend a few evenings per week.

Nevertheless I have an Edison dual booting 4.15.0-rc8 with poky pyro user 
space. So I can easily apply patches and test.

-- 
Ferry Toth
