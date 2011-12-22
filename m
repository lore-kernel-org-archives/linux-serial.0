From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/efm32: add new driver
Date: Thu, 22 Dec 2011 09:57:06 +0100
Message-ID: <20111222085706.GD24496@pengutronix.de>
References: <1324479959-7343-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111221202847.4ffeba10@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111221202847.4ffeba10@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hello,

On Wed, Dec 21, 2011 at 08:28:47PM +0000, Alan Cox wrote:
> On Wed, 21 Dec 2011 16:05:59 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > note that ARCH_EFM32 isn't in mainline yet, so to be actually usabl=
e
> > some arch patches are needed.
>=20
> Start by running it through the CodingStyle scripts as I see a //
> comment in there 8)
oops

> > +static void efm32_usart_rx_chars(struct efm32_usart_port *efm_port=
)
> > +{
> > +	struct uart_port *port =3D &efm_port->port;
> > +	struct tty_struct *tty =3D port->state->port.tty;
>=20
> Needs to be using krefs and checking the tty is not NULL
> (tty_port_tty_get)
ah, I copied from mxs-auart. Will try to find a better example.=20
=20
> > +static void efm32_usart_set_termios(struct uart_port *port,
> > +		struct ktermios *new, struct ktermios *old)
> > +{
> > +	struct efm32_usart_port *efm_port =3D to_efm_port(port);
> > +	unsigned long flags;
> > +	unsigned baud;
> > +	u32 clkdiv;
> > +
> > +	/* no modem control lines */
> > +	new->c_cflag &=3D ~(HUPCL | CRTSCTS | CMSPAR);
>=20
> Minor item - HUPCL shouldn't get cleared - its a request for hangup
> behaviour not a port feature.
ah, I copied that from imx (in an if(0) though).
=20
> > +	/* currently only some features are implemented */
> > +	new->c_cflag &=3D ~CSIZE;
> > +	new->c_cflag |=3D CS8;
> > +	new->c_cflag |=3D CSTOPB;
> > +	new->c_cflag &=3D ~PARENB;
>=20
> If you can do CS8 without parity you can do CS7 with parity.
I sticked to the things I use and tested. According to the manual the
hardware can do 4 up to 16 data bits with and without parity :-)
=20
> > +	new->c_iflag =3D 0;
>=20
> This seems broken. Lots of the iflgs are user requests and stack
> properties not port features. For example you can do xon/xoff as its
> pure software. As far as I can see you should leave c_iflag alone.
ok.

I will send an update and fix the drivers I copied from.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
