From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
Date: Thu, 19 Oct 2017 16:32:41 +0200
Message-ID: <20171019143241.GF5638@localhost>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
 <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
 <20171018145608.GB27138@kroah.com>
 <20171019142354.GE5638@localhost>
 <877ea825-eec5-d982-f962-d67067749009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877ea825-eec5-d982-f962-d67067749009-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Loic Poulain <loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 19, 2017 at 04:26:25PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 19-10-17 16:23, Johan Hovold wrote:
> > On Wed, Oct 18, 2017 at 04:56:08PM +0200, Greg Kroah-Hartman wrote:
> >> On Wed, Oct 18, 2017 at 04:46:05PM +0200, Frédéric Danis wrote:
> > 
> >>> Le 11/10/2017 à 20:32, Marcel Holtmann a écrit :
> > 
> >>>>>>> Add ACPI support for serial attached devices.
> >>>>>>>
> >>>>>>> Currently, serial devices are not set as enumerated during
> >>>>>>> ACPI scan for SPI or i2c buses (but not for UART). This
> >>>>>>> should also be done for UART serial devices.  I renamed
> >>>>>>> *spi_i2c_slave* to *serial_bus_slave* to reflect this.

> > I just realised that we cannot merge this series (the second acpi patch)
> > until the hci_intel driver gains serdev support or otherwise PM will
> > break for those devices.
> > 
> > Specifically, the hci_intel driver uses similar hacks as the hci_bcm
> > driver does for PM, so we need something like Hans's hci_bcm series also
> > for hci_intel before we can do the switch.
> 
> Hmm, I've never actually seen any hardware use an intel BT HCI connected
> to a serdev, but I guess people did not write that code for fun, so those
> do exist ?

At least that's what it looks like. 

It was added by Loic Poulain in commit 1ab1f239bf17 ("Bluetooth:
hci_intel: Add support for platform driver") two years ago and the
ACPI-match table has an entry for "INT33E1".

Johan
