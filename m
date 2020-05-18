Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FC9C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309C6207ED
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 16:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgERQ5w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 12:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERQ5w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 12:57:52 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9635EC061A0C;
        Mon, 18 May 2020 09:57:52 -0700 (PDT)
Received: from [192.168.178.106] (pd95ef567.dip0.t-ipconnect.de [217.94.245.103])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 9B3C340A403;
        Mon, 18 May 2020 16:54:56 +0000 (UTC)
Subject: Re: [PATCH 4/4] sc16is7xx: Use threaded IRQ
To:     Maarten Brock <m.brock@vanmierlo.com>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        pascal.huerst@gmail.com, linux-serial-owner@vger.kernel.org
References: <20200508143757.2609740-1-daniel@zonque.org>
 <20200508143757.2609740-5-daniel@zonque.org>
 <61fdcf12976c924fd86c5203aba673a7@vanmierlo.com>
 <584de876-e675-0172-97ed-0c9534eb9526@zonque.org>
 <dfafc770e7e308cb6a2db5a1003cd759@vanmierlo.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <22116d56-9240-9bfe-1b6f-a94d57a085cf@zonque.org>
Date:   Mon, 18 May 2020 18:57:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dfafc770e7e308cb6a2db5a1003cd759@vanmierlo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Maarten,

On 5/18/20 1:14 PM, Maarten Brock wrote:
> On 2020-05-17 22:44, Daniel Mack wrote:

>>> Therefor I suggest to change IRQF_TRIGGER_FALLING to
>>> IRQF_TRIGGER_LOW. This
>>> way the thread will be retriggered after IRQ_HANDLED is returned.
>>
>> This doesn't work in my setup unfortunately, as the interrupt controller
>> is incapable of handling level IRQs.
> 
> That sounds like a lousy interrupt controller to me. 

While that is true, there are many such controllers around.

> Summerizing:
> - After switching to a threaded IRQ, the trigger could be switched to
> IRQF_TRIGGER_LOW and with that interrupt sharing can be enabled for
> this device with IRQF_SHARED.

Yes, but we don't need that. As discussed, the UART driver can cope with
edge IRQs just fine.

> - Some (your) interrupt controllers do not support IRQF_TRIGGER_LOW.
> For those only IRQF_TRIGGER_FALLING can be used for this device and
> thus IRQF_SHARED cannot be used.

True. Interrupts cannot be shared for this device then. That's a fair
limitation, and it has always been like that.

> - The driver for your interrupt controller should be improved to support
> level IRQs.

It's a controller that sits behind another hardware bus itself, so
polling is expensive. If the controller would need to check for level
IRQs it would need to poll, and then we could as well just poll the UART
directly, that's just as good :)

But again - the UART driver works perfectly fine with edge IRQs as long
as the interrupt is not shared.

> This makes me wonder if it would be better to let the device tree specify
> the interrupt configuration.

There can be flags in the 2nd cell of the node, but their meaning is
specific to the controller. Hence the SPI/I2C layers don't pass that
information up.

What many drivers do is try with one setting, and if that fails because
the interrupt controller returns an error, they fall back to something
else. We could do the same here of course, but it'd be another patch on
top, as it's unrelated to the concrete change the patch we're commenting
on is bringing in.

So what I can add is logic that first tries with IRQF_LOW|IRQF_SHARED,
and if that fails, we fall back to IRQF_FALLING and retry. WDYT?



Thanks,
Daniel
