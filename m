From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/mxs-auart: increase time to wait for transmitter
 to become idle
Date: Thu, 4 Jul 2013 11:27:16 +0200
Message-ID: <20130704092716.GC17454@pengutronix.de>
References: <1372413017-23252-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46427 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab3GDJ1W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Jul 2013 05:27:22 -0400
Content-Disposition: inline
In-Reply-To: <1372413017-23252-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org

Hi Greg,

On Fri, Jun 28, 2013 at 11:49:41AM +0200, Uwe Kleine-K=F6nig wrote:
> Without this patch the driver waits ~1 ms for the UART to become idle=
=2E At
> 115200n8 this time is (theoretically) enough to transfer 11.5 charact=
ers
> (=3D 115200 bits/s / (10 Bits/char) * 1ms). As the mxs-auart has a fi=
fo size
> of 16 characters the clock is gated too early. The problem is worse f=
or
> lower baud rates.
>=20
> This only happens to really shut down the transmitter in the middle o=
f a
> transfer if /dev/ttyAPPx isn't opened in userspace (e.g. by a getty) =
but
> was at least once (because the bootloader doesn't disable the transmi=
tter).
>=20
> So increase the timeout to 20 ms which should be enough for 9600n8, t=
oo.
> Moreover skip gating the clock if the timeout is elapsed.
>=20
> Cc: stable@vger.kernel.org # v2.6.39+
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Any comments on this. I hoped this patch would make it in for 3.10 :-(

Best regards
Uwe

> ---
>  drivers/tty/serial/mxs-auart.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index 4f5f161..7645079 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -850,7 +850,7 @@ auart_console_write(struct console *co, const cha=
r *str, unsigned int count)
>  	struct mxs_auart_port *s;
>  	struct uart_port *port;
>  	unsigned int old_ctrl0, old_ctrl2;
> -	unsigned int to =3D 1000;
> +	unsigned int to =3D 20000;
> =20
>  	if (co->index >=3D MXS_AUART_PORTS || co->index < 0)
>  		return;
> @@ -871,18 +871,23 @@ auart_console_write(struct console *co, const c=
har *str, unsigned int count)
> =20
>  	uart_console_write(port, str, count, mxs_auart_console_putchar);
> =20
> -	/*
> -	 * Finally, wait for transmitter to become empty
> -	 * and restore the TCR
> -	 */
> +	/* Finally, wait for transmitter to become empty ... */
>  	while (readl(port->membase + AUART_STAT) & AUART_STAT_BUSY) {
> +		udelay(1);
>  		if (!to--)
>  			break;
> -		udelay(1);
>  	}
> =20
> -	writel(old_ctrl0, port->membase + AUART_CTRL0);
> -	writel(old_ctrl2, port->membase + AUART_CTRL2);
> +	/*
> +	 * ... and restore the TCR if we waited long enough for the transmi=
tter
> +	 * to be idle. This might keep the transmitter enabled although it =
is
> +	 * unused, but that is better than to disable it while it is still
> +	 * transmitting.
> +	 */
> +	if (!(readl(port->membase + AUART_STAT) & AUART_STAT_BUSY)) {
> +		writel(old_ctrl0, port->membase + AUART_CTRL0);
> +		writel(old_ctrl2, port->membase + AUART_CTRL2);
> +	}
> =20
>  	clk_disable(s->clk);
>  }
> --=20
> 1.8.3.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
