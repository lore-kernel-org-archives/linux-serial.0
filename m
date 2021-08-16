Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01926C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 16 Aug 2021 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1918604DC
	for <linux-serial@archiver.kernel.org>; Mon, 16 Aug 2021 10:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhHPKUt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Aug 2021 06:20:49 -0400
Received: from foss.arm.com ([217.140.110.172]:42424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhHPKUm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Aug 2021 06:20:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881666D;
        Mon, 16 Aug 2021 03:20:03 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96D4F3F40C;
        Mon, 16 Aug 2021 03:20:02 -0700 (PDT)
Subject: Re: [PATCH v6] arm pl011 serial: support multi-irq request
To:     Bing Fan <hptsfb@gmail.com>, gregkh@linuxfoundation.org,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1628825490-18937-1-git-send-email-hptsfb@gmail.com>
 <1d691b6b-dbc4-36b0-2e2a-beb95c4c9cb6@arm.com>
 <5b68f69c-f9cd-b0a4-45dd-d6db6d09fd65@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0366a4e9-cc8a-499e-4b8a-bbd6fa088591@arm.com>
Date:   Mon, 16 Aug 2021 11:19:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5b68f69c-f9cd-b0a4-45dd-d6db6d09fd65@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-08-16 08:42, Bing Fan wrote:
> 
> At present, i think a focus of our discussion is whether this patch is 
> necessary.
> 
> As for the other points you mentioned, I think they can be used as code 
> review comments.
> 
> 
> Yes, as you described below, most dts files have only one interrupt, but 
> not all platforms are like this.
> 
> The scene I'm encountering now is the latter: the interrupt lines of the 
> uart is connected to the gic separately
> 
> so the dts should be define like this:
> 
>                 duart1: serial@5E139000 {
>                          compatible = "arm,pl011", "arm,primecell";
>                          reg = <0x00 0x5E139000 0x0 0x1000>;
>                          interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
>                                  <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
>                                  <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
>                                  <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;
>                          clocks = <&sysclk>;
>                          clock-names = "apb_pclk";
>                  };

Apologies for being unclear - the point I was implying is that of course 
you can do that in practice, but if you run that DTS through `make 
dtbs_check` it will fail. The binding needs extending to make it valid 
to specify more than one interrupt, and that's a separate patch and 
discussion in itself (simply increasing "maxitems" for the "interrupts" 
property is not enough to be robust).

Robin.

> The current tty-master code cannot meet this scenario, so I submitted 
> this patch.
> 
> 
> 
> 
> 
> 在 2021/8/13 下午10:37, Robin Murphy 写道:
>> [ +Russell as the listed PL011 maintainer ]
>>
>> On 2021-08-13 04:31, Bing Fan wrote:
>>> From: Bing Fan <tombinfan@tencent.com>
>>>
>>> In order to make pl011 work better, multiple interrupts are
>>> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
>>> at the same time, pl011 to GIC does not merge the interrupt
>>> lines(each serial-interrupt corresponding to different GIC hardware
>>> interrupt), so need to enable and request multiple gic interrupt
>>> numbers in the driver.
>>>
>>> Signed-off-by: Bing Fan <tombinfan@tencent.com>
>>> ---
>>>   drivers/tty/serial/amba-pl011.c | 39 +++++++++++++++++++++++++++++++--
>>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/amba-pl011.c 
>>> b/drivers/tty/serial/amba-pl011.c
>>> index e14f3378b8a0..eaac3431459c 100644
>>> --- a/drivers/tty/serial/amba-pl011.c
>>> +++ b/drivers/tty/serial/amba-pl011.c
>>> @@ -1701,6 +1701,41 @@ static void pl011_write_lcr_h(struct 
>>> uart_amba_port *uap, unsigned int lcr_h)
>>>       }
>>>   }
>>>   +static void pl011_release_multi_irqs(struct uart_amba_port *uap, 
>>> unsigned int max_cnt)
>>> +{
>>> +    struct amba_device *amba_dev = container_of(uap->port.dev, 
>>> struct amba_device, dev);
>>> +    int i;
>>> +
>>> +    for (i = 0; i < max_cnt; i++)
>>> +        if (amba_dev->irq[i])
>>> +            free_irq(amba_dev->irq[i], uap);
>>
>> When you request the IRQs you break at the first zero, so this could 
>> potentially try to free IRQs that you haven't requested, if there 
>> happen to be any nonzero values beyond that. Maybe that can never 
>> happen, but there seems little need for deliberate inconsistency here.
>>
>>> +}
>>> +
>>> +static int pl011_allocate_multi_irqs(struct uart_amba_port *uap)
>>> +{
>>> +    int ret = 0;
>>> +    int i;
>>> +    unsigned int virq;
>>> +    struct amba_device *amba_dev = container_of(uap->port.dev, 
>>> struct amba_device, dev);
>>> +
>>> +    pl011_write(uap->im, uap, REG_IMSC);
>>> +
>>> +    for (i = 0; i < AMBA_NR_IRQS; i++) {
>>
>> It's not clear where these extra IRQs are expected to come from given 
>> that the DT binding explicitly defines only one :/
>>
>>> +        virq = amba_dev->irq[i];
>>> +        if (virq == 0)
>>> +            break;
>>> +
>>> +        ret = request_irq(virq, pl011_int, IRQF_SHARED, 
>>> dev_name(&amba_dev->dev), uap);
>>
>> Note that using dev_name() here technically breaks user ABI - scripts 
>> looking in /proc for an irq named "uart-pl011" will no longer find it.
>>
>> Furthermore, the "dev" cookie passed to request_irq is supposed to be 
>> globally unique, which "uap" isn't once you start registering it 
>> multiple times. If firmware did describe all the individual PL011 IRQ 
>> outputs on a system where they are muxed to the same physical IRQ 
>> anyway, you'd end up registering ambiguous IRQ actions here. Of course 
>> in practice you might still get away with that, but it is technically 
>> wrong.
>>
>> Robin.
>>
>>> +        if (ret) {
>>> +            dev_err(uap->port.dev, "request %u interrupt failed\n", 
>>> virq);
>>> +            pl011_release_multi_irqs(uap, i - 1);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static int pl011_allocate_irq(struct uart_amba_port *uap)
>>>   {
>>>       pl011_write(uap->im, uap, REG_IMSC);
>>> @@ -1753,7 +1788,7 @@ static int pl011_startup(struct uart_port *port)
>>>       if (retval)
>>>           goto clk_dis;
>>>   -    retval = pl011_allocate_irq(uap);
>>> +    retval = pl011_allocate_multi_irqs(uap);
>>>       if (retval)
>>>           goto clk_dis;
>>>   @@ -1864,7 +1899,7 @@ static void pl011_shutdown(struct uart_port 
>>> *port)
>>>         pl011_dma_shutdown(uap);
>>>   -    free_irq(uap->port.irq, uap);
>>> +    pl011_release_multi_irqs(uap, AMBA_NR_IRQS);
>>>         pl011_disable_uart(uap);
>>>
