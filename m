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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F941C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 17:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CDF60FED
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 17:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhHLR04 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:26:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHLR0z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 13:26:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75C371FF68;
        Thu, 12 Aug 2021 17:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628789189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPcSNINPXIAlmc4sErzLU2oor99AUyvRmybsJT6/ctw=;
        b=jFS1SgersCWKSjeuMRL86MMLMYDOLbS7kq8V+UojoaAt4ls1aQfiLYxihkbBbOGu85s7fy
        dbGzuMtnIM34pfy/o2slO4gtQc8UApsD/TeYSlrrRxK/PX6IL6GEDTeBIdrWZ/HlFGfaqq
        BdCKiegaF7J8zgDoEs+YbEjXAOBduxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628789189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPcSNINPXIAlmc4sErzLU2oor99AUyvRmybsJT6/ctw=;
        b=wZDwhh8fVyA69YEV0ABzp/q4iMIkF3NVg3/0QFvbbtIADIyMzpO0DegU7G86M7LyBYCqQu
        p84snFnB/jM8ZdAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DAA1013AC3;
        Thu, 12 Aug 2021 17:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id FDdTNMRZFWGnDwAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Aug 2021 17:26:28 +0000
To:     Chester Lin <clin@suse.com>, Rob Herring <robh+dt@kernel.org>,
        s32@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        "Lee, Chun-Yi" <jlee@suse.com>, Marc Zyngier <maz@misterjones.org>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-5-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 4/8] arm64: dts: add NXP S32G2 support
Message-ID: <d09ed0fd-83e7-a6aa-0bd6-f679ffb64eaf@suse.de>
Date:   Thu, 12 Aug 2021 19:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-5-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chester et al.,

On 05.08.21 08:54, Chester Lin wrote:
> Add an initial dtsi file for generic SoC features of NXP S32G2.
> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 98 ++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> new file mode 100644
> index 000000000000..3321819c1a2d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi

Note: This DT is for running on the Cortex-A53 cores, but S32G2 also has
Cortex-M7 cores. For Vybrid SoCs, DTs later got contributed to also run
on its Cortex-M4 core:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/vf610.dtsi
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/vf500.dtsi
vs.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/boot/dts/vf610m4.dtsi

Should we plan for this in our file naming here and in following patches
(e.g., s32g2-a53* vs. s32g2-m7*)? To me, a later concatenation of
s32g274am7* would look awkward, and s32g274a-m7* would sort between -evb
and -rdb2.

> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*

 * NXP S32G2 SoC family
 *
?

@NXP: Are any models other than 274A in the queue that we should
distinguish between s32g2.dtsi and s32g274a.dtsi here already?

> + * Copyright (c) 2021 SUSE LLC
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "fsl,s32g2";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&cluster0_l2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&cluster0_l2>;
> +		};
> +
> +		cpu2: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&cluster1_l2>;
> +		};
> +
> +		cpu3: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +			next-level-cache = <&cluster1_l2>;
> +		};
> +
> +		cluster0_l2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +
> +		cluster1_l2: l2-cache1 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;

interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};

Should we move this into a /firmware node, to group with future OP-TEE?

> +
> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;

Duplicate, already set on root node.

> +		#address-cells = <2>;
> +		#size-cells = <2>;

Why? Does it have any peripherals that go beyond 32-bit space?
For 64-bit Realtek platforms Rob had asked me to use 1, if possible.
I do understand that for /memory nodes we do have high-memory addresses,
so 2 for the root node looks correct.

> +

Please drop this white line.

> +		ranges;

According to Rob, the /soc ranges should exclude any RAM ranges for
safety reasons. Compare:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/realtek/rtd129x.dtsi

If you're lacking the maximum RAM areas to carve out, NXP is in CC to
help out :) and the EVB and RDB2 boards should give you starting numbers
that could be enlarged later if needed.

> +
> +		gic: interrupt-controller@50800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0 0x50800000 0 0x10000>,
> +			      <0 0x50880000 0 0x200000>,
> +			      <0 0x50400000 0 0x2000>,
> +			      <0 0x50410000 0 0x2000>,
> +			      <0 0x50420000 0 0x2000>;

Please order reg after compatible by convention, and sort
interrupt-controller or at least #interrupt-cells (applying to
consumers) last, after the below one applying to this device itself.

> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> +						 IRQ_TYPE_LEVEL_HIGH)>;
> +		};

CC'ing Marc for additional GIC scrutiny, often the sizes are wrong.

> +	};
> +};

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
