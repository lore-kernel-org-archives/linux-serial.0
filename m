Return-Path: <SRS0=IZPE=C4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEA0C43464
	for <linux-serial@archiver.kernel.org>; Sat, 19 Sep 2020 11:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333CC21707
	for <linux-serial@archiver.kernel.org>; Sat, 19 Sep 2020 11:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knwDHDCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgISLst (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 19 Sep 2020 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISLst (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 19 Sep 2020 07:48:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4EC0613CE
        for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2020 04:48:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so7664512wme.0
        for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2020 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqfVNx3hhEhUsnViEg4Q3DfHCFM9fuSUQF+oW2vIHtc=;
        b=knwDHDCT0dgHd5iowBldBQNOWvFeAysrLCHH0maY7muKugQgRbnbz1P8vnCw6DaSpJ
         ciXUjDTQVZmD9PoH6MGDfHQ4jHBZCg6PAgD9ujI56sjJoNElITaY8F5buRZTNFK6BnEt
         Mco3caQQnX+JEnrDckrMAU6j3wd7mrdtr3gHl40FDE2T3/xPdvwHx1FGlj3Fn/CuVCZx
         fQIIL7+WDALe+bkd1YRUCQttMbHbNVGkHjsv9bzNkdfbbpm59zYQNFLfC50/f+8HoyA6
         U5GwXFvICRvQGaZcnl+YCXd60MnrdaqhBTZ7xA7e3YyULNvpepBEfbUKgtFNYCVdekW8
         ddGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqfVNx3hhEhUsnViEg4Q3DfHCFM9fuSUQF+oW2vIHtc=;
        b=uV/sk0iQeZpn3Jm9fqBfdti1OG6diATphtnayoBLfttRgjltNut+gNPjb4GgImhKE+
         XNsKWNEiGqKOZnZIHZSTCqw+cSyeRZxvdg46B7EId7/8PGVS7/dkWyPnXHnYRAQTBgHd
         lyYcDGt58l3Jd3Lpgu4GrykLiBahEaq0JPfJuAz3M+ayxD3PnFT7d7weKtpr8TrahcT/
         W4zIhRXCb1wVf1jUrrBYwtmF6uIFTKd/pWW6ZfFi1NEny5nt/Uif2s9x7Ji9kwTsXMG6
         oG1EYtEXzwPVS9CWHslmcnJcbC0+tApCjCvBqybS+9VW72lPmWpyne3G6t9ZegANeR1z
         DWIQ==
X-Gm-Message-State: AOAM531emL+1M1c9pyy7eeWAuzhNMM4rDsdR7uxCs9yF8U2N1o2L2qAQ
        u9Pf/TDIDwwbKqaOZqH3lmguxA==
X-Google-Smtp-Source: ABdhPJyHe040jXDZbspHnU3tY6SFVLZqfiVYrksVkx0hl6AeqxBHjwI6XAXEGClfvHTNjsJJN7YyuA==
X-Received: by 2002:a1c:c383:: with SMTP id t125mr2830251wmf.13.1600516127445;
        Sat, 19 Sep 2020 04:48:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9142:20e7:201d:cd11? ([2a01:e34:ed2f:f020:9142:20e7:201d:cd11])
        by smtp.googlemail.com with ESMTPSA id y2sm9766752wmg.23.2020.09.19.04.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 04:48:46 -0700 (PDT)
Subject: Re: [PATCH v3 07/14] dt-bindings: thermal: imx8mm-thermal: Add i.MX
 8M Nano compatible
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20200904152404.20636-1-krzk@kernel.org>
 <20200904152404.20636-8-krzk@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <81a8248f-0d02-5646-36b2-5d4c3a7c4211@linaro.org>
Date:   Sat, 19 Sep 2020 13:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904152404.20636-8-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/09/2020 17:23, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
>     compatible:0: 'fsl,imx8mn-tmu' is not one of ['fsl,imx8mm-tmu', 'fsl,imx8mp-tmu']
>     From schema: Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
>     compatible: ['fsl,imx8mn-tmu', 'fsl,imx8mm-tmu'] is too long
> 
>   arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: tmu@30260000:
>     compatible: Additional items are not allowed ('fsl,imx8mm-tmu' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Shall I pick this patch separately or did you merge the entire series ?

>  .../devicetree/bindings/thermal/imx8mm-thermal.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> index 38852877b8e3..89c54e08ee61 100644
> --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> @@ -18,9 +18,13 @@ description: |
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx8mm-tmu
> -      - fsl,imx8mp-tmu
> +    oneOf:
> +      - enum:
> +          - fsl,imx8mm-tmu
> +          - fsl,imx8mp-tmu
> +      - items:
> +          - const: fsl,imx8mn-tmu
> +          - const: fsl,imx8mm-tmu
>  
>    reg:
>      maxItems: 1
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
