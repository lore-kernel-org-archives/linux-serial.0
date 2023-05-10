Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A821C7EE23
	for <linux-serial@archiver.kernel.org>; Wed, 10 May 2023 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjEJKeF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 May 2023 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbjEJKeD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 May 2023 06:34:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3996EA7
        for <linux-serial@vger.kernel.org>; Wed, 10 May 2023 03:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683714841; x=1715250841;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=jf1bWlGCvJf1nsNgc/O9WNeKof1sQSSQ05e52aKqtkM=;
  b=IHqiM71HRlSWmDCir2cskc08bImvyTl3/R0BBRnxnXzP/Ny87iEz6uJ5
   FS1DJYouT3DnkoppSoh5D95kTAGcsvbLMmGRjyBDPjgxSVfcgmwaxmLs0
   XGTrlI9LrBDpzDD5TlqgBSKCxGAxt0CL9II23MykTdWuU4WlJvBHzJWDn
   H2BMbHF4+Ibut0Ca8TfPP+PnqWF4hydCmVNluR17ZYak6YuOp9NMFBeLP
   q0J+erVLPcNmR4W1MP54y6KQkK22HBhbSblE5cp8KzZsiDnvcQc+pIUSn
   UAWDNKvDmrmC+keah7FFxqcPwcFTQSEk6h8kCVt5jWleilQ+ynY2Badeh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="349012566"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="349012566"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 03:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="843457570"
X-IronPort-AV: E=Sophos;i="5.99,264,1677571200"; 
   d="scan'208";a="843457570"
Received: from sschutze-mobl.ger.corp.intel.com ([10.251.218.236])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 03:33:46 -0700
Date:   Wed, 10 May 2023 13:33:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, imx@lists.linux.dev,
        linux-imx@nxp.com
Subject: Re: [PATCH v4 1/1] tty: serial: fsl_lpuart: optimize the timer based
 EOP logic
In-Reply-To: <20230509153624.1073946-1-shenwei.wang@nxp.com>
Message-ID: <f374a1e8-bf8c-c2b6-9350-2f34bcbe7227@linux.intel.com>
References: <20230509153624.1073946-1-shenwei.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1154796192-1683714517=:2669"
Content-ID: <536d9ca9-6011-4a48-d0d6-b86695bb69d@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1154796192-1683714517=:2669
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <1774103e-aced-c24c-317b-f0c3c83d321b@linux.intel.com>

On Tue, 9 May 2023, Shenwei Wang wrote:

> DMA transfer may end prematurely due to the DMA Rx timeout even during an
> active transfer because a constant timeout does not accurately simulate an
> EOP event. The timer should only complete a DMA transfer once the idle
> period satisfies a specified interval which is baud rate dependant.
> The problem has been observed with low baud rates but could occur also
> with high baud rates.
> 
> This patch uses a timer to simulate the hardware EOP (End Of Package) event.

You could open EOP at the previous paragraph where it appears first.

> The idea is to make the DMA Rx timeout baud rate dependent and check the DMA

Just remove this "the idea is to" and just state what was done by starting 
with "Make" like I initially said.

> residue count before copying data to the TTY buffer. If the residue count
> remains unchanged since the last interrupt, that indicates no new data was
> received. In this case, the DMA should complete as an EOP event. Otherwise,
> new data was received during the interval and the EOP condition is not met
> so restart the DMA Rx timeout
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

However, please check a few additional comments below.

> ---
> V4:
>   - improve the patch comments per Ilpo's suggestion.
>   - use nsecs_to_jiffies
> 
> V3:
>   - change the rx_watermark from 8 to 7 because the dma request is
>     generated when the fifo level is greater than this value.
> 
> V2:
>   - this version is to address the review feedback from Ilpo.
>   - reset the last_residue when rx dma starts.
>   - simplified the character counting in the RX circular buffer.
>   - use max_t() and DIV_ROUND_UP()
> 
>  drivers/tty/serial/fsl_lpuart.c | 50 ++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index c91916e13648..f21920024618 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -238,6 +238,7 @@
> 
>  /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
>  #define DMA_RX_TIMEOUT		(10)
> +#define DMA_RX_IDLE_CHARS	(8)

Extra parenthesis

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

It would be better to have this change in own patch. It might be something 
that causes discussion/problems later on so it would be better to have it 
as a separate patch. But I'm not sure how tightly it's related to
DMA_RX_IDLE_CHARS which may make taking it out harder.

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

Alignment doesn't match the previous line (start parameters from the 
same column).

> +
> +	if (spin_trylock_irqsave(&sport->port.lock, flags)) {
> +		sport->last_residue = state.residue;
> +		spin_unlock_irqrestore(&sport->port.lock, flags);
> +	}
>  }
> 
>  static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
> @@ -1297,9 +1327,20 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
>  	 */
>  	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
>  	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
> +	sport->rx_dma_rng_buf_len = max_t(int,
> +			sport->rxfifo_size * 2,
> +			sport->rx_dma_rng_buf_len);

Alignment doesn't match the prev line.

> +	/*
> +	 * Keep this condition check in case rxfifo_size is unavailable
> +	 * for some SoCs.
> +	 */
>  	if (sport->rx_dma_rng_buf_len < 16)
>  		sport->rx_dma_rng_buf_len = 16;
> 
> +	sport->last_residue = 0;
> +	sport->dma_rx_timeout = max(nsecs_to_jiffies(
> +		sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
> +
>  	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
>  	if (!ring->buf)
>  		return -ENOMEM;
> @@ -1687,12 +1728,13 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
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

-- 
 i.
--8323329-1154796192-1683714517=:2669--
