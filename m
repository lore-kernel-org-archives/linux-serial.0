From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial/efm32: add new driver
Date: Wed, 21 Dec 2011 20:28:47 +0000
Message-ID: <20111221202847.4ffeba10@bob.linux.org.uk>
References: <1324479959-7343-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3561 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab1LUUQT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Dec 2011 15:16:19 -0500
In-Reply-To: <1324479959-7343-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?ISO-8859-1?B?S2xlaW5lLUv2bmln?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, kernel@pengutronix.de

On Wed, 21 Dec 2011 16:05:59 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> note that ARCH_EFM32 isn't in mainline yet, so to be actually usable
> some arch patches are needed.

Start by running it through the CodingStyle scripts as I see a //
comment in there 8)


> +static void efm32_usart_rx_chars(struct efm32_usart_port *efm_port)
> +{
> +	struct uart_port *port =3D &efm_port->port;
> +	struct tty_struct *tty =3D port->state->port.tty;

Needs to be using krefs and checking the tty is not NULL
(tty_port_tty_get)

> +static void efm32_usart_set_termios(struct uart_port *port,
> +		struct ktermios *new, struct ktermios *old)
> +{
> +	struct efm32_usart_port *efm_port =3D to_efm_port(port);
> +	unsigned long flags;
> +	unsigned baud;
> +	u32 clkdiv;
> +
> +	/* no modem control lines */
> +	new->c_cflag &=3D ~(HUPCL | CRTSCTS | CMSPAR);

Minor item - HUPCL shouldn't get cleared - its a request for hangup
behaviour not a port feature.

> +	/* currently only some features are implemented */
> +	new->c_cflag &=3D ~CSIZE;
> +	new->c_cflag |=3D CS8;
> +	new->c_cflag |=3D CSTOPB;
> +	new->c_cflag &=3D ~PARENB;

If you can do CS8 without parity you can do CS7 with parity.

> +	new->c_iflag =3D 0;

This seems broken. Lots of the iflgs are user requests and stack
properties not port features. For example you can do xon/xoff as its
pure software. As far as I can see you should leave c_iflag alone.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
