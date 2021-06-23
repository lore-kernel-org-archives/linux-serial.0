Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939E3C48BE5
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74300611AD
	for <linux-serial@archiver.kernel.org>; Wed, 23 Jun 2021 06:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWGMp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Jun 2021 02:12:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48287 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWGMp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Jun 2021 02:12:45 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvw5j-0003fB-He
        for linux-serial@vger.kernel.org; Wed, 23 Jun 2021 06:10:27 +0000
Received: by mail-wr1-f69.google.com with SMTP id d8-20020adfef880000b029011a9391927aso627596wro.22
        for <linux-serial@vger.kernel.org>; Tue, 22 Jun 2021 23:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9t0SpY9WzRKzn18XeKzMvMayH4y5biXjE4wkqK4Ctvo=;
        b=f1C3y3jMH9WX9gc/WOWJi5wFmiH+NFVhFCVISz9tbyYq2x4t0x35KIIirf9PPS9Zrj
         dJbbZRrKGokDWrgD53yBwIlC+MDNeQLjhQ4WZniEOBFPW7Oy6aOeIqAQr85jS4COpzqb
         gpgHiDDqAcCxVvebZNXoGkYixaE9Q2Wr8u59vdulQ4pjdDwCogSZrga4bJiLgG84ZIlr
         vYekLWJ8wqTx4ltS6hgNq1Vw78eotxlWqhss1Hvwjac5w2wpKHPKffICwmCeXAZLBMnW
         pnReDK1R7dbl8QkPKSh13Vxkgz9+AbD+prN6VPa2Y+eZAZNtXSnujZGnSNbvyIvzBmlw
         /MPw==
X-Gm-Message-State: AOAM531FtvbaTy/fq8vPDSc/NdJMlbAwZKmp1khddaVb5w2qwt0nqse1
        wr976leSze8AOkOisFyAVL6JBbQ7hj9NDvPkF7r6qHEfIU4oNet7ylnoixDybf6No+2FvZwp8e4
        GRHg0lRyHgLfGwM3hw4q5j/seALBBLHL9AdejozrGJg==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr9772141wrq.51.1624428625768;
        Tue, 22 Jun 2021 23:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws/Nlnt0zVsVciqND3NNjQEyw/qM1mD4FpFKusmptdlY8X28sBkZRDCbntz4v+/+ly1rbg5w==
X-Received: by 2002:a5d:4a01:: with SMTP id m1mr9772121wrq.51.1624428625587;
        Tue, 22 Jun 2021 23:10:25 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id n4sm1672835wrw.21.2021.06.22.23.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 23:10:25 -0700 (PDT)
Subject: Re: [PATCH v3] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com
References: <CGME20210622091321epcas5p42e0a80b034f22ae9b82a3377193bb972@epcas5p4.samsung.com>
 <20210622091710.44032-1-m.shams@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e511bd16-fb50-bc63-d0c5-a8b4e5e78525@canonical.com>
Date:   Wed, 23 Jun 2021 08:10:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622091710.44032-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 22/06/2021 11:17, Tamseel Shams wrote:
> When DMA is used for TX and RX by serial driver, it should
> pass the DMA device pointer to DMA API instead of UART device
> pointer. DMA device should be used for DMA API because only
> the DMA device is aware of how the device connects to the memory.
> There might be an extra level of address translation due to a
> SMMU attached to the DMA device. When serial device pointer device
> is used for DMA API, the DMA API will have no clue of the SMMU
> attached to the DMA device.
> 
> This patch is necessary to fix the SMMU page faults
> which is observed when a DMA(with SMMU enabled) is attached
> to UART for transfer.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
> Changes since v1:
> 1. Rebased the patch on "tty-next" branch of TTY driver tree
> 
> Changes since v2:
> 1. Updated the commit message.
> 2. Changed the comment description
> 
>  drivers/tty/serial/samsung_tty.c | 62 +++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 9fbc61151c2e..7dd648cb7237 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>  	struct circ_buf *xmit = &port->state->xmit;
>  	struct dma_tx_state state;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>  	int count;
>  
> +	/* Null pointer check for "dma" and "dma->tx_chan" */

The comment is not useful.

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
> +	/* Null pointer check for "dma" and "dma->tx_chan" */
> +	if (dma && dma->tx_chan)


What is the "else" here? How is it even possible? Why having this "if"
at all?

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
> +	/* Null pointer check for "dma" and "dma->tx_chan" */
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
> +	/* Null pointer check for "dma" and "dma->rx_chan" */
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
> +	/* Null pointer check for "dma" and "dma->rx_chan" */
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
> +	/* Null pointer check for "dma" and "dma->rx_chan" */
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
> +	/* Null pointer check for "dma" and "dma->tx_chan" */
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
> 


Best regards,
Krzysztof
