Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A9C49EA4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 05:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A1E6128A
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 05:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFVFtS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 01:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhFVFtR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 01:49:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D07F36115B;
        Tue, 22 Jun 2021 05:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624340821;
        bh=KRZRfZcqXFVpJXGqMt3gTkRjPb17Tz3tlN13szaVGV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcNb/YyzfzYAqFaCZfOqXyY9/LopvrphHj2ag4Rx8sl6HW5+u5K3RtIwtIZQWjKG+
         20Lvo3vdPxogc8kBAA4zCan5LSZ9jKA91LnEJixR36fYirfhUkFu3dC8j6VijOwWUl
         QjpMo9Yju5Ive/ZDwCi1lrg1q02ouJqEpo1tbWqQ=
Date:   Tue, 22 Jun 2021 07:46:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamseel Shams <m.shams@samsung.com>
Cc:     krzysztof.kozlowski@canonical.com, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com
Subject: Re: [PATCH v2] serial: samsung: use dma_ops of DMA if attached
Message-ID: <YNF5T3dLjGZ7z0Gw@kroah.com>
References: <CGME20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb@epcas5p3.samsung.com>
 <20210622035202.5260-1-m.shams@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622035202.5260-1-m.shams@samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 22, 2021 at 09:22:02AM +0530, Tamseel Shams wrote:
> When DMA is used for TX and RX by serial driver, it should
> pass the DMA device pointer to DMA API instead of UART device
> pointer.
> 
> This patch is necessary to fix the SMMU page faults
> which is observed when a DMA(with SMMU enabled) is attached
> to UART for transfer.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 62 +++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..0c924bb6108e 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>  	struct circ_buf *xmit = &port->state->xmit;
>  	struct dma_tx_state state;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>  	int count;
>  
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
> +
>  	if (!ourport->tx_enabled)
>  		return;
>  
> @@ -305,7 +310,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  		dmaengine_pause(dma->tx_chan);
>  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>  		dmaengine_terminate_all(dma->tx_chan);
> -		dma_sync_single_for_cpu(ourport->port.dev,
> +		dma_sync_single_for_cpu(dma_map_ops_dev,
>  			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
>  		async_tx_ack(dma->tx_desc);
>  		count = dma->tx_bytes_requested - state.residue;
> @@ -331,14 +336,19 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>  	struct circ_buf *xmit = &port->state->xmit;
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>  	struct dma_tx_state state;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>  	unsigned long flags;
>  	int count;
>  
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
> +
>  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>  	count = dma->tx_bytes_requested - state.residue;
>  	async_tx_ack(dma->tx_desc);
>  
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
>  				dma->tx_size, DMA_TO_DEVICE);
>  
>  	spin_lock_irqsave(&port->lock, flags);
> @@ -436,6 +446,11 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>  	struct uart_port *port = &ourport->port;
>  	struct circ_buf *xmit = &port->state->xmit;
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
> +
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>  
>  	if (ourport->tx_mode != S3C24XX_TX_DMA)
>  		enable_tx_dma(ourport);
> @@ -443,7 +458,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
>  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
>  
> -	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
> +	dma_sync_single_for_device(dma_map_ops_dev, dma->tx_transfer_addr,
>  				dma->tx_size, DMA_TO_DEVICE);
>  
>  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
> @@ -510,12 +525,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
>  		struct tty_port *tty, int count)
>  {
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>  	int copied;
>  
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +
>  	if (!count)
>  		return;
>  
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
>  				dma->rx_size, DMA_FROM_DEVICE);
>  
>  	ourport->port.icount.rx += count;
> @@ -635,8 +655,13 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
>  static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
>  {
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
> +
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
>  
> -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
>  				dma->rx_size, DMA_FROM_DEVICE);
>  
>  	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
> @@ -1045,6 +1070,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  	struct s3c24xx_uart_dma	*dma = p->dma;
>  	struct dma_slave_caps dma_caps;
>  	const char *reason = NULL;
> +	struct device *dma_map_ops_dev = p->port.dev;
>  	int ret;
>  
>  	/* Default slave configuration parameters */
> @@ -1102,18 +1128,25 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  		goto err_release_tx;
>  	}
>  
> -	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +
> +	dma->rx_addr = dma_map_single(dma_map_ops_dev, dma->rx_buf,
>  				dma->rx_size, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
> +	if (dma_mapping_error(dma_map_ops_dev, dma->rx_addr)) {
>  		reason = "DMA mapping error for RX buffer";
>  		ret = -EIO;
>  		goto err_free_rx;
>  	}
>  
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>  	/* TX buffer */
> -	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
> +	dma->tx_addr = dma_map_single(dma_map_ops_dev, p->port.state->xmit.buf,
>  				UART_XMIT_SIZE, DMA_TO_DEVICE);
> -	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
> +	if (dma_mapping_error(dma_map_ops_dev, dma->tx_addr)) {
>  		reason = "DMA mapping error for TX buffer";
>  		ret = -EIO;
>  		goto err_unmap_rx;
> @@ -1122,7 +1155,9 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  	return 0;
>  
>  err_unmap_rx:
> -	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
> +	if (dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +	dma_unmap_single(dma_map_ops_dev, dma->rx_addr, dma->rx_size,
>  			 DMA_FROM_DEVICE);
>  err_free_rx:
>  	kfree(dma->rx_buf);
> @@ -1139,10 +1174,12 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>  static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>  {
>  	struct s3c24xx_uart_dma	*dma = p->dma;
> +	struct device *dma_map_ops_dev = p->port.dev;
>  
>  	if (dma->rx_chan) {
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
>  		dmaengine_terminate_all(dma->rx_chan);
> -		dma_unmap_single(p->port.dev, dma->rx_addr,
> +		dma_unmap_single(dma_map_ops_dev, dma->rx_addr,
>  				dma->rx_size, DMA_FROM_DEVICE);
>  		kfree(dma->rx_buf);
>  		dma_release_channel(dma->rx_chan);
> @@ -1150,8 +1187,9 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>  	}
>  
>  	if (dma->tx_chan) {
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>  		dmaengine_terminate_all(dma->tx_chan);
> -		dma_unmap_single(p->port.dev, dma->tx_addr,
> +		dma_unmap_single(dma_map_ops_dev, dma->tx_addr,
>  				UART_XMIT_SIZE, DMA_TO_DEVICE);
>  		dma_release_channel(dma->tx_chan);
>  		dma->tx_chan = NULL;
> -- 
> 2.17.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
