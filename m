Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9822EC77B7F
	for <linux-serial@archiver.kernel.org>; Mon,  8 May 2023 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjEHPmO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 May 2023 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjEHPmL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 May 2023 11:42:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED18A43
        for <linux-serial@vger.kernel.org>; Mon,  8 May 2023 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683560529; x=1715096529;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cXBCL8GteBF+l0TfDGtFNX7YYIHHX/+d+yQ1RMNgqjc=;
  b=ANmYP2pw0RbG+8s3RxdNXc6O8pBrwmiW1puR8fJiBkA7alIF98cTsCnr
   /CYgjkRYo9t6nV89vAwlRfSfld7oYYyitCJHX/qjONY08GZ0DMqOyJQhS
   s4GFes0RKOsFmjX0SPWIreWovS3AC00A4PL6cUczja/vEQabD/nQw3mJj
   zbj+5TlBgG1IuRYRs9gGnMdlXHbxJcmCS6pftoXpR19BNeYcJc4XyZn6U
   GHg0vXpa2R3O6PdtXYIgjhRYDwdKos/c8vuEEjB12FIYb3jFtI8TOdq34
   Og2e1yZBnY8np/lkn0H/nqPzulgZ7t7t8wK2JIGU+1M+fTtyBIK/fT4iF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334121690"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334121690"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 08:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="788154214"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="788154214"
Received: from cciobanu-mobl1.ger.corp.intel.com ([10.249.37.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 08:42:06 -0700
Date:   Mon, 8 May 2023 18:42:04 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, imx@lists.linux.dev,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 1/1] tty: serial: fsl_lpuart: optimize the timer based
 EOP logic
In-Reply-To: <20230508141038.979924-1-shenwei.wang@nxp.com>
Message-ID: <31e2514b-a09d-64dd-5cfa-ad7faf4ba718@linux.intel.com>
References: <20230508141038.979924-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 8 May 2023, Shenwei Wang wrote:

> At low baud rates, the DMA transfer may end prematurely due to the timer,
> even during an active transfer. This does not accurately simulate an EOP
> event as intended. We expect the timer to only complete a DMA transfer
> once the idle period satisfies a specified interval.

This reorganization would perhaps explain the problem space better:

DMA transfer may end prematurely due to the DMA Rx timeout even during an 
active transfer because a constant timeout does not accurately simulate an 
EOP event. The timer should only complete a DMA transfer once the idle 
period satisfies a specified interval which is baud rate dependant. 
The problem has been observed with low baud rates but could occur also 
with high baud rates.

...I would also open the EOP here too and not just in the comment below.

> The patch checks the DMA residue count before copying data to the TTY

Make the DMA Rx timeout baud rate dependent and check the DMA residue 
count before copying data to the TTY

> buffer. If the residue count remains unchanged since the last interrupt,
> that indicates no new data was received. In this case, the DMA should
> complete as an EOP event. Otherwise, it indicates that new data were
> received during the interval, the EOP condition was not met and the
> timer restarted.

Otherwise, new data was received during the interval and the EOP condition 
is not met so restart the DMA Rx timeout.

> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
> V3:
>   - change the rx_watermark from 8 to 7 because the dma request is
>     generated when the fifo level is greater than this value.
> V2:
>   - this version is to address the review feedback from Ilpo.
>   - reset the last_residue when rx dma starts.
>   - simplified the character counting in the RX circular buffer.
>   - use max_t() and DIV_ROUND_UP()
> 
>  drivers/tty/serial/fsl_lpuart.c | 51 ++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c91916e13648..0ee1161bc789 100644
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
> +	.rx_watermark = 7, /* A lower watermark is ideal for low baud rates. */
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
> @@ -1272,11 +1276,37 @@ static void lpuart_dma_rx_complete(void *arg)
>  	lpuart_copy_rx_to_tty(sport);
>  }
> 
> +/*
> + * Timer function to simulate the hardware EOP (End Of Package) event.
> + * The timer callback is to check for new RX data and copy to TTY buffer.
> + * If no new data are received since last interval, the EOP condition is
> + * met, complete the DMA transfer by copying the data. Otherwise, just
> + * restart timer.
> + */
>  static void lpuart_timer_func(struct timer_list *t)
>  {
>  	struct lpuart_port *sport = from_timer(sport, t, lpuart_timer);
> +	struct dma_chan *chan = sport->dma_rx_chan;
> +	struct circ_buf *ring = &sport->rx_ring;
> +	struct dma_tx_state state;
> +	unsigned long flags;
> +	int count;
> 
> -	lpuart_copy_rx_to_tty(sport);
> +	dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
> +	ring->head = sport->rx_sgl.length - state.residue;
> +	count = CIRC_CNT(ring->head, ring->tail, sport->rx_sgl.length);
> +
> +	/* Check if new data received before copying */
> +	if ((count != 0) && (sport->last_residue == state.residue))
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
> @@ -1297,9 +1327,21 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	 */
>  	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
>  	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
> +	sport->rx_dma_rng_buf_len = max_t(int,
> +			sport->rxfifo_size * 2,
> +			sport->rx_dma_rng_buf_len);
> +	/*
> +	 * Keep this condition check in case rxfifo_size is unavailable
> +	 * for some SoCs.
> +	 */
>  	if (sport->rx_dma_rng_buf_len < 16)
>  		sport->rx_dma_rng_buf_len = 16;
> 
> +	sport->last_residue = 0;
> +	sport->dma_rx_timeout = msecs_to_jiffies(
> +		DIV_ROUND_UP(sport->port.frame_time * DMA_RX_IDLE_CHARS,
> +		NSEC_PER_MSEC));

nsecs_to_jiffies() also exists.

-- 
 i.

> +
>  	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
>  	if (!ring->buf)
>  		return -ENOMEM;
> @@ -1687,12 +1729,13 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
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
> --
> 2.34.1
> 
