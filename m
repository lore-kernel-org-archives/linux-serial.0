Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ECBC48BDF
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 07:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3CF611BF
	for <linux-serial@archiver.kernel.org>; Tue, 22 Jun 2021 07:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFVHIf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Jun 2021 03:08:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41385 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVHIf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Jun 2021 03:08:35 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lvaUE-0002qU-6z
        for linux-serial@vger.kernel.org; Tue, 22 Jun 2021 07:06:18 +0000
Received: by mail-wr1-f72.google.com with SMTP id l6-20020a0560000226b029011a80413b4fso6020505wrz.23
        for <linux-serial@vger.kernel.org>; Tue, 22 Jun 2021 00:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lTXjEM62TZsdnqbafkcE1LO7W2CdxUF8uNFzRXMFweE=;
        b=kxQ2c4tYNQfltR/j535AqJGG8rQQMfBtLXwKZfs7MLBVutMbmDUiyYrXvdOq9ToQMU
         SZAO2Va+2j6NgLeNEvYuDoingYZQ9kb/ZJPZwkx/i7JjE6B42cBukJZoH71rvJ/ExwS3
         57bLXjCUXjk06uGQRhhh4Ibr2lZux7rS9kE3EtHcj67NqCx70KP9AXcb+GSJjm0GMEBo
         He9NoeQQU9m3FwLF7eflHM9dNMEIPiPnEYhCpZ/IOVm32t58DXX8iwo1RQi1j14/H/dC
         8zRYGOITEusV9gQTwOvmNUWLd6SaZuvP0G2NMdoSMgJIQidL0LnqI6gmTozxgPL8XN5f
         becw==
X-Gm-Message-State: AOAM533nPLo4c8mddsgaM39K3SnlDqBLV1i4aCMgdGEB24pA5zIqcliE
        +IoCILFuk0hplqD78irZQhinkBnTrWLgdt74VrmBLWSmEKtSlJzZYAd8m6/lRr2s/Ibdg41FC/l
        +zxZo2Lz94Ac9VXnl82TjDw2LFLq1SLu5/c469mzHMw==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr2790447wrx.347.1624345577986;
        Tue, 22 Jun 2021 00:06:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiXsFCAg1kqgd0xWRFS3Ug29pVJQn/MmYUKAXDKg2JDMTx0ckzB/LQVNNxLH0oeFk/78hvdw==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr2790422wrx.347.1624345577744;
        Tue, 22 Jun 2021 00:06:17 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id 11sm1321777wmf.20.2021.06.22.00.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 00:06:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] serial: samsung: use dma_ops of DMA if attached
To:     M Tamseel Shams <m.shams@samsung.com>, kgene@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com
References: <CGME20210621044517epcas5p187affa518a18a3d019deb0c189cd8396@epcas5p1.samsung.com>
 <20210621044916.41564-1-m.shams@samsung.com>
 <8935a448-04b7-91ce-203a-9f0d7e377052@canonical.com>
 <004f01d766a0$567b9860$0372c920$@samsung.com>
