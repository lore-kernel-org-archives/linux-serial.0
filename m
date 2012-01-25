From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] serial/efm32: add new driver
Date: Wed, 25 Jan 2012 09:41:08 +0100
Message-ID: <20120125084108.GF6305@pengutronix.de>
References: <20120124220522.GA10590@kroah.com>
 <1327478704-4233-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1327479959.21686.8.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327479959.21686.8.camel@joe2Laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 25, 2012 at 12:25:59AM -0800, Joe Perches wrote:
> On Wed, 2012-01-25 at 09:05 +0100, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> trivial comments below:
>=20
> > diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/e=
fm32-uart.c
> []
> > @@ -0,0 +1,830 @@
> > +#if defined(CONFIG_SERIAL_EFM32_UART_CONSOLE) && defined(CONFIG_MA=
GIC_SYSRQ)
> > +#define SUPPORT_SYSRQ
> > +#endif
>=20
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>=20
> > +static void efm32_uart_rx_chars(struct efm32_uart_port *efm_port,
> > +		struct tty_struct *tty)
> > +{
> []
> > +		if ((rxdata & UARTn_RXDATAX_FERR) &&
> > +				!(rxdata & UARTn_RXDATAX_RXDATA__MASK)) {
>=20
> Perhaps better as:
>=20
> 		if ((rxdata & UARTn_RXDATAX_FERR) &&
> 		    !(rxdata & UARTn_RXDATAX_RXDATA__MASK)) {
This is how my editor does the indention. I'm sure this can be changed,
but I want the indention only to depend on the logical structure not on
where the opening parenthesis in the previous line is. This saves
context changes for future patches.
=20
> and RXDATA__MASK with 2 underscores?  perhaps just one _?
Yeah, I like seperating the register bit field name from that fact that
the #define holds a mask.
=20
> > +static int efm32_uart_console_setup(struct console *co, char *opti=
ons)
> []
> > +		for (i =3D 0; i < ARRAY_SIZE(efm32_uart_ports); ++i) {
> > +			if (efm32_uart_ports[i]) {
> > +				pr_warn("efm32-console: fall back to console index %u (from %h=
hi)\n",
> > +						i, co->index);
>=20
> 				pr_warn("fall back to ..."
> []
> > +	efm_port =3D efm32_uart_ports[co->index];
> > +	if (!efm_port) {
> > +		pr_warn("efm32-console: No port at %d\n", co->index);
>=20
> 		pr_warn("No port at..."
I intentionally did that, as these two messages are related to the
console part of the serial driver while the rest of the messages are
about the serial/tty stuff. And I didn't like changing the definition o=
f
pr_fmt in the middle of the file.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
