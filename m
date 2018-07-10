From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
Date: Tue, 10 Jul 2018 12:52:32 +0200
Message-ID: <7a3becb3-510b-5763-5b66-5e14ebf7c974@gmail.com>
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
 <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
 <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
 <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
 <1531177443.7777.18.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531177443.7777.18.camel@mtkswgap22>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mars Cheng <mars.cheng@mediatek.com>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



On 10/07/18 01:04, Mars Cheng wrote:
> Hi Matthias/Marc
> 
> On Mon, 2018-07-09 at 17:43 +0100, Marc Zyngier wrote:
>> On 09/07/18 11:20, Matthias Brugger wrote:
>>>
>>>
>>> On 09/07/18 08:05, Mars Cheng wrote:
>>>> This adds basic chip support for MT6765 SoC.
>>>>
>>>> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
>>>> ---
>>>>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>>>>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>>>>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  156 +++++++++++++++++++++++++++
>>>>  3 files changed, 190 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>>>> index ac17f60..7506b0d 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>>>> @@ -1,6 +1,7 @@
>>>>  # SPDX-License-Identifier: GPL-2.0
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>>>
>>> As you can see, we have a long list of SoCs which are poorly supported.
>>> I'm not very keen to just add another SoC which supports booting into a ramdisk
>>> using the serial console. Do you have a roadmap adding mainline support for this
>>> SoC?
>>
>> Yes, that's a valid concern.
>>
>> mt6755 and mt6795 are in a similar state, the latter after three years.
>> I'm all for supporting new SoCs, but this feels looks a box-ticking
>> exercise ("hey, look, our SoC is supported in mainline") which doesn't
>> help anyone.
>>
>> My Ack still stands, but I'd definitely like to see some more complete
>> support before this patch goes in.
>>
>> Thanks,
>>
>> 	M.
> 
> Yes, we do arrange more resources to do upstream task for mt6765,
> clk/pinctrl drivers are almost ready to submit. systimer is under
> reviewing (v9).
> http://lists.infradead.org/pipermail/linux-mediatek/2018-July/013989.html
> 
> other drivers including
> pmic/pwrap/i2c/rtc/kpd/spi/wdt/cqdma/auxadc/pwm/cmdq/disp. We have
> dedicated owners to handle them and will cowork tightly with members to
> make sure things happen in the following weeks.
> 

Ok, so let's wait until pinctrl driver is submitted. I'd prefer if you could add
the clk driver to this series. This way we can get rid of the dummy clocks in
the device tree.

> For previous chips, we did have no enough support after shell. It is due
> to fast pace of smartphone SoC and other resource issues. We also know
> that is no excuse so that we already confirmed owners and their
> schedules for mt6765.
> 
> If there is any suggestion, please let us know.
> 

I know that smartphone SoC is a fast paced business. Never the less I'm
convinced that the basic building blocks won't change much from one version to
another. And that mainline support for the previous version of your SoC will
help you to get your new drivers faster upstream.

For me the best example is the mt7622 which got to a reasonable upstream support
quite fast, thanks to a good foundation of mt7623 in mainline. I'd love to see
that happen on the smartphone SoCs as well.

Not to mention that upstream support will help you internally when you have to
rebase your BSP code-base to a new kernel version.

That said I think it is good news that you have already defined owner for the
different devices and hope to see submissions for them in the near future :)
As a suggestion I would say that upstream submission takes time and effort and
it will help your engineers if they can allocate some time to do so. But that's
most probably a management decision and all engineers know that management bases
it's decision on some hard-to-understandable abbreviations like EBITDA etc. ;)

Best regards,
Matthias
