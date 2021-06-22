Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCEC2B9F4
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 12:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87FDB6135D
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 12:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFVMnJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 08:43:09 -0400
Received: from foss.arm.com ([217.140.110.172]:48574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231468AbhFVMmk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 08:42:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C75ED1;
        Tue, 22 Jun 2021 05:40:23 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794C83F694;
        Tue, 22 Jun 2021 05:40:21 -0700 (PDT)
Subject: Re: [PATCH v2] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>,
        krzysztof.kozlowski@canonical.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com
References: <CGME20210622034818epcas5p3837ce2315f5c57980576f10b8fc7efeb@epcas5p3.samsung.com>
 <20210622035202.5260-1-m.shams@samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1395f98a-4bb3-581c-0b8b-cb23a86d76c3@arm.com>
Date:   Tue, 22 Jun 2021 13:40:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622035202.5260-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-06-22 04:52, Tamseel Shams wrote:
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
>   drivers/tty/serial/samsung_tty.c | 62 +++++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..0c924bb6108e 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>   	struct s3c24xx_uart_dma *dma = ourport->dma;
>   	struct circ_buf *xmit = &port->state->xmit;
>   	struct dma_tx_state state;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>   	int count;
>   
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
> +
>   	if (!ourport->tx_enabled)
>   		return;
>   
> @@ -305,7 +310,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>   		dmaengine_pause(dma->tx_chan);
>   		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>   		dmaengine_terminate_all(dma->tx_chan);
> -		dma_sync_single_for_cpu(ourport->port.dev,
> +		dma_sync_single_for_cpu(dma_map_ops_dev,
>   			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
>   		async_tx_ack(dma->tx_desc);
>   		count = dma->tx_bytes_requested - state.residue;
> @@ -331,14 +336,19 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>   	struct circ_buf *xmit = &port->state->xmit;
>   	struct s3c24xx_uart_dma *dma = ourport->dma;
>   	struct dma_tx_state state;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>   	unsigned long flags;
>   	int count;
>   
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)

Clearly you don't need most of these checks, if any. For example here 
you're already dereferencing dma->tx_chan unconditionally a couple of 
lines below.

AFAICS it should simply be a case of hard-coding the correct device for 
all of the DMA API calls without any of this silly conditional 
assignment. If it's even possible to reach the point of making a DMA API 
call when you don't have a valid DMA channel (and thus it would be 
pointless anyway), that implies a more general issue with the structure 
of the code which deserves fixing in its own right.

Robin.

> +		dma_map_ops_dev = dma->tx_chan->device->dev;
> +
>   	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>   	count = dma->tx_bytes_requested - state.residue;
>   	async_tx_ack(dma->tx_desc);
>   
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
>   				dma->tx_size, DMA_TO_DEVICE);
>   
>   	spin_lock_irqsave(&port->lock, flags);
> @@ -436,6 +446,11 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>   	struct uart_port *port = &ourport->port;
>   	struct circ_buf *xmit = &port->state->xmit;
>   	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
> +
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>   
>   	if (ourport->tx_mode != S3C24XX_TX_DMA)
>   		enable_tx_dma(ourport);
> @@ -443,7 +458,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>   	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
>   	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
>   
> -	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
> +	dma_sync_single_for_device(dma_map_ops_dev, dma->tx_transfer_addr,
>   				dma->tx_size, DMA_TO_DEVICE);
>   
>   	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
> @@ -510,12 +525,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
>   		struct tty_port *tty, int count)
>   {
>   	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>   	int copied;
>   
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +
>   	if (!count)
>   		return;
>   
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
>   				dma->rx_size, DMA_FROM_DEVICE);
>   
>   	ourport->port.icount.rx += count;
> @@ -635,8 +655,13 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
>   static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
>   {
>   	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
> +
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
>   
> -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
>   				dma->rx_size, DMA_FROM_DEVICE);
>   
>   	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
> @@ -1045,6 +1070,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   	struct s3c24xx_uart_dma	*dma = p->dma;
>   	struct dma_slave_caps dma_caps;
>   	const char *reason = NULL;
> +	struct device *dma_map_ops_dev = p->port.dev;
>   	int ret;
>   
>   	/* Default slave configuration parameters */
> @@ -1102,18 +1128,25 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   		goto err_release_tx;
>   	}
>   
> -	dma->rx_addr = dma_map_single(p->port.dev, dma->rx_buf,
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +
> +	dma->rx_addr = dma_map_single(dma_map_ops_dev, dma->rx_buf,
>   				dma->rx_size, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(p->port.dev, dma->rx_addr)) {
> +	if (dma_mapping_error(dma_map_ops_dev, dma->rx_addr)) {
>   		reason = "DMA mapping error for RX buffer";
>   		ret = -EIO;
>   		goto err_free_rx;
>   	}
>   
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>   	/* TX buffer */
> -	dma->tx_addr = dma_map_single(p->port.dev, p->port.state->xmit.buf,
> +	dma->tx_addr = dma_map_single(dma_map_ops_dev, p->port.state->xmit.buf,
>   				UART_XMIT_SIZE, DMA_TO_DEVICE);
> -	if (dma_mapping_error(p->port.dev, dma->tx_addr)) {
> +	if (dma_mapping_error(dma_map_ops_dev, dma->tx_addr)) {
>   		reason = "DMA mapping error for TX buffer";
>   		ret = -EIO;
>   		goto err_unmap_rx;
> @@ -1122,7 +1155,9 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   	return 0;
>   
>   err_unmap_rx:
> -	dma_unmap_single(p->port.dev, dma->rx_addr, dma->rx_size,
> +	if (dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +	dma_unmap_single(dma_map_ops_dev, dma->rx_addr, dma->rx_size,
>   			 DMA_FROM_DEVICE);
>   err_free_rx:
>   	kfree(dma->rx_buf);
> @@ -1139,10 +1174,12 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)
>   static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>   {
>   	struct s3c24xx_uart_dma	*dma = p->dma;
> +	struct device *dma_map_ops_dev = p->port.dev;
>   
>   	if (dma->rx_chan) {
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
>   		dmaengine_terminate_all(dma->rx_chan);
> -		dma_unmap_single(p->port.dev, dma->rx_addr,
> +		dma_unmap_single(dma_map_ops_dev, dma->rx_addr,
>   				dma->rx_size, DMA_FROM_DEVICE);
>   		kfree(dma->rx_buf);
>   		dma_release_channel(dma->rx_chan);
> @@ -1150,8 +1187,9 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
>   	}
>   
>   	if (dma->tx_chan) {
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>   		dmaengine_terminate_all(dma->tx_chan);
> -		dma_unmap_single(p->port.dev, dma->tx_addr,
> +		dma_unmap_single(dma_map_ops_dev, dma->tx_addr,
>   				UART_XMIT_SIZE, DMA_TO_DEVICE);
>   		dma_release_channel(dma->tx_chan);
>   		dma->tx_chan = NULL;
> 
