From: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 01 Mar 2016 19:25:04 +0300
Message-ID: <1456849504.23036.108.camel@gmail.com>
References: <1456589675-25377-1-git-send-email-ynvich@gmail.com>
	 <1456781209-11390-1-git-send-email-ynvich@gmail.com>
	 <1456830401.13244.189.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456830401.13244.189.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:SERIAL DRIVERS" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-03-01 at 13:06 +0200, Andy Shevchenko wrote:
> On Tue, 2016-03-01 at 00:26 +0300, Sergei Ianovich wrote:
> > The patch adds support for 3 additional LP-8x4x built-in serial
> > ports.
> >=20
> > The device can also host up to 8 extension cards with 4 serial
> > ports
> > on each card for a total of 35 ports. However, I don't have
> > the hardware to test extension cards, so they are not supported,
> > yet.
> >=20
> > Signed-off-by: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Reviewed-by: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> Few more comments, mostly about style.
>=20
> > +static void lp8841_serial_set_termios(struct uart_port *port,
> > +		struct ktermios *termios, struct ktermios *old)
> > +{
> > +#ifdef BOTHER
> > +	unsigned int cbaud;
> > +#endif
> > +	unsigned int baud;
> > +	unsigned int len;
>=20
> Since you are writing this to the register at the end maybe=C2=A0
> =C2=A0- unsigned int -> u8 (write*b* =E2=80=94 exactly one byte)
> =C2=A0- len -> value (it's not only about data length)
>=20
> > +	unsigned int old_csize =3D old ? old->c_cflag & CSIZE : CS8;
> > +	struct lp8841_serial_data *data =3D port->private_data;
> > +
> > +	/* We only support CS7 and CS8 */
> > +	while ((termios->c_cflag & CSIZE) !=3D CS7 &&
> > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(termios->c_cflag & CSI=
ZE) !=3D CS8) {
> > +		termios->c_cflag &=3D ~CSIZE;
> > +		termios->c_cflag |=3D old_csize;
> > +		old_csize =3D CS8;
> > +	}
> > +
> > +	serial8250_do_set_termios(port, termios, old);
> > +
> > +	if ((termios->c_cflag & CSIZE) =3D=3D CS7)
> > +		len =3D 9;
> > +	else
> > +		len =3D 10;
> > +
> > +	if (termios->c_cflag & CSTOPB)
> > +		len++;
>=20
> > +	if (termios->c_cflag & PARENB)
> > +		len++;
> > +	if (!(termios->c_cflag & PARODD))
> > +		len++;
> > +#ifdef CMSPAR
> > +	if (termios->c_cflag & CMSPAR)
> > +		len++;
> > +#endif
>=20
> I don't know if someone likes it or not (up to you), but for me looks
> better to have ternary operators here:
>=20
> value +=3D (termios->c_cflag & CSTOPB) ? 1 : 0;
> value +=3D (termios->c_cflag & PARENB) ? 1 : 0;
> value +=3D (termios->c_cflag & PARODD) ? 0 : 1;
>=20
> #ifdef CMSPAR
> value +=3D (termios->c_cflag & CMSPAR) ? 1 : 0;
> #endif
>=20
> > +	len -=3D 9;
>=20
> This one could be part of previous evaluation:
> =C2=A0value =3D (termios->c_cflag & CSIZE) =3D=3D CS7 ? 0 : 1;

Great point.

> > +	len &=3D 3;
> > +	len <<=3D 3;
>=20
> Perhaps to define magic number (e.g. LP8841_DATA_LEN_SHIFT).

OK

> > +
> > +	baud =3D tty_termios_baud_rate(termios);
> > +
> > +#ifdef BOTHER
> > +	/* We only support fixed rates */
> > +	cbaud =3D termios->c_cflag & CBAUD;
> > +
> > +	if (cbaud =3D=3D BOTHER) {
> > +		termios->c_cflag &=3D ~BOTHER;
> > +
> > +		/* Don't rewrite B0 */
> > +		if (baud) {
> > +			tty_termios_encode_baud_rate(termios,
> > baud,
> > baud);
> > +			baud =3D tty_termios_baud_rate(termios);
> > +
> > +			/* Set sane default speed if we get 0 */
> > +			if (!baud) {
> > +				baud =3D 9600;
>=20
> > +				tty_termios_encode_baud_rate(termi
> > os
> > ,
> > +						baud, baud);
>=20
> I think you can call this unconditionally together with case >
> 115200.

The calls are orthogonal. This one deals with the case when BOTHER is
defined and set, and we have non-zero rate with BOTHER, but we have
zero rate after BOTHER is cleared. So we set 9600 as a sane default
speed.

> > +			}
> > +		}
> > +	}
> > +#endif
> > +
> > +	/* We only support up to 115200 */
> > +	if (baud > 115200) {
> > +		baud =3D 115200;
> > +		tty_termios_encode_baud_rate(termios, baud, baud);
> > +	}

This one deals with the case when the rate is over 115200. If the
previous case has been triggered, this one won't be.

> Btw, can we use uart_get_baud_rate() here?

uart_get_baud_rate() has already been called
in=C2=A0serial8250_do_set_termios(). uart_get_baud_rate()
calls=C2=A0tty_termios_encode_baud_rate(). uart_get_baud_rate() won't h=
elp
us if BOTHER is set. Once BOTHER is cleared, we don't need any special
processing of uart_get_baud_rate().

> > +static int lp8841_serial_probe(struct platform_device *pdev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct uart_8250_port uart =3D {};
>=20
> {0}

---
drivers/tty/serial/8250/8250_lp8841.c: In function 'lp8841_serial_probe=
':
drivers/tty/serial/8250/8250_lp8841.c:124:32: warning: excess elements =
in struct initializer
=C2=A0 struct uart_8250_port uart =3D {0};
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
drivers/tty/serial/8250/8250_lp8841.c:124:32: note: (near initializatio=
n for 'uart.port.lock.<anonymous>.rlock.raw_lock')
---

Zero triggers a warning. I'll use memset().

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct lp8841_serial_data *data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *mmres, *mires;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mmres =3D platform_get_resource(pdev=
, IORESOURCE_MEM, 0);
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mires =3D platform_get_resource(pdev=
, IORESOURCE_MEM, 1);
>=20
> Perhaps move it down to be closer to devm_ioremap_resource() call.

OK

Thanks for lightning fast reviews. I'll resubmit v8 if there is no
objections to the points above.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
