From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Thu, 17 Dec 2015 16:50:29 +0200
Message-ID: <1450363829.30729.132.camel@linux.intel.com>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com>
	 <1450213494-21884-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>, linux-kernel@vger.kernel.org
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Burton <paul.burton@imgtec.com>, Joachim Eastwood <manabian@gmail.com>, Mans Rullgard <mans@mansr.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-12-16 at 00:04 +0300, Sergei Ianovich wrote:
> The patch adds support for 3 additional LP-8x4x built-in serial
> ports.
>=20
> The device can also host up to 8 extension cards with 4 serial ports
> on each card for a total of 35 ports. However, I don't have
> the hardware to test extension cards, so they are not supported, yet.
>=20

=46ew nitpicks, though everything looks okay.

> Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> CC: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> ---
> =C2=A0=C2=A0=C2=A0v4..v5
> =C2=A0=C2=A0=C2=A0* constify struct of_device_id
> =C2=A0=C2=A0=C2=A0* drop .owner from struct platform_driver
> =C2=A0=C2=A0=C2=A0* rewrite set_termios() baud rate hadnling as sugge=
sted by Alan
> Cox
>=20
> =C2=A0=C2=A0=C2=A0v3..v4
> =C2=A0=C2=A0=C2=A0* move DTS bindings to a different patch (8/21) as =
suggested by
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Heikki Krogerus
>=20
> =C2=A0=C2=A0=C2=A0v2..v3
> =C2=A0=C2=A0=C2=A0* no changes (except number 10/16 -> 12/21)
>=20
> =C2=A0=C2=A0=C2=A0v0..v2
> =C2=A0=C2=A0=C2=A0* register platform driver instead of platform devi=
ce
> =C2=A0=C2=A0=C2=A0* use device tree
> =C2=A0=C2=A0=C2=A0* use devm helpers where possible
>=20
> =C2=A0.../devicetree/bindings/serial/lp8x4x-serial.txt=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A035 +++++
> =C2=A0drivers/tty/serial/8250/8250_lp8x4x.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 168
> +++++++++++++++++++++
> =C2=A0drivers/tty/serial/8250/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0|=C2=A0=C2=A012 ++
> =C2=A0drivers/tty/serial/8250/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A04 files changed, 216 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/serial/lp8=
x4x-
> serial.txt
> =C2=A0create mode 100644 drivers/tty/serial/8250/8250_lp8x4x.c
>=20
> diff --git a/Documentation/devicetree/bindings/serial/lp8x4x-
> serial.txt b/Documentation/devicetree/bindings/serial/lp8x4x-
> serial.txt
> new file mode 100644
> index 0000000..5f9a4c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
> @@ -0,0 +1,35 @@
> +UART ports on ICP DAS LP-8x4x
> +
> +ICP DAS LP-8x4x contains three additional serial ports interfaced
> via
> +Analog Devices ADM213EA chips in addition to 3 serial ports on PXA
> CPU.
> +
> +Required properties:
> +- compatible : should be "icpdas,uart-lp8x4x"
> +
> +- reg : should provide 16 byte man IO memory region and 1 byte
> region for
> +	termios
> +
> +- interrupts : should provide interrupt
> +
> +- interrupt-parent : should provide a link to interrupt controller
> either
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0explicitly or implicitly from a pare=
nt node
> +
> +Examples (from pxa27x-lp8x4x.dts):
> +
> +		uart@9050 {
> +			compatible =3D "icpdas,uart-lp8x4x";
> +			reg =3D <0x9050 0x10
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x9030 0x02>;
> +			interrupt-parent =3D <&fpgairg>;
> +			interrupts =3D <13>;
> +			status =3D "okay";
> +		};
> +
> +		uart@9060 {
> +			compatible =3D "icpdas,uart-lp8x4x";
> +			reg =3D <0x9060 0x10
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x9032 0x02>;
> +			interrupt-parent =3D <&fpgairg>;
> +			interrupts =3D <14>;
> +			status =3D "okay";
> +		};
> diff --git a/drivers/tty/serial/8250/8250_lp8x4x.c
> b/drivers/tty/serial/8250/8250_lp8x4x.c
> new file mode 100644
> index 0000000..0e07220
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_lp8x4x.c
> @@ -0,0 +1,168 @@
> +/*=C2=A0=C2=A0linux/drivers/tty/serial/8250/8250_lp8x4x.c
> + *
> + *=C2=A0=C2=A0Support for 16550A serial ports on ICP DAS LP-8x4x
> + *
> + *=C2=A0=C2=A0Copyright (C) 2013 Sergei Ianovich <ynvich@gmail.com>
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
> +struct lp8x4x_serial_data {
> +	int			line;
> +	void			*ios_mem;
> +};
> +
> +static void lp8x4x_serial_set_termios(struct uart_port *port,
> +		struct ktermios *termios, struct ktermios *old)
> +{
> +	unsigned int len;
> +	unsigned int baud;
> +	struct lp8x4x_serial_data *data =3D port->private_data;
> +
> +	serial8250_do_set_termios(port, termios, old);
> +
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS5:
> +		len =3D 7;
> +		break;
> +	case CS6:
> +		len =3D 8;
> +		break;
> +	case CS7:
> +		len =3D 9;
> +		break;

> +	default:
> +	case CS8:

I would suggest to exchange those lines.

> +		len =3D 10;
> +		break;
> +	}
> +
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
> +	len &=3D 3;
> +	len <<=3D 3;

> +	/*
> +	=C2=A0* Ask the core to calculate the divisor for us.
> +	=C2=A0*/

