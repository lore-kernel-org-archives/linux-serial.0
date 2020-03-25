Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3D9C54FD0
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA052077D
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 12:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="p+V8zAWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYMoD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:44:03 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57235 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCYMoD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 08:44:03 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3E35523066;
        Wed, 25 Mar 2020 13:44:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585140240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFjOWM3zPNpG9EbncGNtT6aW5p6VygvkHoOTUB9/h6Q=;
        b=p+V8zAWjlLRNBQDe9bxI1Dbo6NjhbYPd60krnAvXvmkWi4tUY3+bjgJz2hejaJZlyR0Mvd
        8n8c7uPwGCOdykzbmHpac0Flh/9yBA8Umy95YNiMDd53LrtOa2E/xM26NTx8+j2CGiOIk3
        POY9G3VgYddpfBS8YKEPVv7h55bimZg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Mar 2020 13:44:00 +0100
From:   Michael Walle <michael@walle.cc>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Andy Duan <fugang.duan@nxp.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shawnguo@kernel.org, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RFC PATCH 3/3] tty: serial: fsl_lpuart: fix possible console
 deadlock
In-Reply-To: <VI1PR04MB6941AD02204DF50B8D24D23AEECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
References: <VI1PR04MB69413E158203E33D42E3B3B3EEF10@VI1PR04MB6941.eurprd04.prod.outlook.com>
 <20200324184758.8204-1-michael@walle.cc>
 <20200324184758.8204-3-michael@walle.cc>
 <VI1PR04MB6941AD02204DF50B8D24D23AEECE0@VI1PR04MB6941.eurprd04.prod.outlook.com>
