Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC75C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D1B20709
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 16:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgESQdC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 12:33:02 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:58885 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726203AbgESQdB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 12:33:01 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Tue, 19 May 2020 18:32:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 May 2020 18:32:32 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, jslaby@suse.com,
        pascal.huerst@gmail.com, linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 4/4] sc16is7xx: Use threaded IRQ
In-Reply-To: <22116d56-9240-9bfe-1b6f-a94d57a085cf@zonque.org>
References: <20200508143757.2609740-1-daniel@zonque.org>
 <20200508143757.2609740-5-daniel@zonque.org>
 <61fdcf12976c924fd86c5203aba673a7@vanmierlo.com>
 <584de876-e675-0172-97ed-0c9534eb9526@zonque.org>
 <dfafc770e7e308cb6a2db5a1003cd759@vanmierlo.com>
 <22116d56-9240-9bfe-1b6f-a94d57a085cf@zonque.org>
Message-ID: <b5d56abc8109fb3a7ef057c89a649f06@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-05-18 18:57, Daniel Mack wrote:
> Hi Maarten,
> 
> On 5/18/20 1:14 PM, Maarten Brock wrote:
>> On 2020-05-17 22:44, Daniel Mack wrote:
> 
>> Summerizing:
>> - After switching to a threaded IRQ, the trigger could be switched to
>> IRQF_TRIGGER_LOW and with that interrupt sharing can be enabled for
>> this device with IRQF_SHARED.
> 
> Yes, but we don't need that. As discussed, the UART driver can cope 
> with
> edge IRQs just fine.
> 
>> - Some (your) interrupt controllers do not support IRQF_TRIGGER_LOW.
>> For those only IRQF_TRIGGER_FALLING can be used for this device and
>> thus IRQF_SHARED cannot be used.
> 
> True. Interrupts cannot be shared for this device then. That's a fair
> limitation, and it has always been like that.

It has always been like that for this driver. But that should be no
reason why the driver might not be improved. I wonder how the 8250
handles this. PC's have always shared interrupts for COM1/2/3/4 AFAIK.

>> - The driver for your interrupt controller should be improved to 
>> support
>> level IRQs.
> 
> It's a controller that sits behind another hardware bus itself, so
> polling is expensive. If the controller would need to check for level
> IRQs it would need to poll, and then we could as well just poll the 
> UART
> directly, that's just as good :)

That depends on the IRQ coming out of the interrupt controller. If that 
is
a level interrupt itself, then it is easy to see if all interrupts are
handled. Further polling zooms in on the devices that require attention.

> But again - the UART driver works perfectly fine with edge IRQs as long
> as the interrupt is not shared.

If you would require multiple sc16is7xx devices on I2C would you like to
connect multiple interrupt lines? Or just SCL,SDA and *one* IRQ?

OTOH for SPI you would require multiple CS already.

>> This makes me wonder if it would be better to let the device tree 
>> specify
>> the interrupt configuration.
> 
> There can be flags in the 2nd cell of the node, but their meaning is
> specific to the controller. Hence the SPI/I2C layers don't pass that
> information up.
> 
> What many drivers do is try with one setting, and if that fails because
> the interrupt controller returns an error, they fall back to something
> else. We could do the same here of course, but it'd be another patch on
> top, as it's unrelated to the concrete change the patch we're 
> commenting
> on is bringing in.
> 
> So what I can add is logic that first tries with IRQF_LOW|IRQF_SHARED,
> and if that fails, we fall back to IRQF_FALLING and retry. WDYT?

That sounds like a decent plan.

> 
> Thanks,
> Daniel

Kind regards,
Maarten

