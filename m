From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] serial: mxs-auart: wait for DMA buffer to flush before shutdown
Date: Tue, 1 Oct 2013 21:56:58 +0200
Message-ID: <201310012156.58888.marex@denx.de>
References: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49925 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab3JAT6Y (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 1 Oct 2013 15:58:24 -0400
In-Reply-To: <1380644315-31581-1-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de, b32955@freescale.com, gregkh@linuxfoundation.org, shawn.guo@linaro.org, fabio.estevam@freescale.com

Dear Hector Palacios,

> The shutdown function was not waiting for the DMA buffer to flush
> before disabling the AUART. This lead to many bytes not being
> transferred (specially at low baudrates), as they were still in the
> DMA buffer when the AUART was shutdown.
> This patch also adds the check for the BUSY flag.
> 
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> 
> https://jira.digi.com/browse/DEL-616

The link doesn't work. Otherwise makes sense

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
>  drivers/tty/serial/mxs-auart.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c
> b/drivers/tty/serial/mxs-auart.c index f85b8e6..0d8b2ca 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -750,12 +750,26 @@ static int mxs_auart_startup(struct uart_port *u)
>  	return 0;
>  }
> 
> +static unsigned int mxs_auart_tx_empty(struct uart_port *u);
> +
>  static void mxs_auart_shutdown(struct uart_port *u)
>  {
>  	struct mxs_auart_port *s = to_auart_port(u);
> +	unsigned int to;
> +
> +	if (auart_dma_enabled(s)) {
> +		/* Wait enough time to flush DMA buffer completely */
> +		to = u->timeout * UART_XMIT_SIZE / u->fifosize;
> +		while (!mxs_auart_tx_empty(u) && to--)
> +			mdelay(1);
> 
> -	if (auart_dma_enabled(s))
>  		mxs_auart_dma_exit(s);
> +	}
> +
> +	/* Wait for transmitter to become empty ... */
> +	to = u->timeout;
> +	while ((readl(port->membase + AUART_STAT) & AUART_STAT_BUSY) && to--)
> +		mdelay(1);
> 
>  	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);

Best regards,
Marek Vasut
