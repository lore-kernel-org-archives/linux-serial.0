From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 2/2] serial: mxs-auart: wait for FIFO to flush before
 shutdown
Date: Wed, 2 Oct 2013 22:18:34 +0200
Message-ID: <20131002201834.GA10079@pengutronix.de>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
 <1380715364-8025-3-git-send-email-hector.palacios@digi.com>
 <20131002122222.GQ2548@pengutronix.de>
 <524C274B.3020409@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52724 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab3JBUSi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 16:18:38 -0400
Content-Disposition: inline
In-Reply-To: <524C274B.3020409@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "b32955@freescale.com" <b32955@freescale.com>, "marex@denx.de" <marex@denx.de>, "fabio.estevam@freescale.com" <fabio.estevam@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "jslaby@suse.cz" <jslaby@suse.cz>

Hello Hector,

On Wed, Oct 02, 2013 at 04:01:47PM +0200, Hector Palacios wrote:
> On 10/02/2013 02:22 PM, Uwe Kleine-K=F6nig wrote:
> >On Wed, Oct 02, 2013 at 02:02:44PM +0200, Hector Palacios wrote:
> >>The shutdown function was not waiting for the FIFO (which may be th=
e
> >>real 16 byte FIFO or the DMA buffer, if DMA is enabled) to flush
> >>before disabling the AUART.
> >>This lead to many bytes not being transferred (specially at low
> >>baudrates), as they were still in the DMA buffer when the AUART was
> >>shutdown.
> >>This patch also adds the check for the BUSY flag before disabling
> >>the AUART.
> >>
> >>Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> >>---
> >>  drivers/tty/serial/mxs-auart.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >>diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mx=
s-auart.c
> >>index 9f046177..589b595 100644
> >>--- a/drivers/tty/serial/mxs-auart.c
> >>+++ b/drivers/tty/serial/mxs-auart.c
> >>@@ -757,9 +757,22 @@ static int mxs_auart_startup(struct uart_port =
*u)
> >>  	return 0;
> >>  }
> >>
> >>+static unsigned int mxs_auart_tx_empty(struct uart_port *u);
> >>+
> >>  static void mxs_auart_shutdown(struct uart_port *u)
> >>  {
> >>  	struct mxs_auart_port *s =3D to_auart_port(u);
> >>+	unsigned int to;
> >>+
> >>+	/* Wait for the FIFO to flush */
> >>+	to =3D u->timeout;
> >>+	while (!mxs_auart_tx_empty(u) && to--)
> >>+		mdelay(1);
> >>+
> >>+	/* Wait for UART to become idle ... */
> >>+	to =3D u->timeout;
> >>+	while ((readl(u->membase + AUART_STAT) & AUART_STAT_BUSY) && to--=
)
> >>+		mdelay(1);
> >If the 2nd loop is needed the tx_empty callback is buggy. According =
to
> >Documentation/serial/driver tx_empty "tests whether the transmitter =
fifo
> >and shifter for the port [...] is empty". I guess it only tests for =
the
> >fifo part? Time for another fix ...
>=20
> Do you mean the tx_empty should check both for TX_FIFO and !BUSY, rig=
ht?
> I did it so because I thought the BUSY was also set during rx, but
> it is really only used to signal tx operation.
>=20
> That would turn this patch into this:
>=20
> @@ -755,13 +755,21 @@ static int mxs_auart_startup(struct uart_port *=
u)
>  	writel(AUART_LINECTRL_FEN, u->membase + AUART_LINECTRL_SET);
>=20
>  	return 0;
>  }
>=20
> +static unsigned int mxs_auart_tx_empty(struct uart_port *u);
There is no need for a forward declaration if you move the whole
function.

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
>=20
>  	if (auart_dma_enabled(s))
>  		mxs_auart_dma_exit(s);
>=20
>  	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
> @@ -774,14 +782,15 @@ static void mxs_auart_shutdown(struct uart_port=
 *u)
>  	clk_disable_unprepare(s->clk);
>  }
>=20
>  static unsigned int mxs_auart_tx_empty(struct uart_port *u)
>  {
> -	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
> -		return TIOCSER_TEMT;
> -	else
> -		return 0;
> +	if (!((readl(u->membase + AUART_STAT) & AUART_STAT_BUSY)))
> +		if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
> +			return TIOCSER_TEMT;
if you do
	stat =3D readl(u->membase + AUART_STAT);
	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) =3D=3D AUART_STAT_TXF=
E)
		return TIOCSER_TEMT;

you save one register read and a small race condition.

Best regards
Uwe


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
