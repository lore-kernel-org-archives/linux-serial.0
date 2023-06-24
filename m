Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070B1C001DE
	for <linux-serial@archiver.kernel.org>; Sat, 24 Jun 2023 08:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjFXI1l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 24 Jun 2023 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjFXI0h (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 24 Jun 2023 04:26:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460663AAB
        for <linux-serial@vger.kernel.org>; Sat, 24 Jun 2023 01:24:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso376327a12.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Jun 2023 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595064; x=1690187064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yae1xwiE1cf9aPKATRkJstBDOT3q8TFXp4hszvxUyq4=;
        b=YvJo2eOgRjp7Nu6HhZ0Ly7NiVzudeerZDZdvpLCxauEGIQLTSmWoGvQYvBao1wZScz
         DwypTBLhATAp1xYtmvvzrbepVybavA2kDJIZ6OTCfaeU2DqzJhIi0sDHRrUf9mgIi7vt
         SNMmUaSx0RBVeYcEjuVRwUWagYFtzUOCiEnkVCXkQZdFMgK62kOMU0thxzRYXOfOKFUA
         N+AFT++jOCSod/PyCezzloQ+RuTZWKMUi+cvqeAa/1dHRMe+yc1Co/n21k/VpmGf3OMy
         4qgUMaYkuVxnOjNeBetr+cQ8NtkB6O7vMGVqjD2g2tS9xyBdAaGervXpA6OT+7fSJbe0
         eyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595064; x=1690187064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yae1xwiE1cf9aPKATRkJstBDOT3q8TFXp4hszvxUyq4=;
        b=RfmTm0gpdjrHiRkpo3Y3P5XAXmtF1iHyVvrXBCdOSkl0GRQDfDRO70Fl9yC3d11BhM
         Q1ZQzFnISeSXQsfpirrZGEr1ZQpmnRv3byyXY6YeHcCLc1Yn3Cl9q3hNlMzad9rPykLq
         ssq8E+tHv/SkXa86WXl3+k3F59WN4/5BzwqpG1v1EWnzstwNPeNfz5ALj/l9D+C/EbpL
         2JLIkfHC9XCxYGHdNVL3bym1C0+uTWWDzBCwAN6oR+BldYM/v2MYBRvfRP+h/qAbCpUK
         DaTxHay84HN9xsrwnVUFc3tgiCVgYUrR4oePPA9P2omSzz27xAvyXr28ij8sk7bcDCYd
         oy/Q==
X-Gm-Message-State: AC+VfDwiXwrVXSmK17cZJUGYZNbMqWABmFW7nuOGnzKWii/bDyFvwGYT
        N6PfHRgc8luvYGWC6NY9x2xv6Q==
X-Google-Smtp-Source: ACHHUZ4jx/P2g1ir+gWmRrIWZy7IcsqiuMUVodKxODs+k03Uhx0DKtj4fioGTzgljiuR+pyFa4GrWg==
X-Received: by 2002:a17:906:da84:b0:988:9856:9bef with SMTP id xh4-20020a170906da8400b0098898569befmr16424749ejb.30.1687595064307;
        Sat, 24 Jun 2023 01:24:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b009829dc0f2a0sm617775ejb.111.2023.06.24.01.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:24:23 -0700 (PDT)
Message-ID: <b8dbe86a-7b95-6839-a1d7-069d0dfa6a45@linaro.org>
Date:   Sat, 24 Jun 2023 10:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 24/45] dt-bindings: sdhci-of-at91: add
 microchip,sam9x7-sdhci
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
        ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        olivia@selenic.com, a.zummo@towertech.it,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, sre@kernel.org, jerry.ray@microchip.com,
        horatiu.vultur@microchip.com, durai.manickamkr@microchip.com,
        andrew@lunn.ch, alain.volmat@foss.st.com,
        neil.armstrong@linaro.org, mihai.sain@microchip.com,
        eugen.hristev@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
        balamanikandan.gunasundar@microchip.com,
        manikandan.m@microchip.com, dharma.b@microchip.com,
        nayabbasha.sayed@microchip.com, balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-25-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-25-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add microchip,sam9x7-sdhci to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 69edfd4d3922..b8df78fbc00f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -5,11 +5,13 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
>  sdhci-of-at91 driver.
>  
>  Required properties:
> -- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
> +- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
> +			or "microchip,sam9x7-sdhci"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof

