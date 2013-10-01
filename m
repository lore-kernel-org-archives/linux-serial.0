From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before
 shutdown
Date: Tue, 1 Oct 2013 21:48:00 +0200
Message-ID: <20131001194800.GL2548@pengutronix.de>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55240 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab3JATsE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Oct 2013 15:48:04 -0400
Content-Disposition: inline
In-Reply-To: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, b32955@freescale.com, gregkh@linuxfoundation.org, shawn.guo@linaro.org, fabio.estevam@freescale.com, marex@denx.de

Hello Hector,

On Tue, Oct 01, 2013 at 06:18:35PM +0200, Hector Palacios wrote:
> The shutdown function was not waiting for the DMA buffer to flush
> before disabling the AUART. This lead to many bytes not being
> transferred (specially at low baudrates), as they were still in the
> DMA buffer when the AUART was shutdown.
> This patch also adds the check for the BUSY flag.
>=20
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
>=20
> https://jira.digi.com/browse/DEL-616
What is this? This isn't available in public DNS.

> ---
>  drivers/tty/serial/mxs-auart.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-=
auart.c
> index f85b8e6..0d8b2ca 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -750,12 +750,26 @@ static int mxs_auart_startup(struct uart_port *=
u)
>  	return 0;
>  }
> =20
> +static unsigned int mxs_auart_tx_empty(struct uart_port *u);
> +
>  static void mxs_auart_shutdown(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s =3D to_auart_port(u);
> +	unsigned int to;
> +
> +	if (auart_dma_enabled(s)) {
> +		/* Wait enough time to flush DMA buffer completely */
> +		to =3D u->timeout * UART_XMIT_SIZE / u->fifosize;
u->timeout is the time needed to send one char, right? UART_XMIT_SIZE i=
s
the size of the circular buffer, fifosize is the size of the fifo. I
don't get what you get by dividing by the fifosize. I would have
expected something like:

	u->timeout * min(UART_XMIT_SIZE, u->fifosize)

Can you explain, maybe in a comment along the code for the next person
not understanding?

I wonder if the individual driver is the right place this must be fixed
in or if there should be (or even exists) some help form the serial
framework?!

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
