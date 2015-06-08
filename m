From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
Date: Mon, 8 Jun 2015 10:14:48 +0100
Message-ID: <20150608091448.GT7557@n2100.arm.linux.org.uk>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150608064113.GX18985@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150608064113.GX18985-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, moorray3-5tc4TXWwyLM@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 08, 2015 at 08:41:13AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Mon, Jun 01, 2015 at 10:51:06AM +0530, Bhuvanchandra DV wrote:
> > The LPUART does not provide manual control of RTS/CTS signals,
> > those can only be controlled by the hardware directly. Therefore
> > manual control of those signals through mctrl can not be provided.
> > The current implementation enables/disables the automatic control,
> > which is not what mctrl should do, hence remove the incorrect
> > implementation.
> >=20
> > Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 63 +++++------------------------=
------------
> >  1 file changed, 7 insertions(+), 56 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/f=
sl_lpuart.c
> > index 08ce76f..532cfb7 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -822,64 +822,15 @@ static unsigned int lpuart32_tx_empty(struct =
uart_port *port)
> > =20
> >  static unsigned int lpuart_get_mctrl(struct uart_port *port)
> >  {
> > -	unsigned int temp =3D 0;
> > -	unsigned char reg;
> > -
> > -	reg =3D readb(port->membase + UARTMODEM);
> > -	if (reg & UARTMODEM_TXCTSE)
> > -		temp |=3D TIOCM_CTS;
> > -
> > -	if (reg & UARTMODEM_RXRTSE)
> > -		temp |=3D TIOCM_RTS;
> > -
> > -	return temp;
> >From reading the commit log I would expect that you only touch the
> set_mctrl function, but not get_mctrl. Assuming your code change is
> right, can you mention this in the commit log please? The bits
> UARTMODEM_TXCTSE and UARTMODEM_RXRTSE only control the automatic mode=
?

Dumb serial writers common fault #1 is to make get_mctrl return TIOCM_R=
TS
and/or TIOCM_DTR.  It should never return these.  This is a sure sign
that the serial writer doesn't know what they're doing, and doesn't
understand the interface they're implementing.  That's a good enough
reason IMHO to reject a driver prior to merging.

--=20
=46TTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps u=
p
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
