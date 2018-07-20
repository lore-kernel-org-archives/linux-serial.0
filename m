From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 0/4] Add basic support for Mediatek MT8183 SoC
Date: Fri, 20 Jul 2018 12:44:33 +0200
Message-ID: <2ca76468-198b-b764-c974-374e567e0c93@gmail.com>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
 <9ba45353-a6e1-9a6e-f05b-4b1679ae9e52@gmail.com>
 <1532074769.19148.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532074769.19148.2.camel@mtksdaap41>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, mars.cheng@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 20/07/18 10:19, Erin Lo wrote:
> On Mon, 2018-07-16 at 11:28 +0200, Matthias Brugger wrote:
>> Hi Erin,
>>
>> On 17/05/18 08:22, Erin Lo wrote:
>>> MT8183 is a SoC based on 64bit ARMv8 architecture.
>>> It contains 4 CA53 and 4 CA73 cores.
>>> MT8183 share many HW IP with MT65xx series.
>>> This patchset was tested on MT8183 evaluation board, and boot to shell ok.
>>>
>>> This series contains document bindings, device tree including interrupt, uart.
>>>
>>> Change in v3:
>>> 1. Fill out GICC, GICH, GICV regions
>>> 2. Update Copyright to 2018
>>>
>>> Change in v2:
>>> 1. Split dt-bindings into different patches
>>> 2. Correct bindings for supported SoCs (mtk-uart.txt)
>>>
>>> Ben Ho (1):
>>>   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
>>>     Makefile
>>>
>>> Erin Lo (3):
>>>   dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
>>>   dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
>>>   dt-bindings: serial: Add compatible for Mediatek MT8183
>>>
>>
>> I'm a bit reluctant to take this series, as it will only enable the EVB board to
>> boot into a serial console. Are you planning to add support for other devices of
>> this SoC?
>>
>> Apart please take into account that there is an issue with the dts file, as you
>> were told by the kbuild test robot.
>>
>> Regards,
>> Matthias
>>
> 
> Hi, Matthias
> Sorry for missing this letter...since mail proxy server.
> We plan to add support all the devices of MT8183 in serious.
> We have implemented the clock and pinctrl driver for upstream and they
> are in internal review right now.
> 

Nice to hear that :)

> About the dts issue... do you suggest me to send new patch right now or
> wait for clock and pinctrl driver ready then send them together?
> 

I would prefer that you send at least the clock controller together, so that we
don't have any dummy clocks in the basic device tree.

Regards,
Matthias
