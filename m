Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04C9C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 18:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4FB60FED
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 18:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbhHLSA3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:00:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35566 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhHLSA3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 14:00:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ABE8E1FF6E;
        Thu, 12 Aug 2021 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628791202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPq75eCxT+YlAg6XI9cL9LjIMlQFz2YZeURX6oXUIhI=;
        b=yB/GEREBwDkn0vphDmIqlIB8noRASPCoWKQ8EXtlkYni/wjHChRfolqSKkeZ2TLvcLBlbm
        I2ig2kbOxRwTj4ZSPIhyQeIZ1U4LkjkkjYf7c7lDyXPKd2yAly0yNMfS5mQnFW5mk3sGX9
        gA5Tdxjzj0Nu7ICIPLNIO6aU5U8/Krg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628791202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPq75eCxT+YlAg6XI9cL9LjIMlQFz2YZeURX6oXUIhI=;
        b=DpQVkf1E51sIL8bPK9bsh8EKOktkw0jeYmdro+ANhja9hqt26NDFLn85g5gudxklTOO0aQ
        QRYUSMr/jXTpRHAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 16A2A13AC3;
        Thu, 12 Aug 2021 18:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id vkHZA6JhFWGlFgAAGKfGzw
        (envelope-from <afaerber@suse.de>); Thu, 12 Aug 2021 18:00:02 +0000
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
 <20210805065429.27485-7-clin@suse.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Subject: Re: [PATCH 6/8] arm64: dts: s32g2: add VNP-EVB and VNP-RDB2 support
Message-ID: <aef2fab4-078e-330b-28d0-1da964985f83@suse.de>
Date:   Thu, 12 Aug 2021 20:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805065429.27485-7-clin@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chester et al.,

On 05.08.21 08:54, Chester Lin wrote:
> Add initial device-trees of NXP S32G2's Evaluation Board (S32G-VNP-EVB)
> and Reference Design 2 Board (S32G-VNP-RDB2).

"Reference Design Board 2"?

> 
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts | 21 ++++++++++++++++
>  .../boot/dts/freescale/s32g274a-rdb2.dts      | 25 +++++++++++++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-evb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 4b4785d86324..2886ddd42894 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -67,4 +67,6 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>  
> +dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
> +dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb

@NXP: Note that since there's no distinction between S32V and S32G on
the Kconfig level, we decided not to add a white line here. If you wish
to visually separate them, that could be changed.

For reference:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/Kconfig.platforms

speaks about S32 (without V), so did not need to get updated for S32G2.

>  dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> new file mode 100644
> index 000000000000..a1ae5031730a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 SUSE LLC
> + */
> +
> +/dts-v1/;
> +
> +#include "s32g2.dtsi"
> +
> +/ {
> +	model = "NXP S32G2 Evaluation Board (S32G-VNP-EVB)";
> +	compatible = "fsl,s32g274a-evb", "fsl,s32g2";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +

Is there any marking on the PCB that a /* ... */ comment could reference
here? Right now uart0 is close to stdout-path above, but that will
change once more device nodes get added and enabled alphabetically.

> +&uart0 {
> +	status = "okay";

No clock-frequency or clocks property needed?

> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> new file mode 100644
> index 000000000000..b2faae306b70
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 SUSE LLC
> + */
> +
> +/dts-v1/;
> +
> +#include "s32g2.dtsi"
> +
> +/ {
> +	model = "NXP S32G2 Reference Design 2 (S32G-VNP-RDB2)";

"Board" missing.

> +	compatible = "fsl,s32g274a-rdb2", "fsl,s32g2";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +

Comment please.

> +&uart0 {
> +	status = "okay";

No clock-frequency or clocks property needed?

> +};
> +
> +&uart1 {
> +	status = "okay";
> +};

What is uart1? Please add a comment. Does it actually work without
clocks property?

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
