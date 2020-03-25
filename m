Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE3C1975A
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3599A206F6
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 09:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="qiqUR5Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCYJPL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:15:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44383 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCYJPL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 05:15:11 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 07E26231D9;
        Wed, 25 Mar 2020 10:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585127709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7ZYpCu3y5VBknHHroaIr6qJRGVeDFYMf8WyXcXqn+A=;
        b=qiqUR5CuH+lfxFzhhIYXkPHKuIOfno8ydhV1xiuzBOqpnSIFvgmBU0zh/Z2mGlJISQ3Zol
        CmLf1fM12jxZAjldYsbQZCFG465AIyRhbqfF7F1NTu6bLt6CHOoI7/WJtCsM6mnJWOGc1F
        NRBE6m/MZQxW1fxTVSyOEDxHiQkbODM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Mar 2020 10:15:08 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/3] tty: serial: fsl_lpuart: move dev_info_once()
In-Reply-To: <20200324184758.8204-1-michael@walle.cc>
References: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <20200324184758.8204-1-michael@walle.cc>
Message-ID: <e9ee810ff8f9df34451de3b1d2b7c04f@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 07E26231D9
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.708];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2020-03-24 19:47, schrieb Michael Walle:
> Don't take the spinlock and use dev_info_once(). This may cause a hang
> because the console takes this spinlock, too. Just print this info 
> after
> we've released the lock.
> 
> Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when
> using IOMMU")
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Because the patch subject was renamed: This patch series is superseded
by the v2:
  
https://lore.kernel.org/linux-serial/20200325090658.25967-1-michael@walle.cc/

I didn't include the 3/3 RFC patch though. This is a bigger change, 
which
should be carefully reviewed by the maintainer of the fsl_lpuart.c.

-michael


> ---
>  drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c 
> b/drivers/tty/serial/fsl_lpuart.c
> index 9c6a018b1390..960fc2658f19 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1517,9 +1517,6 @@ static void lpuart_tx_dma_startup(struct
> lpuart_port *sport)
> 
>  	sport->dma_tx_chan = dma_request_chan(sport->port.dev, "tx");
>  	if (IS_ERR(sport->dma_tx_chan)) {
> -		dev_info_once(sport->port.dev,
> -			      "DMA tx channel request failed, operating without tx DMA 
> (%ld)\n",
> -			      PTR_ERR(sport->dma_tx_chan));
>  		sport->dma_tx_chan = NULL;
>  		goto err;
>  	}
> @@ -1551,9 +1548,6 @@ static void lpuart_rx_dma_startup(struct
> lpuart_port *sport)
> 
>  	sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
>  	if (IS_ERR(sport->dma_rx_chan)) {
> -		dev_info_once(sport->port.dev,
> -			      "DMA rx channel request failed, operating without rx DMA 
> (%ld)\n",
> -			      PTR_ERR(sport->dma_rx_chan));
>  		sport->dma_rx_chan = NULL;
>  		goto err;
>  	}
> @@ -1601,6 +1595,13 @@ static int lpuart_startup(struct uart_port 
> *port)
> 
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
> 
> +	if (!sport->dma_rx_chan)
> +		dev_info_once(sport->port.dev,
> +			      "DMA rx channel request failed, operating without rx DMA\n");
> +	if (!sport->dma_tx_chan)
> +		dev_info_once(sport->port.dev,
> +			      "DMA tx channel request failed, operating without tx DMA\n");
> +
>  	return 0;
>  }
> 
> @@ -1653,13 +1654,20 @@ static int lpuart32_startup(struct uart_port 
> *port)
> 
>  	lpuart32_setup_watermark_enable(sport);
> 
> -
>  	lpuart_rx_dma_startup(sport);
>  	lpuart_tx_dma_startup(sport);
> 
>  	lpuart32_configure(sport);
> 
>  	spin_unlock_irqrestore(&sport->port.lock, flags);
> +
> +	if (!sport->dma_rx_chan)
> +		dev_info_once(sport->port.dev,
> +			      "DMA rx channel request failed, operating without rx DMA\n");
> +	if (!sport->dma_tx_chan)
> +		dev_info_once(sport->port.dev,
> +			      "DMA tx channel request failed, operating without tx DMA\n");
> +
>  	return 0;
>  }
