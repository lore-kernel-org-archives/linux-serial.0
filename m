From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Thu, 26 Apr 2012 14:00:43 +0200
Message-ID: <20120426120043.GH17184@pengutronix.de>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <1335436632-29499-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45000 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab2DZMAr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2012 08:00:47 -0400
Content-Disposition: inline
In-Reply-To: <1335436632-29499-2-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, B20223@freescale.com, r58066@freescale.com, B20596@freescale.com

On Thu, Apr 26, 2012 at 06:37:11PM +0800, Huang Shijie wrote:
> Add the DMA support for uart RX and TX.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
>  drivers/tty/serial/imx.c                           |  386 +++++++++++++++++++-
>  2 files changed, 389 insertions(+), 4 deletions(-)
> 
> +	enum dma_status status;
> +	unsigned long flags;
> +	int ret;
> +
> +	status = chan->device->device_tx_status(chan, (dma_cookie_t)NULL, NULL);
> +	if (DMA_IN_PROGRESS == status)
> +		return;
> +
> +	spin_lock_irqsave(&sport->port.lock, flags);
> +	sport->tx_bytes = uart_circ_chars_pending(xmit);
> +	if (sport->tx_bytes > 0) {

Instead of putting nearly the whole body of this function inside a 'if'
you should return here.

> +		if (xmit->tail > xmit->head) {
> +			sport->dma_tx_nents = 2;
> +			sg_init_table(sgl, 2);
> +			sg_set_buf(sgl, xmit->buf + xmit->tail,
> +					UART_XMIT_SIZE - xmit->tail);
> +			sg_set_buf(&sgl[1], xmit->buf, xmit->head);
> +		} else {
> +			sport->dma_tx_nents = 1;
> +			sg_init_one(sgl, xmit->buf + xmit->tail,
> +					sport->tx_bytes);
> +		}
> +		spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +		ret = dma_map_sg(sport->port.dev, sgl,
> +				sport->dma_tx_nents, DMA_TO_DEVICE);
> +		if (ret == 0) {
> +			pr_err("DMA mapping error for TX.\n");

Use dev_* functions. Whoever reads the above in the logs won't have a
clue that it comes from the serial driver.


> +			return;
> +		}
> +		desc = dmaengine_prep_slave_sg(chan, sgl,
> +				sport->dma_tx_nents, DMA_MEM_TO_DEV, 0);
> +		if (!desc) {
> +			pr_err("We cannot prepare for the TX slave dma!\n");
> +			return;
> +		}
> +		desc->callback = dma_tx_callback;
> +		desc->callback_param = sport;
> +
> +		/* fire it */
> +		dmaengine_submit(desc);
> +		dma_async_issue_pending(chan);
> +		return;
> +	}
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
> +	return;
> +}
> +

> +/* see the "i.MX61 SDMA Scripts User Manual.doc" for the parameters */

I can't see how the manual helps here.

Please test this patch at least on one more SoC. There should be nothing
i.MX6 specific in here, the fact that the i.MX6 is mentioned several
times in the comments make me suspicious.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
