From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
Date: Thu, 3 Oct 2013 20:17:40 +0200
Message-ID: <20131003181740.GB10079@pengutronix.de>
References: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
 <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36688 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab3JCSRn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Oct 2013 14:17:43 -0400
Content-Disposition: inline
In-Reply-To: <1380785524-20490-3-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

Hello,

there is only a single concern left and probably only the Freescale guy=
s
can comment here ...
On Thu, Oct 03, 2013 at 09:32:04AM +0200, Hector Palacios wrote:
> The shutdown function was not waiting for the FIFO (which may be the
> real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
> before disabling the AUART.
> This lead to many bytes not being transferred (specially at low
> baudrates), as they were still in the DMA buffer when the AUART was
> shutdown.
> This patch also adds the check for the BUSY flag on the tx_empty
> callback.
>=20
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  drivers/tty/serial/mxs-auart.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index 9f046177..30edb91 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -757,9 +757,26 @@ static int mxs_auart_startup(struct uart_port *u=
)
>  	return 0;
>  }
> =20
> +static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> +{
> +	unsigned long stat;
> +
> +	stat =3D readl(u->membase + AUART_STAT);
> +	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) =3D=3D AUART_STAT_=
TXFE)
> +		return TIOCSER_TEMT;
Can it happen that both the fifo and the shifter are empty but there ar=
e
still some chars pending to be transfered via DMA? If you were checking
if dma is still setup you'd be on the safe side.

Best regards
Uwe

> +
> +	return 0;
> +}
> +
>  static void mxs_auart_shutdown(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s =3D to_auart_port(u);
> +	unsigned int to;
> +
> +	/* Wait for the FIFO to flush */
> +	to =3D u->timeout;
> +	while (!mxs_auart_tx_empty(u) && to--)
> +		mdelay(1);
> =20
>  	if (auart_dma_enabled(s))
>  		mxs_auart_dma_exit(s);
> @@ -774,14 +791,6 @@ static void mxs_auart_shutdown(struct uart_port =
*u)
>  	clk_disable_unprepare(s->clk);
>  }
> =20
> -static unsigned int mxs_auart_tx_empty(struct uart_port *u)
> -{
> -	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
> -		return TIOCSER_TEMT;
> -	else
> -		return 0;
> -}
> -
>  static void mxs_auart_start_tx(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s =3D to_auart_port(u);
> --=20
> 1.8.4
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
