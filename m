From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Tue, 10 Oct 2017 09:08:47 +0200
Message-ID: <20171010070847.GH4269@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151934.GJ2618@localhost>
 <20171007225311.lvli7rkhv3bebq2j@earth>
 <20171009073526.GL2618@localhost>
 <20171009085534.c5smytfgckyx7mqy@earth>
 <20171009090835.GQ2618@localhost>
 <E19C0643-85AA-4E80-BCDC-0C01EC0F88C2@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E19C0643-85AA-4E80-BCDC-0C01EC0F88C2-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 09, 2017 at 08:09:19PM +0200, Marcel Holtmann wrote:
> Hi Johan,
> 
> >>>>>> UART devices is expected to be enumerated by SerDev subsystem.
> >>>>>> 
> >>>>>> During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> >>>>>> enumerated, allowing them to be enumerated by their respective parents.
> >>>>>> 
> >>>>>> Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
> >>>>>> devices on serial buses (SPI, I2C or UART).
> >>>>>> 
> >>>>>> On Macs an empty ResourceTemplate is returned for uart slaves.
> >>>>>> Instead the device properties "baud", "parity", "dataBits", "stopBits" are
> >>>>>> provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> >>>>>> 
> >>>>>> Signed-off-by: Frédéric Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>>> 
> >>>>> So just to reiterate what I just mentioned in a comment to one of Hans's
> >>>>> hci_bcm patches:
> >>>>> 
> >>>>> This one would silently break PM for such devices on any system which
> >>>>> does not have serdev enabled (as the corresponding platform devices
> >>>>> would no longer be registered). And with serdev enabled, hciattach
> >>>>> (btattach) would start failing as the tty device would no longer be
> >>>>> registered (but I assume everyone is aware of that, and fine with it, by
> >>>>> now).
> >>>>> 
> >>>>> Perhaps the hci_bcm driver should start depending on
> >>>>> SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?
> >>>> 
> >>>> ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly,
> >>>> since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented
> >>>> for serdev. If any other controller is implemented that one could
> >>>> also be used.
> >>> 
> >>> Not for hci_bcm, right? This particular driver specifically depends on
> >>> SERIAL_DEV_CTRL_TTYPORT for the ACPI devices and not just any (future)
> >>> serdev controller (or currently working systems soon breaks silently).
> >>> 
> >>> I don't think the same is true for the DT case where we do not already
> >>> have child nodes defined in firmware (and in fact, this driver did not
> >>> really support DT before serdev).
> >> 
> >> The serdev ACPI support has been added to the core and not to
> >> the ttyport and the hci_bcm driver only uses functions from the
> >> core. As far as I can see the ACPI part would also work fine with
> >> a different serdev controller.
> > 
> > Indeed, but you need SERIAL_DEV_CTRL_TTYPORT to avoid silently breaking
> > current ACPI setups which breaks when this patch is applied (as these
> > devices all hang off of common serial ports managed by serial core).
> > 
> >> Of course DT and ACPI currently require SERIAL_DEV_CTRL_TTYPORT,
> >> since it's the only serdev controller implementation. Also it
> >> covers most use cases. When SERIAL_DEV_BUS is selected it's
> >> very likely, that you also want SERIAL_DEV_CTRL_TTYPORT.
> > 
> >>>> I wonder if we should just hide SERIAL_DEV_CTRL_TTYPORT and enable
> >>>> it together with SERDEV. I suspect that we won't see any other
> >>>> controller (it would be a UART device, that is not registered as
> >>>> tty device) in the next few years and the extra option seems to
> >>>> confuse people.
> >>> 
> >>> I agree that it is somewhat confusing. But now that we have both,
> >>> perhaps simply having SERIAL_DEV_CTRL_TTYPORT default to "y" when
> >>> SERIAL_DEV_BUS is selected could be a compromise. The Kconfig entry
> >>> might need to be amended as well (e.g. if only to mention that you
> >>> need to select a controller as well).
> >> 
> >> I think we should at least add a default "y" if SERIAL_DEV_BUS.
> > 
> > I'm preparing a patch.
> 
> yes, please prepare a patch since the discussion spans multiple email
> threads now. Lets get this back on track and find a patch that we are
> all happy with.

I submitted a patch amending the serdev Kconfig entries and making
SERIAL_DEV_CTRL_TTYPORT default to Y when serdev support has been
chosen.

While that hopefully reduces the confusion regarding the Kconfig options
somewhat, it's not really a fix for the potential silent hci_bcm
regression that could result from this patch.

[ The problem being that hci-attach would still succeed, but PM would be
broken, when SERIAL_DEV_CTRL_TTYPORT is not set. ]

I mentioned that making HCI_BCM depend on SERIAL_DEV_CTRL_TTYPORT might
be used to avoid this situation, although it is on some level is
conceptually wrong to describe runtime dependencies in Kconfig (cf.
having a USB device driver, depend on a particular host controller
rather than just USB support).

I'll write something like that up in a patch for Bluetooth and you can
decide if you want to apply it to remedy this particular situation,
though.

Johan
