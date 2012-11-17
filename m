From: Huang Shijie <shijie8@gmail.com>
Subject: Re: [PATCH v3 0/3] serial: mxs-auart: add DMA support for auart in mx28
Date: Sat, 17 Nov 2012 11:37:54 +0800
Message-ID: <CAMiH66E0QB9JwHqGyM_jDRU8zzULzqDNJzTJAHXTguAdXMgeWA@mail.gmail.com>
References: <1353053034-10944-1-git-send-email-b32955@freescale.com>
	<50A656DE.6080506@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63160 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2KQDhz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 22:37:55 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so3530884vcb.19
        for <linux-serial@vger.kernel.org>; Fri, 16 Nov 2012 19:37:55 -0800 (PST)
In-Reply-To: <50A656DE.6080506@bluegiga.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Huang Shijie <b32955@freescale.com>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, vinod.koul@intel.com

On Fri, Nov 16, 2012 at 11:08 PM, Lauri Hintsala
<lauri.hintsala@bluegiga.com> wrote:
> Hi Huang,
>
> Thanks for new version. Now I don't get any errors and the CPU doesn't
> freeze any more but:
>
> 1) AUART corrupts data with baudrate over 1Mbits/s
The tranceivers, such as MAX3380E, will limit the speed.
i ever removed it, and tested the AUART in 3M bits/s.

>
> 2) We would need DMA support without flow control.
:)
I really think it's not wise to support the DMA withou flow control.
it will losts the data in some case.
Even use the FREESCALE's bsp code, I also recomand to use the flow control.


>
> By the way, how do you test drivers? Is there any standard tools for uart
> data and throughput testing?
I tested the driver with our own small tool.
If you want to test it too, I can send you the resource next monday.
You can use it to test if you have received the right data.

thanks
Huang Shijie


>
> Lauri
>
>
> On 11/16/2012 10:03 AM, Huang Shijie wrote:
>>
>> This patch set adds the DMA support for auart in mx28.
>> patch 1:
>>         In mx23, the DMA has a bug(see errata:2836). We can not add the
>>         DMA support in mx23, but we can add DMA support to auart in mx28.
>>         So in order to add the DMA support for the auart in mx28, we
>> should add
>>         the platform_device_id to distinguish the distinguish SOCs.
>>
>> patch 2: add the DMA support for mx28
>>         Only we meet the following conditions, we can enable the DMA
>> support
>>         for auart:
>>          (1) We enable the DMA support in the dts file, such as
>>              arch/arm/boot/dts/imx28.dtsi.
>>          (2) We enable the hardware flow control.
>>          (3) We use the mx28, not the mx23. Due to hardware bug(see
>> errata: 2836),
>>              we can not add the DMA support to mx23.
>>
>> patch 3: enable the DMA support in dts for mx28
>>         You can use the /ttyAPP0 to test this patch set.
>>         I tested this patch in mx28-evk board.
>>
>>
>> To Lauri: Please try this patch set. thanks.
>>
>>
>> v2 --> v3:
>>         [1] fix a multi-open issue found by Lauri.
>>
>> v1 --> v2:
>>         [1] use the inline function, not a macro, to distinguish the SOCs.
>>         [2] remove the "inline" for mxs_auart_tx_chars().
>>         [3] use the `pio`, not the `pio[1]` to fill the DMA descriptor.
>>         [4] use bit operation to serialize the DMA TX.
>>         [5] use the RX/TX DMA channel to enable the DMA support, remove
>> the
>>             "fsl,auart-enable-dma".
>>
>> Huang Shijie (3):
>>    serial: mxs-auart: distinguish the different SOCs
>>    serial: mxs-auart: add the DMA support for mx28
>>    ARM: dts: enable dma support for auart0 in mx28
>>
>>   .../bindings/tty/serial/fsl-mxs-auart.txt          |    8 +
>>   arch/arm/boot/dts/imx28.dtsi                       |    1 +
>>   drivers/tty/serial/mxs-auart.c                     |  364
>> +++++++++++++++++++-
>>   3 files changed, 362 insertions(+), 11 deletions(-)
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
