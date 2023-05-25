Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03481C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 03:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjEYDoX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 May 2023 23:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEYDoW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 May 2023 23:44:22 -0400
Received: from anchovy2.45ru.net.au (anchovy2.45ru.net.au [203.30.46.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9A2E7
        for <linux-serial@vger.kernel.org>; Wed, 24 May 2023 20:44:18 -0700 (PDT)
Received: (qmail 11619 invoked by uid 5089); 25 May 2023 03:44:14 -0000
Received: by simscan 1.2.0 ppid: 11163, pid: 11166, t: 1.0017s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 25 May 2023 03:44:10 -0000
Message-ID: <94bb9b7a-d69e-d578-3787-5a6146ec99dc@electromag.com.au>
Date:   Thu, 25 May 2023 11:44:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Possible regression in 8250_dw driver
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au>
 <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com>
 <261812cb-6de4-ec2b-18b0-90b5d9cc83e4@electromag.com.au>
 <8f778157-43fa-f364-d7e0-a022401b28@linux.intel.com>
From:   Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <8f778157-43fa-f364-d7e0-a022401b28@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org





Richard Tresidder








**






On 24/05/2023 6:06 pm, Ilpo Järvinen wrote:

> On Wed, 24 May 2023, Richard Tresidder wrote:
>> On 23/05/2023 7:13 pm, Ilpo Järvinen wrote:
>>> On Tue, 23 May 2023, Richard Tresidder wrote:
>>>
>>>> background:
>>>> I'm attempting to use 6.3.3 as a new base for one of our systems.
>>>> Previously it was using 5.1.7 as a base.
>>>> The uart in question is one of the two in the Cyclone V SOC HPS.
>>>> And to muddy the waters the linux console TTYS0 is the other Uart from the
>>>> same HPS core
>>>> Yet the console appears to be working ok.
>>> Maybe some of the DMA related changes triggering some unexpected behavior.
>>>
>>> Console doesn't use DMA so that could explain the difference.
>>>
>>>> Note all other libs and apps are at the same revision and build, it is
>>>> only
>>>> the kernel that is different.
>>>> Both versions of the kernel are also built using the same bitbake bsdk..
>>>>
>>>>
>>>> As you can see it looks like the frame thats received on the 6.3.3 kernel
>>>> is
>>>> mangled?
>>>> This same message is just being requested over and over again from the GPS
>>>> unit.
>>>>
>>>> The offset where the tears occur looks to be pretty similar between each
>>>> poll
>>>> request.
>>>> Usually the 1 at the end of the (75331 is where the first tear occurs.
>>>>
>>>> I'd appreciate some quidance in how to track this down as there appears to
>>>> have been a reasonable amount of work done to this driver and the serial
>>>> core
>>>> between these two versions.
>>> A few ideas:
>>> - try without dma_rx_complete() calling p->dma->rx_dma(p)
>>> - revert 90b8596ac46043e4a782d9111f5b285251b13756
>>> - Try the revert in
>>> https://lore.kernel.org/all/316ab583-d217-a332-d161-8225b0cee227@redhat.com/2-0001-Revert-serial-8250-use-THRE-__stop_tx-also-with-DMA.patch
>>>     (for e8ffbb71f783 and f8d6e9d3ca5c)
>>>
>>> But finding the culprit with git bisect would be the most helpful here.
>>>
>> Bisect wasn't an easy option as I'd applied a pile of patches after the
>> interesting commits for our system to run.
>> I'm not a git master :)
>>
>> So I just started reverting the patches that had been applied to the 8250
>> folder.
>> Worked backwards from head.
>>
>> After reverting 57e9af7831dcf211c5c689c2a6f209f4abdf0bce
>> serial: 8250_dma: Fix DMA Rx rearm race
>>
>> Things started to work again.
>>
>> I reset everything and then just reverted that individual patch and things
>> work.
>> So that looks like the culprit..
> Okay, that also worked great, thanks a lot. It gives something concrete to
> work with to find a fix.
>
> The commit itself looks very much correct, however, my guess is that when
> serial8250_rx_dma_flush() does dmaengine_pause() dma_status somehow
> does not become DMA_PAUSED which leads to not properly flushing DMA Rx
> transaction. Can you try the following debug patch (if my guess is
> correct, besides triggering the WARN_ON_ONCE, it also works around the
> issue):
>
> [PATCH] DEBUG: 8250_dma: Detect DMA_PAUSED vs DMA_IN_PROGRESS inconsistency
>
> Detect DMA state not returning DMA_PAUSED after dmaengine_pause() was
> issued.
>
> Not intended for upstream.

Thanks Ilpo
    I can confirm that the patch below works. Got the WARN_ON_ONCE dump so it's taking that path.
I think the problem here is that the pl330 DMA controller thats in these SOC's doesn't "really" support pause according to the driver.
It doesn't look like it can ever set "DMA_PAUSED"
I'm not sure of the flow through of that though.
There is some commenting in the pl330 driver about the pause routine.

Cheers
    Richard Tresidder

> ---
>   drivers/tty/serial/8250/8250_dma.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 7fa66501792d..3dedacd9f104 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -38,7 +38,7 @@ static void __dma_tx_complete(void *param)
>   	spin_unlock_irqrestore(&p->port.lock, flags);
>   }
>   
> -static void __dma_rx_complete(struct uart_8250_port *p)
> +static void __dma_rx_complete(struct uart_8250_port *p, bool paused)
>   {
>   	struct uart_8250_dma	*dma = p->dma;
>   	struct tty_port		*tty_port = &p->port.state->port;
> @@ -52,8 +52,12 @@ static void __dma_rx_complete(struct uart_8250_port *p)
>   	 * anything in such case.
>   	 */
>   	dma_status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> -	if (dma_status == DMA_IN_PROGRESS)
> -		return;
> +	if (dma_status == DMA_IN_PROGRESS) {
> +		if (!paused)
> +			return;
> +
> +		WARN_ON_ONCE(paused);
> +	}
>   
>   	count = dma->rx_size - state.residue;
>   
> @@ -72,7 +76,7 @@ static void dma_rx_complete(void *param)
>   
>   	spin_lock_irqsave(&p->port.lock, flags);
>   	if (dma->rx_running)
> -		__dma_rx_complete(p);
> +		__dma_rx_complete(p, false);
>   
>   	/*
>   	 * Cannot be combined with the previous check because __dma_rx_complete()
> @@ -172,7 +176,7 @@ void serial8250_rx_dma_flush(struct uart_8250_port *p)
>   
>   	if (dma->rx_running) {
>   		dmaengine_pause(dma->rxchan);
> -		__dma_rx_complete(p);
> +		__dma_rx_complete(p, true);
>   		dmaengine_terminate_async(dma->rxchan);
>   	}
>   }
>
