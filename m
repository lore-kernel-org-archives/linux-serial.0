From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Wrong GIT author ? also bugs: serial: Add uart driver for
 i.MX23/28
Date: Tue, 12 Apr 2011 09:28:43 +0200
Message-ID: <20110412072843.GE7771@pengutronix.de>
References: <201103180302.p2I326tA020159@hera.kernel.org>
 <20110318112920.07148450@lxorguk.ukuu.org.uk>
 <20110329091456.GI30938@pengutronix.de>
 <20110329103335.7a5ff37d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110329103335.7a5ff37d@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, torvalds@linux-foundation.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 29, 2011 at 10:33:35AM +0100, Alan Cox wrote:
> > I don't understand how to do this and didn't find something like th=
at in
> > other drivers. (I checked amba-pl011.c and imx.c.) Also
> > Documentation/serial/driver doesn't describe this. (It is also sile=
nt
> > about CMSPAR and doesn't even advise to clear unsupported bits.)
> > Can you be a bit more verbose here?
>=20
> 8250.c is the best place to look.
>=20
> Basically on return from your routine the _hardware_ bits of the term=
ios
> struct should be the ones set.
>=20
> So eg if you only supported 8bit characters you'd wipe the CSx bits a=
nd
> set CS8.
>=20
> For the speed there is a helper so you probably want
>=20
>         /* Don't rewrite B0 */
>         if (tty_termios_baud_rate(termios))
>                 tty_termios_encode_baud_rate(termios, baud, baud);
OK, I will review the function to assert that the other bits are update=
d
accordingly.

> > @@ -286,6 +283,9 @@ static void mxs_auart_settermios(struct uart_po=
rt *u,
> >  {
> >  	u32 bm, ctrl, ctrl2, div;
> >  	unsigned int cflag, baud;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&u->lock, flags);
>=20
> Termios you don't need the lock - just the IRQ handler and you still
> really want the tty_port_tty_get()/tty_kref_put() if that wasn't alre=
ady
> dealt with.
If I look at 8250.c spin_lock_irqsave seems OK :-)

To be honest, it felt much better when a simpler driver than 8250 could
be used to copy from. Documentation/serial/driver (which is IMHO very
helpful) declares amba_pl011.c to be the reference implementation. It
uses neither tty_termios_encode_baud_rate nor
tty_port_tty_get()/tty_kref_put() :-(

Anyhow, I'll do my best to implement both requests.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
