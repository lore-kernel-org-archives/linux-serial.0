Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4CC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E086109F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 18:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhHLSZ2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:25:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56120 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhHLSZ2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 14:25:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AD648222BC;
        Thu, 12 Aug 2021 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628792701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi7oLyJPDXy6ku7Fi1Eh5N37tZq9adDeMnE5MM3p5aw=;
        b=Um9FeldPod2W1iDCfCP0Ry0hLB1fcDvQ5r4CeqJavrZVxHoDEpPX7z82oe5+OMRU/vvOED
        T7QzsfAIk2IMrsmgfICFLWEz1MXNUod2hrUxnhzDZQtUPSQBv9geVNPyTH7fFQ2sR5Elo2
        cu9E98A+sRsYH+XQHZs9JElMgeZQlIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628792701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi7oLyJPDXy6ku7Fi1Eh5N37tZq9adDeMnE5MM3p5aw=;
        b=JuGetmj7oS0dbWVeFAdO8QVBznkhWJRx7sRhyRuDHphk/SlocukjawxaHSUgMP+cBSaoA5
        L6fFSx1RemJEZmBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1A9B413AD4;
        Thu, 12 Aug 2021 18:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UW1pBX1nFWGlGwAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Aug 2021 18:25:01 +0000
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
 <20210805065429.27485-8-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 7/8] arm64: dts: s32g2: add memory nodes for evb and rdb2
Message-ID: <17ab7b71-2dbe-0c66-e180-4cc2e8310441@suse.de>
Date:   Thu, 12 Aug 2021 20:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-8-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chester et al.,

On 05.08.21 08:54, Chester Lin wrote:
> Add memory nodes for S32G-VNP-EVB and S32G-VNP-RDB2 since they have fixed
> RAM size.

You can drop "since they have fixed RAM size" - if they didn't, you
would simply choose the lowest size and rely on the bootloader (U-Boot)
to overwrite it with the actually detected size.

Please expand why this patch is separate - BSP based, I assume?

> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  | 8 ++++++++
>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index a1ae5031730a..cd41f0af5dd8 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> + * Copyright 2019-2020 NXP

@NXP: Please review year, alignment. Do any Signed-off-bys apply?

>   */
>  
>  /dts-v1/;
> @@ -14,6 +15,13 @@ / {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 4GB RAM */

This looks strange to me - either put /* 4 GiB RAM */ before the node,
three lines above, and/or append comment /* 2 GiB */ on each line below.
Note the space, and suggest to be precise about factor 1024 vs. 1000.

> +		reg = <0 0x80000000 0 0x80000000>,

Note that this gives you the range to use for the .dtsi /soc node:
Address 0x0 with size 0x80000000 gets mapped to 0x0 0x0, excluding the
upper 0x80000000 for the RAM here. Or address 0x0 0x0 for two /soc cells
if there are high-memory peripherals.

> +		      <8 0x80000000 0 0x80000000>;

Maybe use 0x8 here and 0x0 above? (second 0 stays same, so don't mind)

> +	};
>  };
>  
>  &uart0 {
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index b2faae306b70..8fbbf3b45eb8 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> + * Copyright 2019-2020 NXP

@NXP: 2021?

>   */
>  
>  /dts-v1/;
> @@ -14,6 +15,13 @@ / {
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 4GB RAM */
> +		reg = <0 0x80000000 0 0x80000000>,
> +		      <8 0x80000000 0 0x80000000>;
> +	};

Same comments as for EVB.

>  };
>  
>  &uart0 {

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
