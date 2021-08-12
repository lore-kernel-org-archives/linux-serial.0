Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9766C432BE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97835610EA
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 17:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhHLRnI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:43:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51760 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbhHLRnG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 13:43:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 09A7C22258;
        Thu, 12 Aug 2021 17:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628790160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLhKLE29BtM7E1xXGsz1jQ06ZrdHyX0+TGHp1zcBJFE=;
        b=N7GDudJ5HRwPVBPt6HzfMeRLMeQNw3bh/BYw+Ms4aJd41hhi0Fp8eYwDwOfyE/bS5PvTdE
        XIEcg5yy31pBtun5QU39k+PZQ33qvhZptBZl4qkv6T2VMFxlFXdzh9mR+q36mEueImfbUQ
        ZnTNPjWQw6QyUnfmU64ee5yDn/d88Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628790160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLhKLE29BtM7E1xXGsz1jQ06ZrdHyX0+TGHp1zcBJFE=;
        b=y+L6KoYHKDhAUCv/Dp8SELQS5C1ooVRAx7X/KZhCpvcl0aL/PntBbulOkep6DjeVwDVnCJ
        +h8asSmfkdGjrACg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 53BF913AC3;
        Thu, 12 Aug 2021 17:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nMm/Eo9dFWHzEgAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Aug 2021 17:42:39 +0000
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
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-6-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 5/8] arm64: dts: s32g2: add serial/uart support
Message-ID: <93978882-4b47-4c4a-cd43-60cb5bcdf471@suse.de>
Date:   Thu, 12 Aug 2021 19:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-6-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chester et al.,

On 05.08.21 08:54, Chester Lin wrote:
> Add serial/uart support for NXP S32G2.

You might mention here that (following our initial stub) this commit is
now apparently based on the CodeAurora BSP branch foo (and therefore
adding its last-year copyright below and separate from 4/8).

> 

@NXP: If there are downstream Signed-off-bys that you would like to see
included for this portion here, please speak up.

> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi | 31 ++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 3321819c1a2d..0076eacad8a6 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> + * Copyright 2017-2020 NXP

@NXP: Should this be updated to include 2021 from your latest BSP
releases? Do you want it visually aligned by adding the ASCII-art?

>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -11,6 +12,12 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +	};

Note: In the past there had been controversies as to whether to define
aliases globally for a SoC or in a .dts specific to a board's usage.
In this case it does not seem to matter much, as uart0 is being used as
console on the reference boards.

> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -82,6 +89,30 @@ soc {
>  
>  		ranges;
>  
> +		uart0: serial@401c8000 {
> +			compatible = "fsl,s32g2-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0 0x401c8000 0 0x3000>;
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@401cc000 {
> +			compatible = "fsl,s32g2-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0 0x401cc000 0 0x3000>;
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@402bc000 {
> +			compatible = "fsl,s32g2-linflexuart",
> +				     "fsl,s32v234-linflexuart";
> +			reg = <0 0x402bc000 0 0x3000>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller@50800000 {
>  			compatible = "arm,gic-v3";
>  			#interrupt-cells = <3>;

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
