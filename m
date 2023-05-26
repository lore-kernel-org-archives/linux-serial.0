Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2872C7EE23
	for <linux-serial@archiver.kernel.org>; Fri, 26 May 2023 07:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbjEZHHs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 May 2023 03:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbjEZHHr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 May 2023 03:07:47 -0400
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D971B4
        for <linux-serial@vger.kernel.org>; Fri, 26 May 2023 00:07:39 -0700 (PDT)
Received: (qmail 7796 invoked by uid 5089); 26 May 2023 07:07:37 -0000
Received: by simscan 1.2.0 ppid: 7679, pid: 7680, t: 0.7067s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 26 May 2023 07:07:36 -0000
Message-ID: <2d86b525-b9e3-6e8c-3b1a-922fff68b83d@electromag.com.au>
Date:   Fri, 26 May 2023 15:07:35 +0800
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
 <94bb9b7a-d69e-d578-3787-5a6146ec99dc@electromag.com.au>
 <559021f9-2831-5840-aee8-23918602f3f@linux.intel.com>
 <def355b6-5573-90ff-a6d0-5174673f1a37@electromag.com.au>
 <9aec3419-f971-6d5-ff8b-dd8566742d3a@linux.intel.com>
From:   Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <9aec3419-f971-6d5-ff8b-dd8566742d3a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25/05/2023 5:38 pm, Ilpo Järvinen wrote:

> On Thu, 25 May 2023, Richard Tresidder wrote:
>> On 25/05/2023 4:43 pm, Ilpo Järvinen wrote:
>>> On Thu, 25 May 2023, Richard Tresidder wrote:
>>>> On 24/05/2023 6:06 pm, Ilpo Järvinen wrote:
>>>>> On Wed, 24 May 2023, Richard Tresidder wrote:
>>>>>> So I just started reverting the patches that had been applied to the
>>>>>> 8250
>>>>>> folder.
>>>>>> Worked backwards from head.
>>>>>>
>>>>>> After reverting 57e9af7831dcf211c5c689c2a6f209f4abdf0bce
>>>>>> serial: 8250_dma: Fix DMA Rx rearm race
>>>>>>
>>>>>> Things started to work again.
>>>>>>
>>>>>> I reset everything and then just reverted that individual patch and
>>>>>> things
>>>>>> work.
>>>>>> So that looks like the culprit..
>>>>> Okay, that also worked great, thanks a lot. It gives something concrete
>>>>> to
>>>>> work with to find a fix.
>>>>>
>>>>> The commit itself looks very much correct, however, my guess is that
>>>>> when
>>>>> serial8250_rx_dma_flush() does dmaengine_pause() dma_status somehow
>>>>> does not become DMA_PAUSED which leads to not properly flushing DMA Rx
>>>>> transaction. Can you try the following debug patch (if my guess is
>>>>> correct, besides triggering the WARN_ON_ONCE, it also works around the
>>>>> issue):
>>>>>
>>>>> [PATCH] DEBUG: 8250_dma: Detect DMA_PAUSED vs DMA_IN_PROGRESS
>>>>> inconsistency
>>>>>
>>>>> Detect DMA state not returning DMA_PAUSED after dmaengine_pause() was
>>>>> issued.
>>>>>
>>>>> Not intended for upstream.
>>>> Thanks Ilpo
>>>>      I can confirm that the patch below works. Got the WARN_ON_ONCE dump so
>>>> it's
>>>> taking that path.
>>>> I think the problem here is that the pl330 DMA controller thats in these
>>>> SOC's
>>>> doesn't "really" support pause according to the driver.
>>> For this flush usecase, it is enough to support pause + read residue +
>>> terminate which is supported according to the function comment for
>>> pl330_pause().
>> Yep agree given the 8250 serial code immediately terminates the dma after the
>> pause during the flush anyway..
>>
>>>> It doesn't look like it can ever set "DMA_PAUSED"
>>> Why not? It pauses the transfer and is even able to allow reading the
>>> transferred byte count.
>>>
>>> What it is claimed to not be able to do is resume. Note that w/o resume
>>> serial8250_tx_dma() XON/XOFF processing will not work but that's
>>> unrelated to this issue (I'll probably need to do another patch to fix
>>> that on 8250 DMA side).
>> Yep I just meant it doesn't look capable of reporting DMA_PAUSED
>> Which your patch below probably fixes.
>> and it kind of does a stop without a resume capability so must be terminated
>> after this.
>> Though I'm not sure of the implications of reporting paused without resume
>> capability.
>> Kind of an odd one..
> dma_slave_caps has a bool for both pause and resume support (I only found
> out about the second flag for resume today) so not unheard of it seems.

I've just tested the pl330 patch and it looks good.
No longer get the WARN_ON_ONCE triggered in the 8250_dma driver so it looks like
Paused is correctly being set now and we're avoiding that path.
Wonder how many others dma drivers are afflicted in the same manner?
A quick grep seems to infer a lot more drivers set the pause function then have
something in them setting the status to DMA_PAUSED so probably good to keep the
8250 fix in also for the time being.

Cheers
    Richard Tresidder

