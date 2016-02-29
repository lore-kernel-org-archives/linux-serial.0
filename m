From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v6] serial: support for 16550A serial ports on LP-8x4x
Date: Mon, 29 Feb 2016 16:03:15 +0300
Message-ID: <1456750995.23036.87.camel@gmail.com>
References: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
	 <1456589675-25377-1-git-send-email-ynvich@gmail.com>
	 <1456741786.13244.167.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456741786.13244.167.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Mans Rullgard <mans@mansr.com>, Scott Wood <scottwood@freescale.com>, Joachim Eastwood <manabian@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-02-29 at 12:29 +0200, Andy Shevchenko wrote:
> On Sat, 2016-02-27 at 19:14 +0300, Sergei Ianovich wrote:
> > +struct lp8841_serial_data {
> > +	int			line;
> > +	void			*ios_mem;
>=20
> __iomem

OK

> > +};
>=20
> > +	if (termios->c_cflag & CSTOPB)
> > +		len++;
> > +	if (termios->c_cflag & PARENB)
> > +		len++;
> > +	if (!(termios->c_cflag & PARODD))
> > +		len++;
> > +#ifdef CMSPAR
> > +	if (termios->c_cflag & CMSPAR)
> > +		len++;
> > +#endif
> > +
> > +	len -=3D 9;
>=20
> If you have 5 bit mode, no parity, 1/1.5 stop bits, you may end up
> with
> negative value here. Am I right? If so, is it expected?
>=20
> > +	len &=3D 3;
> > +	len <<=3D 3;

I haven't tested this mode. I am pretty sure it will fail. There is
also no support for speeds higher than 115200.

CS7 and CS8 at speeds up to 115200 work well.

However, there is no way to report errors from=C2=A0set_termios(). Shou=
ld
anything be done about those limitations?

> +	mmres =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mires =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	if (!mmres || !mires)
> > +		return -ENODEV;
>=20
> No need to check mires here, devm_ioremap_resource() will take care
> about.

OK

> > +	data->ios_mem =3D devm_ioremap_resource(&pdev->dev,
> > > > mires);
> > +	if (!data->ios_mem)
> > +		return -EFAULT;
>=20
> You have to propagate the actual error code from
> devm_ioremap_resource().

OK

> > +
> > +	uart.port.iotype =3D UPIO_MEM;
> >=20
>=20
> > +	uart.port.mapbase =3D mmres->start;
> > +	uart.port.iobase =3D mmres->start;
>=20
> I'm not sure about this. If you ask for UPIO_MEM why do you need to
> fill iobase?
> And I suppose iobase can't hold (at the end inb/outb calls) big port
> numbers anyway (16 bit on x86, for example).

There is no need for iobase. I'll remove that line.
