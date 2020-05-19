Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C171C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 17:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E390206C3
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 17:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgESRh6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 13:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgESRh5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 13:37:57 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C37F6C08C5C0;
        Tue, 19 May 2020 10:37:57 -0700 (PDT)
Received: from [192.168.178.106] (pd95ef292.dip0.t-ipconnect.de [217.94.242.146])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1897B40A3F8;
        Tue, 19 May 2020 17:35:00 +0000 (UTC)
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
 <22116d56-9240-9bfe-1b6f-a94d57a085cf@zonque.org>
 <b5d56abc8109fb3a7ef057c89a649f06@vanmierlo.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <c03101a9-ea8b-fdff-3f29-fd7c4f400019@zonque.org>
Date:   Tue, 19 May 2020 19:37:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b5d56abc8109fb3a7ef057c89a649f06@vanmierlo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/19/20 6:32 PM, Maarten Brock wrote:
> On 2020-05-18 18:57, Daniel Mack wrote:

>> It's a controller that sits behind another hardware bus itself, so
>> polling is expensive. If the controller would need to check for level
>> IRQs it would need to poll, and then we could as well just poll the UART
>> directly, that's just as good :)
> 
> That depends on the IRQ coming out of the interrupt controller. If that is
> a level interrupt itself, then it is easy to see if all interrupts are
> handled. Further polling zooms in on the devices that require attention.

Yeah, I'm familiar with the concept, but it's not like that here,
unfortunately.

>> But again - the UART driver works perfectly fine with edge IRQs as long
>> as the interrupt is not shared.
> 
> If you would require multiple sc16is7xx devices on I2C would you like to
> connect multiple interrupt lines? Or just SCL,SDA and *one* IRQ?
> 
> OTOH for SPI you would require multiple CS already.

Right. Nevertheless, we can allow sharing the IRQ line for level-trigger
capable IRQ controllers, you're right.

>> What many drivers do is try with one setting, and if that fails because
>> the interrupt controller returns an error, they fall back to something
>> else. We could do the same here of course, but it'd be another patch on
>> top, as it's unrelated to the concrete change the patch we're commenting
>> on is bringing in.
>>
>> So what I can add is logic that first tries with IRQF_LOW|IRQF_SHARED,
>> and if that fails, we fall back to IRQF_FALLING and retry. WDYT?
> 
> That sounds like a decent plan.

Okay, I'll add a patch to the series then and resend.


Thanks for your feedback!
Daniel
