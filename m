From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / scan: Fix enumeration for special UART devices
Date: Mon, 9 Oct 2017 11:08:35 +0200
Message-ID: <20171009090835.GQ2618@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-3-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151934.GJ2618@localhost>
 <20171007225311.lvli7rkhv3bebq2j@earth>
 <20171009073526.GL2618@localhost>
 <20171009085534.c5smytfgckyx7mqy@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171009085534.c5smytfgckyx7mqy@earth>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Johan Hovold <johan@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, robh@kernel.org, marcel@holtmann.org, loic.poulain@gmail.com, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 09, 2017 at 10:55:34AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 09, 2017 at 09:35:26AM +0200, Johan Hovold wrote:
> > On Sun, Oct 08, 2017 at 12:53:11AM +0200, Sebastian Reichel wrote:
> > > On Sat, Oct 07, 2017 at 05:19:34PM +0200, Johan Hovold wrote:
> > > > On Wed, Oct 04, 2017 at 10:51:30AM +0200, Frédéric Danis wrote:
> > > > > UART devices is expected to be enumerated by SerDev subsystem.
> > > > > 
> > > > > During ACPI scan, serial devices behind SPI, I2C or UART buses are not
> > > > > enumerated, allowing them to be enumerated by their respective parents.
> > > > > 
> > > > > Rename *spi_i2c_slave* to *serial_bus_slave* as this will be used for serial
> > > > > devices on serial buses (SPI, I2C or UART).
> > > > > 
> > > > > On Macs an empty ResourceTemplate is returned for uart slaves.
> > > > > Instead the device properties "baud", "parity", "dataBits", "stopBits" are
> > > > > provided. Add a check for "baud" in acpi_is_serial_bus_slave().
> > > > > 
> > > > > Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> > > > 
> > > > So just to reiterate what I just mentioned in a comment to one of Hans's
> > > > hci_bcm patches:
> > > > 
> > > > This one would silently break PM for such devices on any system which
> > > > does not have serdev enabled (as the corresponding platform devices
> > > > would no longer be registered). And with serdev enabled, hciattach
> > > > (btattach) would start failing as the tty device would no longer be
> > > > registered (but I assume everyone is aware of that, and fine with it, by
> > > > now).
> > > > 
> > > > Perhaps the hci_bcm driver should start depending on
> > > > SERIAL_DEV_CTRL_TTYPORT when ACPI is enabled?
> > > 
> > > ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly,
> > > since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented
> > > for serdev. If any other controller is implemented that one could
> > > also be used.
> > 
> > Not for hci_bcm, right? This particular driver specifically depends on
> > SERIAL_DEV_CTRL_TTYPORT for the ACPI devices and not just any (future)
> > serdev controller (or currently working systems soon breaks silently).
> > 
> > I don't think the same is true for the DT case where we do not already
> > have child nodes defined in firmware (and in fact, this driver did not
> > really support DT before serdev).
> 
> The serdev ACPI support has been added to the core and not to
> the ttyport and the hci_bcm driver only uses functions from the
> core. As far as I can see the ACPI part would also work fine with
> a different serdev controller.

Indeed, but you need SERIAL_DEV_CTRL_TTYPORT to avoid silently breaking
current ACPI setups which breaks when this patch is applied (as these
devices all hang off of common serial ports managed by serial core).

> Of course DT and ACPI currently require SERIAL_DEV_CTRL_TTYPORT,
> since it's the only serdev controller implementation. Also it
> covers most use cases. When SERIAL_DEV_BUS is selected it's
> very likely, that you also want SERIAL_DEV_CTRL_TTYPORT.

> > > I wonder if we should just hide SERIAL_DEV_CTRL_TTYPORT and enable
> > > it together with SERDEV. I suspect that we won't see any other
> > > controller (it would be a UART device, that is not registered as
> > > tty device) in the next few years and the extra option seems to
> > > confuse people.
> > 
> > I agree that it is somewhat confusing. But now that we have both,
> > perhaps simply having SERIAL_DEV_CTRL_TTYPORT default to "y" when
> > SERIAL_DEV_BUS is selected could be a compromise. The Kconfig entry
> > might need to be amended as well (e.g. if only to mention that you
> > need to select a controller as well).
> 
> I think we should at least add a default "y" if SERIAL_DEV_BUS.

I'm preparing a patch.

> > And the bluetooth uart drivers already depend on SERIAL_DEV_BUS.
> 
> Yes and that's the correct dependency. They only need the serdev
> core and controller. The only reason they do not work without
> SERIAL_DEV_CTRL_TTYPORT is, that there won't be any serdev
> controller.

In general, yes. Again, the only exception would be hci_bcm to avoid
breaking current setups without people noticing.

> Note, that the default "y" if SERIAL_DEV_BUS in SERIAL_DEV_CTRL_TTYPORT's
> config entry is only a partial fix. There is still the problem,
> that SERIAL_DEV_CTRL_TTYPORT can only be enabled if SERIAL_DEV_BUS
> is configured builtin. This is a limitation of the ttyport
> implementation, that hooks into builtin TTY core code.

I'm not saying it's a fix, but it is a sane default. I'm preparing a
patch also amending the Kconfig entries, and we can take it from there.

Johan
