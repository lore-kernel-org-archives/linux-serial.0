From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v6] serial: support for 16550A serial ports on LP-8x4x
Date: Mon, 29 Feb 2016 12:29:46 +0200
Message-ID: <1456741786.13244.167.camel@linux.intel.com>
References: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
	 <1456589675-25377-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456589675-25377-1-git-send-email-ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:SERIAL DRIVERS" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sat, 2016-02-27 at 19:14 +0300, Sergei Ianovich wrote:
> The patch adds support for 3 additional LP-8x4x built-in serial
> ports.
>=20
> The device can also host up to 8 extension cards with 4 serial ports
> on each card for a total of 35 ports. However, I don't have
> the hardware to test extension cards, so they are not supported, yet.

My comments below.
After addressing them:
Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> +++ b/drivers/tty/serial/8250/8250_lp8841.c
> @@ -0,0 +1,166 @@
> +/*=C2=A0=C2=A0linux/drivers/tty/serial/8250/8250_lp8841.c
> + *
> + *=C2=A0=C2=A0Support for 16550A serial ports on ICP DAS LP-8841
> + *
> + *=C2=A0=C2=A0Copyright (C) 2013 Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + *=C2=A0=C2=A0This program is free software; you can redistribute it=
 and/or
> modify
> + *=C2=A0=C2=A0it under the terms of the GNU General Public License v=
ersion 2
> as
> + *=C2=A0=C2=A0published by the Free Software Foundation.
> + */
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/serial_8250.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +struct lp8841_serial_data {
> +	int			line;
> +	void			*ios_mem;

__iomem

> +};

> +	if (termios->c_cflag & CSTOPB)
> +		len++;
> +	if (termios->c_cflag & PARENB)
> +		len++;
> +	if (!(termios->c_cflag & PARODD))
> +		len++;
> +#ifdef CMSPAR
> +	if (termios->c_cflag & CMSPAR)
> +		len++;
> +#endif
> +
> +	len -=3D 9;

If you have 5 bit mode, no parity, 1/1.5 stop bits, you may end up with
negative value here. Am I right? If so, is it expected?

> +	len &=3D 3;
> +	len <<=3D 3;

> +	writeb(len, data->ios_mem);
> +
> +}


> +static int lp8841_serial_probe(struct platform_device *pdev)
> +{
> +	struct uart_8250_port uart =3D {};
> +	struct lp8841_serial_data *data;
> +	struct resource *mmres, *mires;
> +	int ret;
> +
> +	mmres =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mires =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!mmres || !mires)
> +		return -ENODEV;

No need to check mires here, devm_ioremap_resource() will take care
about.

> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ios_mem =3D devm_ioremap_resource(&pdev->dev, mires);
> +	if (!data->ios_mem)
> +		return -EFAULT;

You have to propagate the actual error code from
devm_ioremap_resource().

> +
> +	uart.port.iotype =3D UPIO_MEM;
>=20

> +	uart.port.mapbase =3D mmres->start;
> +	uart.port.iobase =3D mmres->start;

I'm not sure about this. If you ask for UPIO_MEM why do you need to
fill iobase?
And I suppose iobase can't hold (at the end inb/outb calls) big port
numbers anyway (16 bit on x86, for example).

> +	uart.port.regshift =3D 1;
> +	uart.port.irq =3D platform_get_irq(pdev, 0);
> +	uart.port.flags =3D UPF_IOREMAP;
> +	uart.port.dev =3D &pdev->dev;
> +	uart.port.uartclk =3D 14745600;
> +	uart.port.set_termios =3D lp8841_serial_set_termios;
> +	uart.port.private_data =3D data;
> +
> +	ret =3D serial8250_register_8250_port(&uart);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->line =3D ret;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static int lp8841_serial_remove(struct platform_device *pdev)
> +{
> +	struct lp8841_serial_data *data =3D
> platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver lp8841_serial_driver =3D {
> +	.probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 lp8841_serial_probe,
> +	.remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D lp=
8841_serial_remove,
> +
> +	.driver		=3D {
> +		.name	=3D "uart-lp8841",
> +		.of_match_table =3D lp8841_serial_dt_ids,
> +	},
> +};

--=20
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