Message-ID: <4b2576c1-c986-a4d8-d6cf-661ca056ecee@canonical.com>
Date:   Tue, 22 Jun 2021 09:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <004f01d766a0$567b9860$0372c920$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 21/06/2021 15:21, M Tamseel Shams wrote:
> Hi,
> 
>>
>> Hi,
>>
>> Thanks for the patch.
>>
>> On 21/06/2021 06:49, Tamseel Shams wrote:
>>> When DMA is used for TX and RX by serial driver, it should pass the
>>> DMA device pointer to DMA API instead of UART device pointer.
>>
>> Hmmm, but why DMA device pointer should be used?
>>
>>>
>>> This patch is necessary to fix the SMMU page faults which is observed
>>> when a DMA(with SMMU enabled) is attached to UART for transfer.
>>>
>>> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
>>> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
>>> ---
>>>  drivers/tty/serial/samsung_tty.c | 60
>>> +++++++++++++++++++++++++-------
>>>  1 file changed, 48 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/samsung_tty.c
>>> b/drivers/tty/serial/samsung_tty.c
>>> index b923683e6a25..5bdc7dd2a5e2 100644
>>> --- a/drivers/tty/serial/samsung_tty.c
>>> +++ b/drivers/tty/serial/samsung_tty.c
>>> @@ -284,8 +284,13 @@ static void s3c24xx_serial_stop_tx(struct uart_port
>> *port)
>>>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>>>  	struct circ_buf *xmit = &port->state->xmit;
>>>  	struct dma_tx_state state;
>>> +	struct device *dma_map_ops_dev = ourport->port.dev;
>>>  	int count;
>>>
>>> +	/* Pick dma_ops of DMA device if DMA device is attached */
>>
>> You mention here and further comments "dma_ops". I don't see you changing
>> the DMA ops, but the device. It's quite confusing. I think you meant a DMA
>> device shall be passed to DMA API?
>>
> Yes, DMA device should be used for DMA API because only the DMA device is aware of
> how the device connects to the memory. There might be an extra level of address translation
> due to a SMMU attached to the DMA device. When serial device pointer device is used
> for DMA API, the DMA API will have no clue of the SMMU attached to the DMA device.

Thanks, this should be in commit msg.

> 
>> Second question: you write that DMA devices should be used if DMA is attached
>> and in the code you follow such pattern a lot:
>>
>>> +	if (dma && dma->tx_chan)
>>> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>>> +
>>
>> Are you trying to say that if DMA is not attached, UART device should be used? If
>> DMA is not attached, how are the DMA operations used then?
>>
> If DMA is not attached, this part of code related to dma_engine or DMA API do not
> get called. There will not be any DMA operations at all.

Now I get it. The "When" in your description followed by multiple
comments "if DMA device is attached" confused me that you expect to use
UART device for DMA operations if DMA is not attached...

