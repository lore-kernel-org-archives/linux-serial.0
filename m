From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne
        <jerome.debretagne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC
 (was: BT / serial regression introduced during the recent 4.9-rc1 merge?)
Date: Tue, 01 Nov 2016 17:58:27 +0100
Message-ID: <1478019507.1676.23.camel@gmail.com>
References: <1476815643.1658.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476815643.1658.3.camel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Heikki, Andy, Greg, Rafael,

I've detected a regression on my Lenovo ThinkPad 8 tablet introduced during
4.9-rc1, preventing the built-in Bluetooth Broadcom chipset from properly
initializing, with many timeout messages in dmesg like these:
   "serial8250_interrupt: WXYZ callbacks suppressed"
   "serial8250: too much work for irq39"
cf. my earlier report on linux-bluetooth at the very end for reference.


After a long git bisect, I've found the commit that's triggering the issue:

commit 20a875e2e86e73d13ec256781a7d55a7885868ec
Author: Heikki Krogerus <heikki.krogerus@xxxxxxxxxxxxxxx>
Date:   Tue Aug 23 11:33:28 2016 +0300

    serial: 8250_dw: Add quirk for APM X-Gene SoC
    
    The APM X-Gene SoC UART is the only board that still needs
    the hard-coded values, so handle it separately in
    dw8250_quirks(). The other ACPI platforms are able to
    provide the values with device properties.
    
    Signed-off-by: Heikki Krogerus <heikki.krogerus@xxxxxxxxxxxxxxx>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@xxxxxxxxxxxxxxx>
    Acked-by: Greg Kroah-Hartman <gregkh@xxxxxxxxxxxxxxxxxxx>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@xxxxxxxxx>

diff --git a/drivers/tty/serial/8250/8250_dw.c
b/drivers/tty/serial/8250/8250_dw.c
index e199696..5c0c123 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -298,12 +298,17 @@ static void dw8250_quirks(struct uart_port *p, struct
dw8250_data *data)
                        p->serial_out = dw8250_serial_out32be;
                }
        } else if (has_acpi_companion(p->dev)) {
-               p->iotype = UPIO_MEM32;
-               p->regshift = 2;
-               p->serial_in = dw8250_serial_in32;
+               const struct acpi_device_id *id;
+
+               id = acpi_match_device(p->dev->driver->acpi_match_table,
+                                      p->dev);
+               if (id && !strcmp(id->id, "APMC0D08")) {
+                       p->iotype = UPIO_MEM32;
+                       p->regshift = 2;
+                       p->serial_in = dw8250_serial_in32;
+                       data->uart_16550_compatible = true;
+               }
                p->set_termios = dw8250_set_termios;
-               /* So far none of there implement the Busy Functionality */
-               data->uart_16550_compatible = true;
        }
 
        /* Platforms with iDMA */


This is fully reproducible on my end: removing this specific patch gets rid
of the issue; with the patch applied, Bluetooth simply doesn't work anymore.

As opposed to the commit description, it seems that the Lenovo ThinkPad 8
still needs the original hard-coded values currently (even if it could be
possible to provide them in another way in the future, if I interpret the
commit message the right way).

Could this patch be reverted for the moment to remove the regression, until
a proper fix is found?

Thanks,
Jérôme


> I've compiled the latest bluetooth-next branch and I'm facing what looks
> like a regression to me (still on a Lenovo ThinkPad 8 tablet): btattach
> doesn't properly initialize the Broadcom BCM2E55 chipset anymore. 
> 
> I'm getting various timeout messages in dmesg:
> 
> [   13.188057] Bluetooth: hci0 command 0xfc45 tx timeout
> [   16.093068] serial8250_interrupt: 4158 callbacks suppressed
> [   16.093072] serial8250: too much work for irq39
> [   16.094287] serial8250: too much work for irq39
> ...
> [   16.103868] serial8250: too much work for irq39
> [   21.100041] serial8250_interrupt: 4167 callbacks suppressed
> [   21.100044] serial8250: too much work for irq39
> ...
> [   21.222065] Bluetooth: hci0: BCM: failed to write clock (-110)
> [   23.238528] Bluetooth: hci0 command 0x0c03 tx timeout
> [   26.104253] serial8250_interrupt: 4165 callbacks suppressed
> [   26.104257] serial8250: too much work for irq39
> 
> which I never had before and Bluetooth never actually starts.
> 
> Bluetooth doesn't init with a kernel built with the latest commit from
> yesterday 526c86021e5102b8a4b5555b4196f7a19f44e2c4. 
> 
> I've gone back in time and it doesn't work either with a kernel built at 	
> e6445f52d9c8b0e6557a45fa7d0e8e088d430a8c "Merge tag 'usb-4.9-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb".
> 
> It still worked at commit a2f195a73eba807006fb0cb882ecb552c06eea00
> "bluetooth: bcm203x: don't print error when allocating urb fails" though,
> which was the last previous commit modifying files in drivers/bluetooth in
> the bluetooth-next branch.
> 
> I've attached the output of btmon when it used to work and one not working
> (prefixed with .e6445f5) if that may be useful.
> 
> I'll continue my investigation in my spare time, trying to bissect to find
> a while. I'll focus on patches touching the serial 8250 driver to start
> with, as there are only a few of them, but feel free to point me into a
> different direction if you have another idea or suggestion.
