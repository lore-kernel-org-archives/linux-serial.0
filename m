Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682BC49EA2
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 09:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BA376120D
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 09:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFUJOr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:14:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFUJOr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 05:14:47 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvFyq-000851-1F
        for linux-serial@vger.kernel.org; Mon, 21 Jun 2021 09:12:32 +0000
Received: by mail-ed1-f70.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so5351691edt.13
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 02:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OtPiQ6OO2TAsBjszsku45Z1ropnsh33Pp8/MGScgIYo=;
        b=PjJYycKltsbgyyWC+FN9P+s1MZNR4oLuhBx9uMJcTzoTPH+fj8COFbc3MXc20TFY/4
         vfVDagy605LYlkNhH6bW1SQb53sD8KCG0juYk/4a9u4BhOXt90kyAcGiNswoXWpGgTvm
         SNF+qhU8+j5VIeS2a9BpSQcgzf16E4IwFv8ii4BIt3KREv9MyLqdeLRw0lHy48uy1T84
         QG0iO4zmrefkfST/IHbjazvV7EWLtIA3zuCGFbC46ieL0B6lu5mBCEOaVL9/ZXNQTIZV
         ANjkNxJSSVppt3P3DIuLDvJtWLaFIYf5gW6q0WRBEIe71ZswCBaRSz3yUCx6861nYnam
         bYbw==
X-Gm-Message-State: AOAM5312SfRAci60vFby5tSX4Hs0f7TyvUQX0I4kZ88P3fPoacQtzM9P
        YEbg/VJLMuySIrPog1M5xpPvJcJ2KJn37uEhn3hFNjfWqqNd2cDOwEu0qkj2NHyjoRd+bpZ+yBs
        nTia2UwPf/hceuCQbYrY/pzBtP1GNNG44nlb0Q/lozg==
X-Received: by 2002:aa7:d918:: with SMTP id a24mr20823928edr.235.1624266751823;
        Mon, 21 Jun 2021 02:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx35TuP3/cSWQbzdJJMY8jXV8k6q7uF2M0jTZBEo1Y1rV/AqfoC9y+u6ebe35GLSRbSnmTRg==
X-Received: by 2002:aa7:d918:: with SMTP id a24mr20823912edr.235.1624266751658;
        Mon, 21 Jun 2021 02:12:31 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id v26sm4608693ejk.70.2021.06.21.02.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 02:12:31 -0700 (PDT)
Subject: Re: [PATCH] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>, kgene@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com
References: <CGME20210621044517epcas5p187affa518a18a3d019deb0c189cd8396@epcas5p1.samsung.com>
 <20210621044916.41564-1-m.shams@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8935a448-04b7-91ce-203a-9f0d7e377052@canonical.com>
Date:   Mon, 21 Jun 2021 11:12:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210621044916.41564-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Thanks for the patch.

On 21/06/2021 06:49, Tamseel Shams wrote:
> When DMA is used for TX and RX by serial driver, it should
> pass the DMA device pointer to DMA API instead of UART device
> pointer.

Hmmm, but why DMA device pointer should be used?

> 
> This patch is necessary to fix the SMMU page faults
> which is observed when a DMA(with SMMU enabled) is attached
> to UART for transfer.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/tty/serial/samsung_tty.c | 60 +++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index b923683e6a25..5bdc7dd2a5e2 100644
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

You mention here and further comments "dma_ops". I don't see you
changing the DMA ops, but the device. It's quite confusing. I think you
meant a DMA device shall be passed to DMA API?

Second question: you write that DMA devices should be used if DMA is
attached and in the code you follow such pattern a lot:

> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
> +

Are you trying to say that if DMA is not attached, UART device should be
used? If DMA is not attached, how are the DMA operations used then?

>  	if (!ourport->tx_enabled)
>  		return;
>  
> @@ -298,7 +303,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
>  		dmaengine_pause(dma->tx_chan);
>  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>  		dmaengine_terminate_all(dma->tx_chan);
> -		dma_sync_single_for_cpu(ourport->port.dev,
> +		dma_sync_single_for_cpu(dma_map_ops_dev,
>  			dma->tx_transfer_addr, dma->tx_size, DMA_TO_DEVICE);
>  		async_tx_ack(dma->tx_desc);
>  		count = dma->tx_bytes_requested - state.residue;
> @@ -324,15 +329,19 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
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
>  
>  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>  	count = dma->tx_bytes_requested - state.residue;
>  	async_tx_ack(dma->tx_desc);
>  
> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
>  				dma->tx_size, DMA_TO_DEVICE);
>  
>  	spin_lock_irqsave(&port->lock, flags);
> @@ -408,7 +417,11 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>  	struct uart_port *port = &ourport->port;
>  	struct circ_buf *xmit = &port->state->xmit;
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>  
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->tx_chan)
> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>  
>  	if (ourport->tx_mode != S3C24XX_TX_DMA)
>  		enable_tx_dma(ourport);
> @@ -416,7 +429,7 @@ static int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
>  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
>  
> -	dma_sync_single_for_device(ourport->port.dev, dma->tx_transfer_addr,
> +	dma_sync_single_for_device(dma_map_ops_dev, dma->tx_transfer_addr,
>  				dma->tx_size, DMA_TO_DEVICE);
>  
>  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
> @@ -483,12 +496,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct s3c24xx_uart_port *ourport,
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
> @@ -600,8 +618,13 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
>  static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port *ourport)
>  {
>  	struct s3c24xx_uart_dma *dma = ourport->dma;
> +	struct device *dma_map_ops_dev = ourport->port.dev;
>  
> -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
> +	/* Pick dma_ops of DMA device if DMA device is attached */
> +	if (dma && dma->rx_chan)
> +		dma_map_ops_dev = dma->rx_chan->device->dev;
> +
> +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
>  				dma->rx_size, DMA_FROM_DEVICE);
>  
>  	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
> @@ -983,6 +1006,7 @@ static int s3c24xx_serial_request_dma(struct s3c24xx_uart_port *p)

Offset of hunks looks here significantly different than mainline. The
patch should be based and tested mainline tree. Which one did you choose
as base?

Using my email address not from get_maintainers.pl also suggests that
you don't use anything recent as a base.

Best regards,
Krzysztof
