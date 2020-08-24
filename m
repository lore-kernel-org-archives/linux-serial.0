Return-Path: <SRS0=CzRg=CC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D303C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 24 Aug 2020 09:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7122072D
	for <linux-serial@archiver.kernel.org>; Mon, 24 Aug 2020 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260295;
	bh=yC4JaXoKNf09Y0qzawwSDFabUkiWka/yjmUa9jFldxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GxdlMw8q4Tu+sJ/mh76Y9GY+PSMaFbT+KtjTUCxk/nl4eCDh5CIlXU4a2j9MA4Wij
	 /seAKidnuzXV1C9s7ks1n62M43TKTu5AqEB4xe30faXkVAzO1tmpRdZKjFIQaRKNvs
	 l+DAwrU/DV+7Ox2nSW/w+VVZcg6Z/tLWXb9W5MVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgHXJLb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:11:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34220 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgHXJLJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Aug 2020 05:11:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so7916161wrw.1;
        Mon, 24 Aug 2020 02:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUF3QN5qpBvG5fN8G2Ybjf+ixCnkDOi3rCaIBYZPN7k=;
        b=ouW01Ugyoltiz0Tx3d9PGq3yilZvXygJuQHcRAAJ9HRDxccD35sORb7bGyMHOGRuc4
         /tDhxaT+pfJvDL5DhOzwyUDvgxNkE08LfpHx1xYYFauC9GcBu4yGLqKdHtOdYTLfogpu
         s4XQbNccL/KuCNmRQ1xC8AkUcj8kdoCuMRKuSslnpIvwWxoylFLUnSmjRmLY3EeUtzP4
         qAdjf+udAjrsgY2JGo05AzLad6qApmRkflnVDfeszoJk2L5EVve/gSromwZ3AYfwSqtc
         RF83qvovbQ2PmWgIEeXsaGOhK+AUrWU1uU83cnUPepa6TB3iiUXxA17IqhxqV4PFrAWY
         UldQ==
X-Gm-Message-State: AOAM531YOWNKYyGkZoiFt4aTQW1TkcRsR4Ia3vhcAObpZlYiB3iaefGS
        4VuhqXZTDFBb0FY8N3hQs8s=
X-Google-Smtp-Source: ABdhPJwE3kGFDhN1s/hoJjFR2sSwbpKpOgvJl8AK3ZwbGzN+OM9ankAAiOzMdDiYIc2qELP19gLoww==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr4845334wrn.253.1598260266068;
        Mon, 24 Aug 2020 02:11:06 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y24sm21368601wmi.17.2020.08.24.02.11.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 02:11:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:11:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Aisheng Dong <aisheng.dong@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH 21/22] arm64: dts: imx8qxp: Remove i.MX7 compatible from
 USDHC
Message-ID: <20200824091102.GA20819@kozik-lap>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-21-krzk@kernel.org>
 <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB49668B0F67B02B2A33603B4880560@AM6PR04MB4966.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Aug 24, 2020 at 09:00:19AM +0000, Aisheng Dong wrote:
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: Monday, August 24, 2020 12:16 AM
> > 
> > The USDHC on i.MX 8QXP has its own compatible described in bindings and
> > used in the driver (with its own quirks).  Remove additional fsl,imx7d-usdhc
> > compatible to fix dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: mmc@5b010000:
> >     compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
> >     From schema:
> > /ocumentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> > 
> >   arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dt.yaml: mmc@5b010000:
> >     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was
> > unexpected)
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> For Patch 19-22, I think we should fix dt binding doc.

Are you sure that these USDHC controllers are compatible with i.MX 7D?
Could they really run with fsl,imx7d-usdhc compatible?

The implementation (Linux kernel driver) is different, I guess on
purpose...

Best regards,
Krzysztof

> 
> Regards
> Aisheng
> 
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 61bccb69f09e..26c4fcdfe290 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -362,7 +362,7 @@
> >  		};
> > 
> >  		usdhc1: mmc@5b010000 {
> > -			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			compatible = "fsl,imx8qxp-usdhc";
> >  			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> >  			reg = <0x5b010000 0x10000>;
> >  			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>, @@
> > -374,7 +374,7 @@
> >  		};
> > 
> >  		usdhc2: mmc@5b020000 {
> > -			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			compatible = "fsl,imx8qxp-usdhc";
> >  			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> >  			reg = <0x5b020000 0x10000>;
> >  			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC1_IPG_CLK>, @@
> > -388,7 +388,7 @@
> >  		};
> > 
> >  		usdhc3: mmc@5b030000 {
> > -			compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
> > +			compatible = "fsl,imx8qxp-usdhc";
> >  			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> >  			reg = <0x5b030000 0x10000>;
> >  			clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC2_IPG_CLK>,
> > --
> > 2.17.1
> 