> 
>>>  	if (!ourport->tx_enabled)
>>>  		return;
>>>
>>> @@ -298,7 +303,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port
>> *port)
>>>  		dmaengine_pause(dma->tx_chan);
>>>  		dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>>>  		dmaengine_terminate_all(dma->tx_chan);
>>> -		dma_sync_single_for_cpu(ourport->port.dev,
>>> +		dma_sync_single_for_cpu(dma_map_ops_dev,
>>>  			dma->tx_transfer_addr, dma->tx_size,
>> DMA_TO_DEVICE);
>>>  		async_tx_ack(dma->tx_desc);
>>>  		count = dma->tx_bytes_requested - state.residue; @@ -324,15
>> +329,19
>>> @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>>>  	struct circ_buf *xmit = &port->state->xmit;
>>>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>>>  	struct dma_tx_state state;
>>> +	struct device *dma_map_ops_dev = ourport->port.dev;
>>>  	unsigned long flags;
>>>  	int count;
>>>
>>> +	/* Pick dma_ops of DMA device if DMA device is attached */
>>> +	if (dma && dma->tx_chan)
>>> +		dma_map_ops_dev = dma->tx_chan->device->dev;

Example is this one - you use here "if" suggesting there is "else". So
what is the else condition? There is none...

>>>
>>>  	dmaengine_tx_status(dma->tx_chan, dma->tx_cookie, &state);
>>>  	count = dma->tx_bytes_requested - state.residue;
>>>  	async_tx_ack(dma->tx_desc);
>>>
>>> -	dma_sync_single_for_cpu(ourport->port.dev, dma->tx_transfer_addr,
>>> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->tx_transfer_addr,
>>>  				dma->tx_size, DMA_TO_DEVICE);
>>>
>>>  	spin_lock_irqsave(&port->lock, flags); @@ -408,7 +417,11 @@ static
>>> int s3c24xx_serial_start_tx_dma(struct s3c24xx_uart_port *ourport,
>>>  	struct uart_port *port = &ourport->port;
>>>  	struct circ_buf *xmit = &port->state->xmit;
>>>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>>> +	struct device *dma_map_ops_dev = ourport->port.dev;
>>>
>>> +	/* Pick dma_ops of DMA device if DMA device is attached */
>>> +	if (dma && dma->tx_chan)
>>> +		dma_map_ops_dev = dma->tx_chan->device->dev;
>>>
>>>  	if (ourport->tx_mode != S3C24XX_TX_DMA)
>>>  		enable_tx_dma(ourport);
>>> @@ -416,7 +429,7 @@ static int s3c24xx_serial_start_tx_dma(struct
>> s3c24xx_uart_port *ourport,
>>>  	dma->tx_size = count & ~(dma_get_cache_alignment() - 1);
>>>  	dma->tx_transfer_addr = dma->tx_addr + xmit->tail;
>>>
>>> -	dma_sync_single_for_device(ourport->port.dev, dma-
>>> tx_transfer_addr,
>>> +	dma_sync_single_for_device(dma_map_ops_dev, dma-
>>> tx_transfer_addr,
>>>  				dma->tx_size, DMA_TO_DEVICE);
>>>
>>>  	dma->tx_desc = dmaengine_prep_slave_single(dma->tx_chan,
>>> @@ -483,12 +496,17 @@ static void s3c24xx_uart_copy_rx_to_tty(struct
>> s3c24xx_uart_port *ourport,
>>>  		struct tty_port *tty, int count)
>>>  {
>>>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>>> +	struct device *dma_map_ops_dev = ourport->port.dev;
>>>  	int copied;
>>>
>>> +	/* Pick dma_ops of DMA device if DMA device is attached */
>>> +	if (dma && dma->rx_chan)
>>> +		dma_map_ops_dev = dma->rx_chan->device->dev;
>>> +
>>>  	if (!count)
>>>  		return;
>>>
>>> -	dma_sync_single_for_cpu(ourport->port.dev, dma->rx_addr,
>>> +	dma_sync_single_for_cpu(dma_map_ops_dev, dma->rx_addr,
>>>  				dma->rx_size, DMA_FROM_DEVICE);
>>>
>>>  	ourport->port.icount.rx += count;
>>> @@ -600,8 +618,13 @@ static void s3c24xx_serial_rx_dma_complete(void
>>> *args)  static void s3c64xx_start_rx_dma(struct s3c24xx_uart_port
>>> *ourport)  {
>>>  	struct s3c24xx_uart_dma *dma = ourport->dma;
>>> +	struct device *dma_map_ops_dev = ourport->port.dev;
>>>
>>> -	dma_sync_single_for_device(ourport->port.dev, dma->rx_addr,
>>> +	/* Pick dma_ops of DMA device if DMA device is attached */
>>> +	if (dma && dma->rx_chan)
>>> +		dma_map_ops_dev = dma->rx_chan->device->dev;
>>> +
>>> +	dma_sync_single_for_device(dma_map_ops_dev, dma->rx_addr,
>>>  				dma->rx_size, DMA_FROM_DEVICE);
>>>
>>>  	dma->rx_desc = dmaengine_prep_slave_single(dma->rx_chan,
>>> @@ -983,6 +1006,7 @@ static int s3c24xx_serial_request_dma(struct
>>> s3c24xx_uart_port *p)
>>
>> Offset of hunks looks here significantly different than mainline. The patch should
>> be based and tested mainline tree. Which one did you choose as base?
>>
>> Using my email address not from get_maintainers.pl also suggests that you
>> don't use anything recent as a base.
>>
> I used "master" branch of main linux-next tree as the base.
> I will rebase on "tty-next" branch of TTY tree and post again.
> 
> Thanks & Regards,
> Tamseel Shams
> 


Best regards,
Krzysztof
