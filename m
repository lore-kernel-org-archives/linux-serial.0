From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 01 Mar 2016 18:46:22 +0200
Message-ID: <1456850782.13244.208.camel@linux.intel.com>
References: <1456589675-25377-1-git-send-email-ynvich@gmail.com>
	 <1456781209-11390-1-git-send-email-ynvich@gmail.com>
	 <1456830401.13244.189.camel@linux.intel.com>
	 <1456849504.23036.108.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456849504.23036.108.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>, linux-kernel@vger.kernel.org
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, Mans Rullgard <mans@mansr.com>, Joachim Eastwood <manabian@gmail.com>, Scott Wood <scottwood@freescale.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-03-01 at 19:25 +0300, Sergei Ianovich wrote:
> On Tue, 2016-03-01 at 13:06 +0200, Andy Shevchenko wrote:
> > On Tue, 2016-03-01 at 00:26 +0300, Sergei Ianovich wrote:

> > > +	len &=3D 3;

Mask as well to be defined.

> > > +	len <<=3D 3;
> >=20
> > Perhaps to define magic number (e.g. LP8841_DATA_LEN_SHIFT).
>=20
> OK


> +	baud =3D tty_termios_baud_rate(termios);
> > > +
> > > +#ifdef BOTHER
> > > +	/* We only support fixed rates */

So, but if you support only fixed rates, why do you care about BOTHER
at all?

> > >=C2=A0
> > I think you can call this unconditionally together with case >
> > 115200.
>=20
> The calls are orthogonal. This one deals with the case when BOTHER is
> defined and set, and we have non-zero rate with BOTHER, but we have
> zero rate after BOTHER is cleared. So we set 9600 as a sane default
> speed.

> +
> > > +	/* We only support up to 115200 */
> > > +	if (baud > 115200) {
> > > +		baud =3D 115200;
> > > +		tty_termios_encode_baud_rate(termios, baud,
> > > baud);
> > > +	}
>=20
> This one deals with the case when the rate is over 115200. If the
> previous case has been triggered, this one won't be.

Yeah, but I meant to unconditionally call it just once here every time.
=C2=A0tty_termios_encode_baud_rate(termios, baud, baud);

> +static int lp8841_serial_probe(struct platform_device *pdev)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct uart_8250_port uart =3D {};
> >=20
> > {0}
>=20
> ---
> drivers/tty/serial/8250/8250_lp8841.c: In function
> 'lp8841_serial_probe':
> drivers/tty/serial/8250/8250_lp8841.c:124:32: warning: excess
> elements in struct initializer
> =C2=A0 struct uart_8250_port uart =3D {0};
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
> drivers/tty/serial/8250/8250_lp8841.c:124:32: note: (near
> initialization for 'uart.port.lock.<anonymous>.rlock.raw_lock')

Do you have any warning verbosity enabled? I see a lot of stuff like
this in the code

$ git grep -n 'struct .* =3D {0};' | wc -l
338

$ git grep -n 'struct .* =3D { \?0 \?};' | wc -l
550

( '=E2=80=A6 =3D { 0 };' included)

> ---
>=20
> Zero triggers a warning. I'll use memset().

Either will work.

> Thanks for lightning fast reviews. I'll resubmit v8 if there is no
> objections to the points above.

See above.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