Can it be one line?

> +	baud =3D tty_termios_baud_rate(termios);
> +
> +	switch (baud) {
> +	case 115200:
> +		len |=3D 7;
> +		break;
> +	case 57600:
> +		len |=3D 6;
> +		break;
> +	case 38400:
> +		len |=3D 5;
> +		break;
> +	case 19200:
> +		len |=3D 4;
> +		break;
> +	case 9600:
> +		len |=3D 3;
> +		break;
> +	case 4800:
> +		len |=3D 2;
> +		break;
> +	case 2400:
> +	default:
> +		len |=3D 1;
> +		break;
> +	};
> +	iowrite8(len, data->ios_mem);

writeb() ?

> +
> +}
> +
> +static const struct of_device_id lp8x4x_serial_dt_ids[] =3D {
> +	{ .compatible =3D "icpdas,uart-lp8x4x", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, lp8x4x_serial_dt_ids);
> +
> +static int lp8x4x_serial_probe(struct platform_device *pdev)
> +{
> +	struct uart_8250_port uart =3D {};
> +	struct lp8x4x_serial_data *data;
> +	struct resource *mmres, *mires, *irqres;
> +	int ret;
> +
> +	mmres =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mires =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	irqres =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!mmres || !mires || !irqres)
> +		return -ENODEV;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->ios_mem =3D devm_ioremap_resource(&pdev->dev, mires);
> +	if (!data->ios_mem)
> +		return -EFAULT;
> +
> +	uart.port.iotype =3D UPIO_MEM;
> +	uart.port.mapbase =3D mmres->start;
> +	uart.port.iobase =3D mmres->start;
> +	uart.port.regshift =3D 1;
> +	uart.port.irq =3D irqres->start;
> +	uart.port.flags =3D UPF_IOREMAP;
> +	uart.port.dev =3D &pdev->dev;
> +	uart.port.uartclk =3D 14745600;
> +	uart.port.set_termios =3D lp8x4x_serial_set_termios;
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
> +static int lp8x4x_serial_remove(struct platform_device *pdev)
> +{
> +	struct lp8x4x_serial_data *data =3D
> platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver lp8x4x_serial_driver =3D {
> +	.probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 lp8x4x_serial_probe,
> +	.remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D lp=
8x4x_serial_remove,
> +
> +	.driver		=3D {
> +		.name	=3D "uart-lp8x4x",
> +		.of_match_table =3D lp8x4x_serial_dt_ids,
> +	},
> +};
> +
> +module_platform_driver(lp8x4x_serial_driver);
> +
> +MODULE_AUTHOR("Sergei Ianovich");
> +MODULE_DESCRIPTION("8250 serial port module for LP-8x4x");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/Kconfig
> b/drivers/tty/serial/8250/Kconfig
> index 48b6253..00eb6b0 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -387,3 +387,15 @@ config SERIAL_8250_PXA
> =C2=A0	=C2=A0=C2=A0can enable its onboard serial ports by enabling th=
is
> option.
> =C2=A0
> =C2=A0	=C2=A0=C2=A0If you choose M here, the module name will be 8250=
_pxa.
> +
> +config SERIAL_8250_LP8X4X
> +	tristate "Support 16550A ports on ICP DAS LP-8x4x"
> +	depends on OF && SERIAL_8250 && SERIAL_8250_MANY_PORTS &&
> ARCH_PXA
> +	select LP8X4X_IRQ
> +	help
> +	=C2=A0=C2=A0In addition to serial ports on PXA270 SoC, LP-8x4x has =
1
> dual
> +	=C2=A0=C2=A0RS232/RS485 port, 1 RS485 port and 1 RS232 port.
> +
> +	=C2=A0=C2=A0Say N here, unless you plan to run this kernel on a LP-
> 8x4x system.
> +
> +	=C2=A0=C2=A0If you choose M here, the module name will be 8250_lp8x=
4x.
> diff --git a/drivers/tty/serial/8250/Makefile
> b/drivers/tty/serial/8250/Makefile
> index 7e54413..8bdbf40 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_SERIAL_8250_ACCENT)	+=3D
> 8250_accent.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_BOCA)		+=3D 8250_boca.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+=3D
> 8250_exar_st16c554.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_HUB6)		+=3D 8250_hub6.o
> +obj-$(CONFIG_SERIAL_8250_LP8X4X)	+=3D 8250_lp8x4x.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_FSL)		+=3D 8250_fsl.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_DW)		+=3D 8250_dw.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_EM)		+=3D 8250_em.o

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
