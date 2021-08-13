Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ADC4320A
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 07:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15FB610F7
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 07:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbhHMHG0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 03:06:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37878 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbhHMHGZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 03:06:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF0E72228C;
        Fri, 13 Aug 2021 07:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628838357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1xf4mvOytSOlhI5qAhiPOrK+892nGaRcYHWxmA5sek=;
        b=lxvOeJ0pcXsKJ6oArQyRXep7LFUb0J0usX6CLNWRjCRpzJFnWB4DKbeJONWrfeHNOCTpWV
        PNh2MGcoXwFYWkf8UCZthvRO2gsZ6jpUWaJYZ//fFTHwKiFvuJqIq0GfrsUnWz15FuMSYo
        rSsQqY+hb5Unjg2ZZsIsCTgapEtI3/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628838357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1xf4mvOytSOlhI5qAhiPOrK+892nGaRcYHWxmA5sek=;
        b=d3dI9635JDqSeLxrCpTeLWTjwqq21xAeQrmfcOnTi4z/aTllbfDgDFmC+WUOwx6mGgUN4q
        usG9yp+6mj/EjpDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 26DF8139C2;
        Fri, 13 Aug 2021 07:05:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id j+BcCNUZFmFzKQAAGKfGzw
        (envelope-from <afaerber@suse.de>); Fri, 13 Aug 2021 07:05:57 +0000
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>, s32@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Marc Zyngier <maz@kernel.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-5-clin@suse.com>
 <d09ed0fd-83e7-a6aa-0bd6-f679ffb64eaf@suse.de> <YRXmxD5u7drotWxP@linux-8mug>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 4/8] arm64: dts: add NXP S32G2 support
Message-ID: <78dc940b-4893-6355-8ccc-adb99a846081@suse.de>
Date:   Fri, 13 Aug 2021 09:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRXmxD5u7drotWxP@linux-8mug>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chester,