Message-ID: <201514c22f86f3599385d4ddbeb71f1a@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 3E35523066
X-Spamd-Result: default: False [-0.10 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.846];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2020-03-25 13:21, schrieb Leonard Crestez:
> On 2020-03-24 8:48 PM, Michael Walle wrote:
>> If the kernel console output is on this console any
>> dev_{err,warn,info}() may result in a deadlock if the sport->port.lock
>> spinlock is already held. This is because the _console_write() try to
>> aquire this lock, too. Remove any error messages where the spinlock is
>> taken or print after the lock is released.
>> 
>> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> It seems that this was an issue even before commit 159381df1442 ("tty:
> serial: fsl_lpuart: fix DMA operation when using IOMMU") but these 
> error
> prints never triggered.

Yeah, it just triggers because there is now a print by default (if DMA 
is
not available) thus this RFC doesn't contain the Fixes: tag.

> Would it be possible to move all the dma alloc/config/prep outside the
> serial port lock? As it stands this still calls into dmaengine coode 
> and
> that might decide to print as well.

TBH I don't want to refactor the whole driver. All I wanted to do was to
add LS1028A support to this driver which already resulted in a 7 patches
series with various other bugfixes. Could NXP take this over? I could
certainly do rewiews/testing on my board, though.

> Really I don't think the lock needs to protect more than bits like
> TDMAE/RDMAE.
> 
> BTW: You should add more people in CC for reviews, for example
> linux-imx@nxp.com is checked by a lot of people.

It would be good to have N: lpuart (or fsl_lpuart?) in the
corresponding entry in MAINTAINERS, so it will automatically added.
I'll try to remember for the next patches though.

-michael
> 
>> ---
>>   drivers/tty/serial/fsl_lpuart.c | 35 
>> +++++++--------------------------
>>   1 file changed, 7 insertions(+), 28 deletions(-)
>> 
>> diff --git a/drivers/tty/serial/fsl_lpuart.c 
>> b/drivers/tty/serial/fsl_lpuart.c
>> index bbba298b68a4..0910308b38b1 100644
>> --- a/drivers/tty/serial/fsl_lpuart.c
>> +++ b/drivers/tty/serial/fsl_lpuart.c
>> @@ -420,7 +420,6 @@ static void lpuart_dma_tx(struct lpuart_port 
>> *sport)
>>   {
>>   	struct circ_buf *xmit = &sport->port.state->xmit;
>>   	struct scatterlist *sgl = sport->tx_sgl;
>> -	struct device *dev = sport->port.dev;
>>   	struct dma_chan *chan = sport->dma_tx_chan;
>>   	int ret;
>> 
>> @@ -442,10 +441,8 @@ static void lpuart_dma_tx(struct lpuart_port 
>> *sport)
>> 
>>   	ret = dma_map_sg(chan->device->dev, sgl, sport->dma_tx_nents,
>>   			 DMA_TO_DEVICE);
>> -	if (!ret) {
>> -		dev_err(dev, "DMA mapping error for TX.\n");
>> +	if (!ret)
>>   		return;
>> -	}
>> 
>>   	sport->dma_tx_desc = dmaengine_prep_slave_sg(chan, sgl,
>>   					ret, DMA_MEM_TO_DEV,
>> @@ -453,7 +450,6 @@ static void lpuart_dma_tx(struct lpuart_port 
>> *sport)
>>   	if (!sport->dma_tx_desc) {
>>   		dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
>>   			      DMA_TO_DEVICE);
>> -		dev_err(dev, "Cannot prepare TX slave DMA!\n");
>>   		return;
>>   	}
>> 
>> @@ -520,21 +516,12 @@ static int lpuart_dma_tx_request(struct 
>> uart_port *port)
>>   	struct lpuart_port *sport = container_of(port,
>>   					struct lpuart_port, port);
>>   	struct dma_slave_config dma_tx_sconfig = {};
>> -	int ret;
>> 
>>   	dma_tx_sconfig.dst_addr = lpuart_dma_datareg_addr(sport);
>>   	dma_tx_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>>   	dma_tx_sconfig.dst_maxburst = 1;
>>   	dma_tx_sconfig.direction = DMA_MEM_TO_DEV;
>> -	ret = dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
>> -
>> -	if (ret) {
>> -		dev_err(sport->port.dev,
>> -				"DMA slave config failed, err = %d\n", ret);
>> -		return ret;
>> -	}
>> -
>> -	return 0;
>> +	return dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
>>   }
>> 
>>   static bool lpuart_is_32(struct lpuart_port *sport)
>> @@ -1074,8 +1061,8 @@ static void lpuart_copy_rx_to_tty(struct 
>> lpuart_port *sport)
>> 
>>   	dmastat = dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
>>   	if (dmastat == DMA_ERROR) {
>> -		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
>>   		spin_unlock_irqrestore(&sport->port.lock, flags);
>> +		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
>>   		return;
>>   	}
>> 
>> @@ -1179,23 +1166,17 @@ static inline int lpuart_start_rx_dma(struct 
>> lpuart_port *sport)
>>   	sg_init_one(&sport->rx_sgl, ring->buf, sport->rx_dma_rng_buf_len);
>>   	nent = dma_map_sg(chan->device->dev, &sport->rx_sgl, 1,
>>   			  DMA_FROM_DEVICE);
>> -
>> -	if (!nent) {
>> -		dev_err(sport->port.dev, "DMA Rx mapping error\n");
>> +	if (!nent)
>>   		return -EINVAL;
>> -	}
>> 
>>   	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
>>   	dma_rx_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>>   	dma_rx_sconfig.src_maxburst = 1;
>>   	dma_rx_sconfig.direction = DMA_DEV_TO_MEM;
>> -	ret = dmaengine_slave_config(chan, &dma_rx_sconfig);
>> 
>> -	if (ret < 0) {
>> -		dev_err(sport->port.dev,
>> -				"DMA Rx slave config failed, err = %d\n", ret);
>> +	ret = dmaengine_slave_config(chan, &dma_rx_sconfig);
>> +	if (ret < 0)
>>   		return ret;
>> -	}
>> 
>>   	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
>>   				 sg_dma_address(&sport->rx_sgl),
>> @@ -1203,10 +1184,8 @@ static inline int lpuart_start_rx_dma(struct 
>> lpuart_port *sport)
>>   				 sport->rx_sgl.length / 2,
>>   				 DMA_DEV_TO_MEM,
>>   				 DMA_PREP_INTERRUPT);
>> -	if (!sport->dma_rx_desc) {
>> -		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
>> +	if (!sport->dma_rx_desc)
>>   		return -EFAULT;
>> -	}
>> 
>>   	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
>>   	sport->dma_rx_desc->callback_param = sport;
>> 
