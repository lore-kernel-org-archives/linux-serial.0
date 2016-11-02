From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCHv2 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC
 (was: BT / serial regression introduced during the recent 4.9-rc1 merge?)
Date: Wed, 2 Nov 2016 10:37:02 +0200
Message-ID: <20161102083702.GC11523@kuha.fi.intel.com>
References: <1476815643.1658.3.camel@gmail.com>
 <1478019507.1676.23.camel@gmail.com>
 <CAJZ5v0jsPqtVgUs2wzyOSBh9+S7ksLFVwYzb4t7wEEyCUbsnzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jsPqtVgUs2wzyOSBh9+S7ksLFVwYzb4t7wEEyCUbsnzg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, =?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kefeng Wang <wangkefeng.wang@huawei.com>, Feng Kan <fkan@apm.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Wed, Nov 02, 2016 at 04:49:42AM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 1, 2016 at 5:58 PM, Jérôme de Bretagne
> <jerome.debretagne@gmail.com> wrote:
> > Hi Heikki, Andy, Greg, Rafael,
> >
> > I've detected a regression on my Lenovo ThinkPad 8 tablet introduced during
> > 4.9-rc1, preventing the built-in Bluetooth Broadcom chipset from properly
> > initializing, with many timeout messages in dmesg like these:
> >    "serial8250_interrupt: WXYZ callbacks suppressed"
> >    "serial8250: too much work for irq39"
> > cf. my earlier report on linux-bluetooth at the very end for reference.

Jérôme! Could you send us acpidump output and your kernel
configuration.

> > After a long git bisect, I've found the commit that's triggering the issue:
> >
> > commit 20a875e2e86e73d13ec256781a7d55a7885868ec
> > Author: Heikki Krogerus <heikki.krogerus@xxxxxxxxxxxxxxx>
> > Date:   Tue Aug 23 11:33:28 2016 +0300
> >
> >     serial: 8250_dw: Add quirk for APM X-Gene SoC
> >
> >     The APM X-Gene SoC UART is the only board that still needs
> >     the hard-coded values, so handle it separately in
> >     dw8250_quirks(). The other ACPI platforms are able to
> >     provide the values with device properties.
> >
> >     Signed-off-by: Heikki Krogerus <heikki.krogerus@xxxxxxxxxxxxxxx>
> >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@xxxxxxxxxxxxxxx>
> >     Acked-by: Greg Kroah-Hartman <gregkh@xxxxxxxxxxxxxxxxxxx>
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@xxxxxxxxx>
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c
> > b/drivers/tty/serial/8250/8250_dw.c
> > index e199696..5c0c123 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -298,12 +298,17 @@ static void dw8250_quirks(struct uart_port *p, struct
> > dw8250_data *data)
> >                         p->serial_out = dw8250_serial_out32be;
> >                 }
> >         } else if (has_acpi_companion(p->dev)) {
> > -               p->iotype = UPIO_MEM32;
> > -               p->regshift = 2;
> > -               p->serial_in = dw8250_serial_in32;
> > +               const struct acpi_device_id *id;
> > +
> > +               id = acpi_match_device(p->dev->driver->acpi_match_table,
> > +                                      p->dev);
> > +               if (id && !strcmp(id->id, "APMC0D08")) {
> > +                       p->iotype = UPIO_MEM32;
> > +                       p->regshift = 2;
> > +                       p->serial_in = dw8250_serial_in32;
> > +                       data->uart_16550_compatible = true;
> > +               }
> >                 p->set_termios = dw8250_set_termios;
> > -               /* So far none of there implement the Busy Functionality */
> > -               data->uart_16550_compatible = true;
> >         }
> >
> >         /* Platforms with iDMA */
> >
> >
> > This is fully reproducible on my end: removing this specific patch gets rid
> > of the issue; with the patch applied, Bluetooth simply doesn't work anymore.
> >
> > As opposed to the commit description, it seems that the Lenovo ThinkPad 8
> > still needs the original hard-coded values currently (even if it could be
> > possible to provide them in another way in the future, if I interpret the
> > commit message the right way).
> >
> > Could this patch be reverted for the moment to remove the regression, until
> > a proper fix is found?
> 
> Heikki, I don't think anything depends on this commit, is that correct?

Unfortunately we can't fix the values for every UART that has ACPI
companion like we did before anymore.

There is at least one new platform, that the driver supports, which
does not have the Designware UART in this "16550 compatible" mode, and
I guess it's possible that there are others as well. And I guess the
other values can also be what ever on those platforms.

Jérôme, can you test if using the quirk on Baytrails works:

@@ -302,7 +302,8 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 
                id = acpi_match_device(p->dev->driver->acpi_match_table,
                                       p->dev);
-               if (id && !strcmp(id->id, "APMC0D08")) {
+               if (id && (!strcmp(id->id, "APMC0D08") ||
+                   !strcmp(id->id, "80860F0A"))) {
                        p->iotype = UPIO_MEM32;
                        p->regshift = 2;
                        p->serial_in = dw8250_serial_in32;

Please note that this really is not a fix, not even a temporary one
for this issue. There are a lot of Baytrails on the market. I just
want to make sure there really is a problem delivering those values as
device properties with your board.


Thanks,

-- 
heikki