On 13.08.21 05:28, Chester Lin wrote:
> On Thu, Aug 12, 2021 at 07:26:28PM +0200, Andreas Färber wrote:
>> On 05.08.21 08:54, Chester Lin wrote:
>>> Add an initial dtsi file for generic SoC features of NXP S32G2.
>>>
>>> Signed-off-by: Chester Lin <clin@suse.com>
>>> ---
>>>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 98 ++++++++++++++++++++++++
>>>  1 file changed, 98 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>>> new file mode 100644
>>> index 000000000000..3321819c1a2d
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>>
>> Note: This DT is for running on the Cortex-A53 cores, but S32G2 also has
>> Cortex-M7 cores. For Vybrid SoCs, DTs later got contributed to also run
>> on its Cortex-M4 core:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/vf610.dtsi
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/vf500.dtsi
>> vs.
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/vf610m4.dtsi
>>
>> Should we plan for this in our file naming here and in following patches
>> (e.g., s32g2-a53* vs. s32g2-m7*)? To me, a later concatenation of
>> s32g274am7* would look awkward, and s32g274a-m7* would sort between -evb
>> and -rdb2.
>>
>>> @@ -0,0 +1,98 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>>> +/*
>>
>>  * NXP S32G2 SoC family
>>  *
>> ?
> 
> Will add it.
> 
>>
>> @NXP: Are any models other than 274A in the queue that we should
>> distinguish between s32g2.dtsi and s32g274a.dtsi here already?
>>
>>> + * Copyright (c) 2021 SUSE LLC
>>> + */
>>> +
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +/ {
>>> +	compatible = "fsl,s32g2";
>>> +	interrupt-parent = <&gic>;
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
[...]
>>> +	pmu {
>>> +		compatible = "arm,cortex-a53-pmu";
>>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>>
>> interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> 
> Actually I traced the pmu_parse_irqs() and found that this SoC never falls into
> the pmu_has_irq_affinity() check because it's a percpu IRQ so the flow ends at
> pmu_parse_percpu_irq(). But it looks good to me to have an interrupt-affinity
> to indicate that each core has an associated PPI for PMU events as the binding
> file has suggested.

My comment was based on the DT binding requesting it also for PPI and
previous review requests for me to add it elsewhere, so it's quite
possible that your code analysis is correct.

FWIW also the cache nodes were not evaluated last time I checked,
although the specs do show those nodes and properties.

https://github.com/devicetree-org/devicetree-specification/blob/v0.3/source/devicenodes.rst

>>> +	};
[...]
>>> +
>>> +	soc {
>>> +		compatible = "simple-bus";
[...]
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>
>> Why? Does it have any peripherals that go beyond 32-bit space?
>> For 64-bit Realtek platforms Rob had asked me to use 1, if possible.
>> I do understand that for /memory nodes we do have high-memory addresses,
>> so 2 for the root node looks correct.
> 
> Actually it's a limitation due to [PATCH 7/8] "arm64: dts: s32g2: add memory
> nodes for evb and rdb2", which adds memory nodes to indicate maximum system
> RAM size combined by two separated memory banks, and the second bank starts
> from the offset 0x880000000 so that's why we need 64-bit address space here.
> Please feel free to let me know if any suggestion.

The /memory nodes are on the root node and thus only use #address-cells
and #size-cells from /, not from /soc here. Thus the only criterium is
whether something within /soc needs it.
PCI controllers may have 3 address cells, SPI/I2C controllers 1, so you
can have multiple sizes within one DT, you just need suitable ranges
wherever mappings to the parent address space are needed.
(I thought you had that distinction in an earlier draft I reviewed.)

Similarly, /reserved-memory would be outside the /soc node and use the
root node's #(address|size)-cells.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

Note: I'm assuming that if someone were to add a DT for the Cortex-M7s,
the address space mapping of any shared peripherals will likely differ,
as would the interrupts obviously, so I assume no direct .dtsi sharing
of /soc sub-nodes could sensibly be applied here.

@NXP: Please correct me if I'm wrong in either M7 not having access to
DDR RAM or large enough SRAM for Linux or another DT-consuming OS (and
this line of thinking not being applicable then) or you having use cases
to factor out some of the /soc sub-nodes for sharing between the two
(which would then give another reason for #address-/size-cells = <1> for
32-bit Cortex-M7).

[...]
>>> +		ranges;
>>
>> According to Rob, the /soc ranges should exclude any RAM ranges for
>> safety reasons. Compare:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/realtek/rtd129x.dtsi
>>
>> If you're lacking the maximum RAM areas to carve out, NXP is in CC to
>> help out :) and the EVB and RDB2 boards should give you starting numbers
>> that could be enlarged later if needed.
> 
> I added memory nodes in [PATCH 7/8] "arm64: dts: s32g2: add memory nodes for
> evb and rdb2" to describe maximum RAM areas, which are based on the information
> we found in NXP BSP and boards.

Yes, as discussed in 7/8, you should be using here:

		ranges = <0x0 0 0x0 0x80000000>; /* excluding 4 GiB RAM */

https://github.com/devicetree-org/devicetree-specification/blob/v0.3/source/devicetree-basics.rst

> @NXP: Please feel free to correct me if anything wrong, thanks.
> 
>>
>>> +
>>> +		gic: interrupt-controller@50800000 {
>>> +			compatible = "arm,gic-v3";
>>> +			#interrupt-cells = <3>;
>>> +			interrupt-controller;
>>> +			reg = <0 0x50800000 0 0x10000>,
>>> +			      <0 0x50880000 0 0x200000>,
>>> +			      <0 0x50400000 0 0x2000>,
>>> +			      <0 0x50410000 0 0x2000>,
>>> +			      <0 0x50420000 0 0x2000>;
>>
>> Please order reg after compatible by convention, and sort
>> interrupt-controller or at least #interrupt-cells (applying to
>> consumers) last, after the below one applying to this device itself.
>>
> 
> Will do.
> 
>>> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
>>> +						 IRQ_TYPE_LEVEL_HIGH)>;
>>> +		};
>>
>> CC'ing Marc for additional GIC scrutiny, often the sizes are wrong.
>>
> 
> IIRC, gic-v3 shouldn't have this kind of interrupt specifier. It's my fault and
> will fix it. Feel free to let me know if any suggestions.

You probably mean the GIC_CPU_MASK_SIMPLE()?

			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml

The interrupts property will be used by KVM (or possibly Xen) for vGIC.
Please ensure that the Kconfig you use for testing has KVM enabled.

>>> +	};
>>> +};

Cheers,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
