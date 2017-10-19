From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Thu, 19 Oct 2017 16:23:54 +0200
Message-ID: <20171019142354.GE5638@localhost>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
 <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
 <20171018145608.GB27138@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171018145608.GB27138-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 18, 2017 at 04:56:08PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 18, 2017 at 04:46:05PM +0200, Frédéric Danis wrote:

> > Le 11/10/2017 à 20:32, Marcel Holtmann a écrit :

> > > > > > Add ACPI support for serial attached devices.
> > > > > > 
> > > > > > Currently, serial devices are not set as enumerated during
> > > > > > ACPI scan for SPI or i2c buses (but not for UART). This
> > > > > > should also be done for UART serial devices.  I renamed
> > > > > > *spi_i2c_slave* to *serial_bus_slave* to reflect this.
> > > > > > 
> > > > > > This needs Johan Hovold's "serdev: fix registration of
> > > > > > second slave" patch.
> > > > > In theory this series could go in through the acpi-tree
> > > > > without my fix. It would only affect an error case where an
> > > > > unlikely failure to register an ACPI serdev device, would
> > > > > prevent the tty-class device from being registered instead of
> > > > > the controller. That is, something we can live with until this
> > > > > all converges in 4.15-rc1 if needed.
> > > > > 
> > > > > That said, I think we should consider taking all serdev
> > > > > changes, and therefore also the ACPI patch, through the tty
> > > > > tree instead in order to avoid merge conflicts. Rafael?
> > > > OK
> > > > 
> > > > Please feel free to add
> > > > 
> > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > > 
> > > > to the ACPI core change.
> > > > 
> > > > And I will assume that this series will go in via the tty tree.
> > > you have to take these two patches now via the TTY tree now. In
> > > case you already marked them as someone else problem ;)

> > Is there any problem I missed with those patches?
> > Do I have to re-send them?
> 
> No, they are in my queue, still catching up...

I just realised that we cannot merge this series (the second acpi patch)
until the hci_intel driver gains serdev support or otherwise PM will
break for those devices.

Specifically, the hci_intel driver uses similar hacks as the hci_bcm
driver does for PM, so we need something like Hans's hci_bcm series also
for hci_intel before we can do the switch.

Hopefully there are no more of these...

Johan
