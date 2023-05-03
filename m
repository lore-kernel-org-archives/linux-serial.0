Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5171C77B7F
	for <linux-serial@archiver.kernel.org>; Wed,  3 May 2023 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjECJDO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 May 2023 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECJDO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 May 2023 05:03:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616BB19BE
        for <linux-serial@vger.kernel.org>; Wed,  3 May 2023 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683104592; x=1714640592;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rXPn1GyqliLXTXsyK7GCOfhrWK4Hhvdl61jf5jO3gY0=;
  b=FvYhct9i7XkK22Y0oS/QVw8FOVq6KnwS6o6XwkBVuKp9KPZqoqtRLrV6
   ITYL6mlIACUnC/hrk6pLLN3Y6STgyjmWDocBbIszXmd0pJAk88XXE3xMD
   L+tR9fg2V0cJzlIC7MSLiOybCwwDnQ+63hNAN+c9eyyfsYFyvvMJMlqgg
   9BkA8MXWuDkcZ4RYlDbJ3/7MJoW7xb1zIqgNvBO1WF9BCx6pGdPDsc2l+
   iVlqIn3qesnUZ3DeHrJCwKVbSKbQbDwweNm79pjMpCRT0uwr/HbU2GLqE
   d3b/n5tbzJkbWUOR/WQZuZXS12lEOLEjCRPmvP1I3GTDktaqCGPS8ioij
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="337744269"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="337744269"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 02:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="674008417"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="674008417"
Received: from bradocaj-mobl.ger.corp.intel.com ([10.249.37.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 02:03:09 -0700
Date:   Wed, 3 May 2023 12:03:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, imx@lists.linux.dev,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the timer based
 EOP logic
In-Reply-To: <20230502190641.657483-1-shenwei.wang@nxp.com>
Message-ID: <2a4bec70-4285-c48c-1bb9-c2e713ce3e0@linux.intel.com>
References: <20230502190641.657483-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 2 May 2023, Shenwei Wang wrote:

> At low baud rates, the DMA transfer may end prematurely due to the timer,
> even during an active transfer. This does not accurately simulate an EOP
> event as intended. We expect the timer to only complete a DMA transfer
> once the idle period satisfies a specified interval.
> 
> The patch checks the DMA residue count before copying data to the TTY
> buffer. If the residue count remains unchanged since the last interrupt,
> that indicates no new data was received. In this case, the DMA should
> complete as an EOP event. Instead, the timer restarts.

This description is lacking something. It does not explain why the stuff 
in second paragraph is necessary at all as setting a longer timer based on
the (lower) baud rate would avoid the need to do the timer restart.

> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 52 ++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c91916e13648..8d21351fb3bd 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -238,6 +238,7 @@
>  
>  /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
>  #define DMA_RX_TIMEOUT		(10)
> +#define DMA_RX_IDLE_CHARS	(8)
>  #define UART_AUTOSUSPEND_TIMEOUT	3000
>  
>  #define DRIVER_NAME	"fsl-lpuart"
> @@ -282,6 +283,7 @@ struct lpuart_port {
>  	struct scatterlist	rx_sgl, tx_sgl[2];
>  	struct circ_buf		rx_ring;
>  	int			rx_dma_rng_buf_len;
> +	int                     last_residue;
>  	unsigned int		dma_tx_nents;
>  	wait_queue_head_t	dma_wait;
>  	bool			is_cs7; /* Set to true when character size is 7 */
> @@ -331,7 +333,7 @@ static struct lpuart_soc_data imx8qxp_data = {
>  	.devtype = IMX8QXP_LPUART,
>  	.iotype = UPIO_MEM32,
>  	.reg_off = IMX_REG_OFF,
> -	.rx_watermark = 31,
> +	.rx_watermark = 8, /* A lower watermark is ideal for low baud rates. */
>  };
>  static struct lpuart_soc_data imxrt1050_data = {
>  	.devtype = IMXRT1050_LPUART,
> @@ -1255,6 +1257,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>  		sport->port.icount.rx += copied;
>  	}
>  
> +	sport->last_residue = state.residue;
> +
>  exit:
>  	dma_sync_sg_for_device(chan->device->dev, &sport->rx_sgl, 1,
>  			       DMA_FROM_DEVICE);
> @@ -1272,11 +1276,40 @@ static void lpuart_dma_rx_complete(void *arg)
>  	lpuart_copy_rx_to_tty(sport);
>  }
>  
> +/*
> + * Timer function to simulate the hardware EOP(End Of Package) event.

Missing space

> + * The timer callback is to check for new RX data and copy to TTY buffer.
> + * If no new data since last interrupt, restart timer. Otherwise, copy data
> + * and continue normal logic.
> + */
>  static void lpuart_timer_func(struct timer_list *t)
>  {
>  	struct lpuart_port *sport = from_timer(sport, t, lpuart_timer);
> +	struct dma_chan *chan = sport->dma_rx_chan;
> +	struct circ_buf *ring = &sport->rx_ring;
> +	struct dma_tx_state state;
> +	unsigned long flags;
> +	int count = 0;
>  
> -	lpuart_copy_rx_to_tty(sport);
> +	dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);

> +	ring->head = sport->rx_sgl.length - state.residue;
> +
> +	if (ring->head < ring->tail)
> +		count = sport->rx_sgl.length - ring->tail;
> +	else if (ring->tail < ring->head)
> +		count = ring->head - ring->tail;

linux/circ_buf.h has functions which likely handle what you want to do 
here. They will get you true count across wrap too which this above does 
not do.

Given this is essentially duplicates count calculation some refactor 
would seem more useful here rather than recalculating the count again in 
lpuart_copy_rx_to_tty().

Also lpuart_handle_sysrq() duplicates the same calculations.

> +
> +	/* Check if new data received before copying */
> +	if ((count != 0) && (sport->last_residue == state.residue))

I'm unsure about this condition being right.

What will happen when rx_sgl.length (or -1 of that, I'm not sure which way 
"full size" is here) worth of data has been DMA'ed. Does this condition 
end up delaying copy such that it's done only on every other call here?

Also, should you reset last_residue in lpuart_start_rx_dma() ? I think 
that would solve the "full size" problem.

> +		lpuart_copy_rx_to_tty(sport);
> +	else
> +		mod_timer(&sport->lpuart_timer,
> +				jiffies + sport->dma_rx_timeout);
> +
> +	if (spin_trylock_irqsave(&sport->port.lock, flags)) {
> +		sport->last_residue = state.residue;
> +		spin_unlock_irqrestore(&sport->port.lock, flags);
> +	}
>  }
>  
>  static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
> @@ -1297,9 +1330,19 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	 */
>  	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
>  	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
> +	if (sport->rx_dma_rng_buf_len < sport->rxfifo_size * 2)
> +		sport->rx_dma_rng_buf_len = sport->rxfifo_size * 2;

max_t()

> +
> +	/*
> +	 * Keep this condition check in case rxfifo_size is unavailable
> +	 * for some SoCs.
> +	 */
>  	if (sport->rx_dma_rng_buf_len < 16)
>  		sport->rx_dma_rng_buf_len = 16;
>  
> +	sport->dma_rx_timeout =
> +		msecs_to_jiffies((1000 * 10 * DMA_RX_IDLE_CHARS) / baud + 1);

There's ->frame_time these days in uart_port which you should base frame 
timing related calculations. I wouldn't mind if that existing ->frame_time 
math that is visible in your patch's context is also converted (in a 
separate patch).

I'm assuming that magic 10 is assumed number of bits and 1000 
MSEC_PER_SEC. That +1 seems odd, did you mean DIV_ROUND_UP() ?

> +
>  	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
>  	if (!ring->buf)
>  		return -ENOMEM;
> @@ -1687,12 +1730,13 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
>  	if (!sport->dma_rx_chan)
>  		goto err;
>  
> +	/* set default Rx DMA timeout */
> +	sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
> +
>  	ret = lpuart_start_rx_dma(sport);
>  	if (ret)
>  		goto err;
>  
> -	/* set Rx DMA timeout */
> -	sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
>  	if (!sport->dma_rx_timeout)
>  		sport->dma_rx_timeout = 1;
>  
> 

-- 
 i.

