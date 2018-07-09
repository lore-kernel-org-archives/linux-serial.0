From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add mt6765 support
Date: Mon, 9 Jul 2018 17:43:14 +0100
Message-ID: <d439eb7d-6365-7a0a-2969-1ddecc51defc@arm.com>
References: <1531116302-29921-1-git-send-email-mars.cheng@mediatek.com>
 <1531116302-29921-2-git-send-email-mars.cheng@mediatek.com>
 <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7fb13f45-4e33-6efc-467b-c7256a40cbc9@gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>, Mars Cheng <mars.cheng@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc: CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 09/07/18 11:20, Matthias Brugger wrote:
> 
> 
> On 09/07/18 08:05, Mars Cheng wrote:
>> This adds basic chip support for MT6765 SoC.
>>
>> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++++
>>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  156 +++++++++++++++++++++++++++
>>  3 files changed, 190 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
>> index ac17f60..7506b0d 100644
>> --- a/arch/arm64/boot/dts/mediatek/Makefile
>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6765-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> 
> As you can see, we have a long list of SoCs which are poorly supported.
> I'm not very keen to just add another SoC which supports booting into a ramdisk
> using the serial console. Do you have a roadmap adding mainline support for this
> SoC?

Yes, that's a valid concern.

mt6755 and mt6795 are in a similar state, the latter after three years.
I'm all for supporting new SoCs, but this feels looks a box-ticking
exercise ("hey, look, our SoC is supported in mainline") which doesn't
help anyone.

My Ack still stands, but I'd definitely like to see some more complete
support before this patch goes in.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
