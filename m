Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A1C43461
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 08:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEE620C56
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 08:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIm4qyEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgH1Iqg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgH1IqS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 04:46:18 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD982C061233
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2020 01:46:17 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a21so198090vsd.3
        for <linux-serial@vger.kernel.org>; Fri, 28 Aug 2020 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=189lzAWfQfsXqTmFG0edsCDCtQB53S1O0XCFYRVJy0M=;
        b=aIm4qyEymVO5ohXmss62q8J7ZsU21OeX87DHri44FY+MtB8kKPRTRN8fC2fuIy9zvX
         Z9GTB09WEFGr+7TVAWibwyGyVwol+ajGdpcyUuC4mEf8pIP20ndS3jHWcXKurf5SVAhY
         V+KCtnocv+7SjPRR+/YrhNgmkynyreSovR2OBYvRS0xkDojpgFoNajirehBgyh2Hrzif
         0zPrbgW8qQ+iLRDMParVC4EFTYOfC0SYgcE9hKp/OLDf4Z3U/WxlgJJAx8ImgeFHI7Ms
         K2rPmiftA1He8wyBKNzMVDF2IAg9gwh+r+motN/9SM691+1Dlb6EM3f2CTGjxwoc2hSk
         YCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=189lzAWfQfsXqTmFG0edsCDCtQB53S1O0XCFYRVJy0M=;
        b=WMG5ZmHrPtG6f32npyNYA32G1th82m4jlLd35RhI5bgvavjhigtZtCs/L03vAQJZXV
         y8pUzlbtxkYIDcTbx+64rxy06TWPOCJUY2tTpnHn+9G/9K7QoVqUNEbnYL7bEIgNACJI
         p1S+0wnNgBWOHxyq/mjgJaOZB/7/OQf+dLsq8vS+T8suhrp7nD3Emvg7p3nFLj2ao9Xc
         e5Vd1kNdGD5AqS8Y5JxvKKFiRycITIzfC9YPbr6gRbfE07VeI4FIBwb5/1BsS3XdpWyt
         6Ym6CHy8yY76lbam1o0mVOKLVgPBI0rfsR5mvHeautIwx8+txiK+kWpABNNSrkKi6sr1
         PrUQ==
X-Gm-Message-State: AOAM531IebiiMaqelP40IdGOyl6OnaEvvvPl/3PYzQ+QH8g+9e3CElHw
        OLn/1INygLEGu8nJ7popKlG22ISprOdZZFtZF37YYA==
X-Google-Smtp-Source: ABdhPJwdM//IK26BNKLGQTKBrolM5NysJSl2j+QUGwsOTG7KyqNDjalKpnYeND/9ptvlwZBlFInKLZnPBJM5EgFzpWg=
X-Received: by 2002:a67:f8ce:: with SMTP id c14mr189781vsp.14.1598604376960;
 Fri, 28 Aug 2020 01:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org> <20200825193536.7332-13-krzk@kernel.org>
In-Reply-To: <20200825193536.7332-13-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:45:40 +0200
Message-ID: <CAPDyKFp9m6xBJMGn2TgwD8VEUZ0JwzgowU32qUbL1qgEPua-GA@mail.gmail.com>
Subject: Re: [PATCH v3 12/19] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8
 compatible matching
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-serial@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 25 Aug 2020 at 21:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The i.MX 8 DTSes use two compatibles so update the binding to fix
> dtbs_check warnings like:
>
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>     From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
>     compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
>
>   arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
>     compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Rob, Krzysztof - do you want me to pick this one?

Kind regards
Uffe

>
> ---
>
> Changes since v2:
> 1. Remove moved compatibles.
>
> Changes since v1:
> 1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
> ---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
>  1 file changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 10b45966f1b8..e71d13c2d109 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -21,23 +21,26 @@ description: |
>
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx25-esdhc
> -      - fsl,imx35-esdhc
> -      - fsl,imx51-esdhc
> -      - fsl,imx53-esdhc
> -      - fsl,imx6q-usdhc
> -      - fsl,imx6sl-usdhc
> -      - fsl,imx6sx-usdhc
> -      - fsl,imx6ull-usdhc
> -      - fsl,imx7d-usdhc
> -      - fsl,imx7ulp-usdhc
> -      - fsl,imx8mq-usdhc
> -      - fsl,imx8mm-usdhc
> -      - fsl,imx8mn-usdhc
> -      - fsl,imx8mp-usdhc
> -      - fsl,imx8qm-usdhc
> -      - fsl,imx8qxp-usdhc
> +    oneOf:
> +      - enum:
> +          - fsl,imx25-esdhc
> +          - fsl,imx35-esdhc
> +          - fsl,imx51-esdhc
> +          - fsl,imx53-esdhc
> +          - fsl,imx6q-usdhc
> +          - fsl,imx6sl-usdhc
> +          - fsl,imx6sx-usdhc
> +          - fsl,imx6ull-usdhc
> +          - fsl,imx7d-usdhc
> +          - fsl,imx7ulp-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
> +              - fsl,imx8mq-usdhc
> +              - fsl,imx8qxp-usdhc
> +          - const: fsl,imx7d-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.17.1
>
