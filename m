Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D02EC2BB3F
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 06:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjKTGOj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 01:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKTGOi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 01:14:38 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C3DE
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 22:14:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso13182685e9.2
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 22:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700460873; x=1701065673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbbQXlLM5rzQD/2Q3ynuAoYoACD7YY6nmC8tH95Lw5U=;
        b=SXAvK+LUHUvVNYrXHgMbByyw/BTUJAw81uk81cygdcxEhGOUsKTSIBX6SfBl3p0hTs
         ZO4vjYCtfNs5Ykpl7RqdN4lrahN1jBV3SNNzlXQcjRwDwguCfWn+wsxBgIZcmodFVKwE
         50vcQsK4xPfcpQ1o1o3iEFoyRK6vz1GZL3Ib1DC9/3zK5zhxk2n7R0LtvcxlVNv75FtQ
         hlPCnCfDJJChREmjJieIZ7LwrACSYhOXOkRBi1pARpB9Ip/r9+FoDdtezCxfGZ2zszat
         4iQdivC8zZOYnA13Fy1ryVzJDRsMR2LlSoM7TGEYsgdIfYgkbIZtHC3pJxrLd/JVi8qt
         rrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700460873; x=1701065673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbbQXlLM5rzQD/2Q3ynuAoYoACD7YY6nmC8tH95Lw5U=;
        b=H/ef0iA3m2vxFRiziwCJo1C1oUESGU0VGFU08DNzH8U8DGSVb0TBIXEJUyUp0hXlgg
         ckz3bx8D80ZCkWRmwukoThijMPgfg0w++30gBRdDEDX0Ho2damxwQ2CNupu9k+Dkm0bm
         I07KYZWyhVOJC5QpZg7X7eLzMs1UbtgVHYiefpNYDkLvQXScQlt72ZtRPjpHGSnd53xO
         ebuxEftT9TkV8te2LmnpMRBmaSdAKaUxH5tQdI53h8c8OD0uCSLF3hPhdm7ICUqHTeSr
         X7s/4C292YlfQc3/li+lI83vxIn17ZoezByWvznNsq4qfSYXPhMBU1Yrt9aBk/O303qU
         mB7g==
X-Gm-Message-State: AOJu0Ywp0X0HiZcuou4KO/vJGWRKk72a4vQM4fTT2Pr/Z4v+liZN0yoz
        J6wgifiHcvqlC48iW//UTqwGkw==
X-Google-Smtp-Source: AGHT+IGzKv935lOdpZd3Z+/Bot9oeXhwBAS3lV+3fYuXbVgc69YgQXsGKDnfj1wjbrzAY3h8y9FHeg==
X-Received: by 2002:a05:600c:3c9b:b0:40a:3e41:7dd8 with SMTP id bg27-20020a05600c3c9b00b0040a3e417dd8mr4698567wmb.13.1700460872980;
        Sun, 19 Nov 2023 22:14:32 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b00405959469afsm12486333wms.3.2023.11.19.22.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Nov 2023 22:14:32 -0800 (PST)
Message-ID: <ccfcf2a5-c04b-4781-8658-d63044b9b9c6@tuxon.dev>
Date:   Mon, 20 Nov 2023 08:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: atmel: convert not to use
 dma_request_slave_channel()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Christophe,

On 19.11.2023 17:55, Christophe JAILLET wrote:
> dma_request_slave_channel() is deprecated. dma_request_chan() should
> be used directly instead.
> 
> Switch to the preferred function and update the error handling accordingly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Also update atmel_prepare_rx_dma()
> ---
>  drivers/tty/serial/atmel_serial.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 1946fafc3f3e..6aeb4648843b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
>  	struct device *mfd_dev = port->dev->parent;
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
> +	struct dma_chan *chan;

There is no need for this.

>  	int ret, nent;
>  
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
> -	if (atmel_port->chan_tx == NULL)
> +	chan = dma_request_chan(mfd_dev, "tx");
> +	if (IS_ERR(chan)) {
> +		atmel_port->chan_tx = NULL;
>  		goto chan_err;
> +	}
> +	atmel_port->chan_tx = chan;
>  	dev_info(port->dev, "using %s for tx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_tx));
>  
> @@ -1188,6 +1192,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_mask_t		mask;
>  	struct dma_slave_config config;
>  	struct circ_buf		*ring;
> +	struct dma_chan *chan;

Ditto

>  	int ret, nent;
>  
>  	ring = &atmel_port->rx_ring;
> @@ -1195,9 +1200,12 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_CYCLIC, mask);
>  
> -	atmel_port->chan_rx = dma_request_slave_channel(mfd_dev, "rx");
> -	if (atmel_port->chan_rx == NULL)
> +	chan = dma_request_chan(mfd_dev, "rx");
> +	if (IS_ERR(chan)) {
> +		atmel_port->chan_rx = NULL;
>  		goto chan_err;
> +	}
> +	atmel_port->chan_rx = chan;
>  	dev_info(port->dev, "using %s for rx DMA transfers\n",
>  		dma_chan_name(atmel_port->chan_rx));
>  
