Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0096C2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68155214D8
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="TQ7DOgDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbgDPP2y (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:28:54 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:52735 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388103AbgDPP2u (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 11:28:50 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D676322EE4;
        Thu, 16 Apr 2020 17:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587050924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hod37Tbx4D95lwRpJwm0Ts2wLjFn0Fqn8R4SNk7Whbc=;
        b=TQ7DOgDI3JLzvpH0O/fJBsIyuK2k7pU9yqegZJpKD0WoPlLEx/ncJt+jezaGA36f89cbRY
        BpdKWOJwcSLe6d/BKUa7822w1S4BhHvR6IjcstLAVb06PBNU8lAWfX4leEuVJY/yFhDB1z
        5JiuVWjQVeusHeksS1p62ArKap8Nh30=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 17:28:44 +0200
From:   Michael Walle <michael@walle.cc>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: fsl_lpuart: Change DMA failure messages to debug
 level
In-Reply-To: <20200416151541.18385-1-festevam@gmail.com>
References: <20200416151541.18385-1-festevam@gmail.com>
Message-ID: <60a8e3864d3dcf3b122a7ea4e71486f2@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: D676322EE4
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_SOME(0.00)[];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.706];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2020-04-16 17:15, schrieb Fabio Estevam:
> Since commit 159381df1442 ("tty: serial: fsl_lpuart: fix DMA operation 
> when
> using IOMMU") commit the following messages are seen when booting 
> i.MX8QXP:

Are you sure, they weren't seen before? Because before the commit there 
were
the same just in _probe() (as dev_info()).

I'm fine with changing it to debug messages, though.

-michael

> fsl-lpuart 5a060000.serial: DMA tx channel request failed, operating
> without tx DMA (-19)
> fsl-lpuart 5a060000.serial: DMA rx channel request failed, operating
> without rx DMA (-19)
> 
> It is not really useful to have such messages on every boot, so change
> them to debug level instead.
> 
> Fixes: 159381df1442 ("tty: serial: fsl_lpuart: fix DMA operation when
> using IOMMU")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c 
> b/drivers/tty/serial/fsl_lpuart.c
> index 5d41075964f2..11131cd6cb30 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1514,17 +1514,17 @@ static void lpuart_request_dma(struct
> lpuart_port *sport)
>  {
>  	sport->dma_tx_chan = dma_request_chan(sport->port.dev, "tx");
>  	if (IS_ERR(sport->dma_tx_chan)) {
> -		dev_info_once(sport->port.dev,
> -			      "DMA tx channel request failed, operating without tx DMA 
> (%ld)\n",
> -			      PTR_ERR(sport->dma_tx_chan));
> +		dev_dbg_once(sport->port.dev,
> +			     "DMA tx channel request failed, operating without tx DMA 
> (%ld)\n",
> +			     PTR_ERR(sport->dma_tx_chan));
>  		sport->dma_tx_chan = NULL;
>  	}
> 
>  	sport->dma_rx_chan = dma_request_chan(sport->port.dev, "rx");
>  	if (IS_ERR(sport->dma_rx_chan)) {
> -		dev_info_once(sport->port.dev,
> -			      "DMA rx channel request failed, operating without rx DMA 
> (%ld)\n",
> -			      PTR_ERR(sport->dma_rx_chan));
> +		dev_dbg_once(sport->port.dev,
> +			     "DMA rx channel request failed, operating without rx DMA 
> (%ld)\n",
> +			     PTR_ERR(sport->dma_rx_chan));
>  		sport->dma_rx_chan = NULL;
>  	}
>  }
