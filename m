From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne
        <jerome.debretagne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC
 (was: BT / serial regression introduced during the recent 4.9-rc1 merge?)
Date: Wed, 02 Nov 2016 14:52:12 +0100
Message-ID: <1478094732.1606.1.camel@gmail.com>
References: <1476815643.1658.3.camel@gmail.com>
         <1478019507.1676.23.camel@gmail.com>
         <CAJZ5v0jsPqtVgUs2wzyOSBh9+S7ksLFVwYzb4t7wEEyCUbsnzg@mail.gmail.com>
         <20161102083702.GC11523@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161102083702.GC11523-FZxXFokcWpatqXYlAKuG4QC/G2K4zDHf@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi again,

> > Heikki, I don't think anything depends on this commit, is that correct?
> 
> Unfortunately we can't fix the values for every UART that has ACPI
> companion like we did before anymore.
> 
> There is at least one new platform, that the driver supports, which
> does not have the Designware UART in this "16550 compatible" mode, and
> I guess it's possible that there are others as well. And I guess the
> other values can also be what ever on those platforms.
> 
> Jérôme, can you test if using the quirk on Baytrails works:
> 
> @@ -302,7 +302,8 @@ static void dw8250_quirks(struct uart_port *p, struct
> dw8250_data *data)
>  
>                 id = acpi_match_device(p->dev->driver->acpi_match_table,
>                                        p->dev);
> -               if (id && !strcmp(id->id, "APMC0D08")) {
> +               if (id && (!strcmp(id->id, "APMC0D08") ||
> +                   !strcmp(id->id, "80860F0A"))) {
>                         p->iotype = UPIO_MEM32;
>                         p->regshift = 2;
>                         p->serial_in = dw8250_serial_in32;

Compilation finished with that small modification applied: Bluetooth works
indeed in that case and I don't have the error messages in dmesg anymore.

> 
> Please note that this really is not a fix, not even a temporary one
> for this issue. There are a lot of Baytrails on the market. I just
> want to make sure there really is a problem delivering those values as
> device properties with your board.

I guess this confirms there is indeed a problem delivering those values as
devices properties on that specific Baytrail device at least.

Let me know if there is anything else useful I could share/test.

Thanks,
Jérôme
