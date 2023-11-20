Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0FC2BB3F
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 21:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjKTVTg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 16:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjKTVTf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 16:19:35 -0500
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B261CD
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 13:19:31 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5Bfyrw7Pe67J55BfyrmViA; Mon, 20 Nov 2023 22:19:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700515169;
        bh=NDPnmqlk0LUSy3aJ8u4TckgJQVNR/Wz4QBNCWhD8QiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IkGePgdiytlmlYIsvLgHrV3QcmXS/XmZfe8oEEncW/6oLcIaWKQwAKWpzyQ9zQ/Eu
         hDz6csT6bF21q2VmW3PcqwIMOgfxTO98BhNsvUc+k0UeWmX986fXyyFx/+CMcXT2Rk
         hRM4EGJHHP4+36lKRVCU8okurLB9CgbBgVxto/m/Y5ewNNdTN5FBEqLYadIFPAWCK9
         86NI8NpjOvX3HyZVWqnyt8dAJsntBlDOG6IO+eyKcxtxWdCtExSOt0Wl2n6Ozzpl9F
         PsgUKd9KGXe/oQVlSX+syna5KbUox0zWIgekrtfCWQcjoqus4t9DQ2bqr6Y3VKYjJg
         8/fnGp8CVIoow==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 Nov 2023 22:19:29 +0100
X-ME-IP: 86.243.2.178
Message-ID: <c29e4d22-78b4-4265-b459-7cee38149084@wanadoo.fr>
Date:   Mon, 20 Nov 2023 22:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: atmel: convert not to use
 dma_request_slave_channel()
To:     claudiu beznea <claudiu.beznea@tuxon.dev>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <f2e9790d8b49aeba8b43ce018d30a35b837ac1eb.1700409299.git.christophe.jaillet@wanadoo.fr>
 <ccfcf2a5-c04b-4781-8658-d63044b9b9c6@tuxon.dev>
 <5c2ec2ff-459e-4bb7-b287-8a06005c86f5@kernel.org>
 <e37ce03e-4e41-4262-9f54-bcbab3bb1421@tuxon.dev>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <e37ce03e-4e41-4262-9f54-bcbab3bb1421@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Le 20/11/2023 à 08:12, claudiu beznea a écrit :
> 
> 
> On 20.11.2023 09:04, Jiri Slaby wrote:
>> On 20. 11. 23, 7:14, claudiu beznea wrote:
>>> Hi, Christophe,
>>>
>>> On 19.11.2023 17:55, Christophe JAILLET wrote:
>>>> dma_request_slave_channel() is deprecated. dma_request_chan() should
>>>> be used directly instead.
>>>>
>>>> Switch to the preferred function and update the error handling accordingly.
>>>>
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> ---
>>>> v2: Also update atmel_prepare_rx_dma()
>>>> ---
>>>>    drivers/tty/serial/atmel_serial.c | 16 ++++++++++++----
>>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/atmel_serial.c
>>>> b/drivers/tty/serial/atmel_serial.c
>>>> index 1946fafc3f3e..6aeb4648843b 100644
>>>> --- a/drivers/tty/serial/atmel_serial.c
>>>> +++ b/drivers/tty/serial/atmel_serial.c
>>>> @@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port
>>>> *port)
>>>>        struct device *mfd_dev = port->dev->parent;
>>>>        dma_cap_mask_t        mask;
>>>>        struct dma_slave_config config;
>>>> +    struct dma_chan *chan;
>>>
>>> There is no need for this.
>>
>> How'd you avoid crash in here then:
>>          if (atmel_port->chan_tx)
>>                  atmel_release_tx_dma(port);
>> ?
> 
> I wanted to say that instead of adding the chan variable the
> atmel_port->chan_tx would be used instead.

You mean something like:

-	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
-	if (atmel_port->chan_tx == NULL)
+	atmel_port->chan_tx = dma_request_chan(mfd_dev, "tx");
+	if (IS_ERR(atmel_port->chan_tx)) {
+		atmel_port->chan_tx = NULL;

?

Mostly a mater of taste. I can send a v3 with that if it is the 
preferred style.

CJ

> 
>>
>> thanks,
> 

