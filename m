Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69922C6FA90
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 12:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiIHMfV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Sep 2022 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIHMfP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Sep 2022 08:35:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8094237DD
        for <linux-serial@vger.kernel.org>; Thu,  8 Sep 2022 05:35:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x14so12109094lfu.10
        for <linux-serial@vger.kernel.org>; Thu, 08 Sep 2022 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MtvDPwj1xj98pXvIJlBDsjDT7GOeTmv6R4xmR0F7h50=;
        b=ucFDlTPKrAXCjsKtyiEsczadOihwVme4pmfa92cwDRzdU5ydN1T+oxzE49b1O4MzYQ
         /SDRABklxJrzY13pXcXVE6T43qjHK1tmp3ffLimBe+BEtPKsFhMhrvHhQFw10wQo4UMY
         QH2g/KHlt6WK/anxVHDlCmparhH43DRUlHLxNjGTIaSwmh/lippSbERMFm5CY8GaiOMq
         Yux3EwzYYbR7ml3R1QlCRwWDYc62eon4ZGTRPdHVjVV5eAC1gFLsLIx3pkwmhUsv7y19
         EBkug2XFehtF7k2SscPy5nqKdkBk6AAIBCgJsLLwflySfa/J4IlNiBKJYMrGV5n3dQO6
         wb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MtvDPwj1xj98pXvIJlBDsjDT7GOeTmv6R4xmR0F7h50=;
        b=XgLqFCh554w2fOmX5tvRMR/pwzZszflg6zElQDpzCsx/YFFfA18KuKebB3LRJNh11+
         l+AgFtLmt08QZ4DQHT11oWs0C4Q2VTnRtnWhZuWyFeQx3xsK8PCC9TC4uk7W3xjyBokz
         SmtpHW9thD5jsPBO5BgO+HeZeReA/80ZY/wCKA35h2ec521dQJ38nitFsnVQo15UDf8u
         gxQgNyLq6HFoUsOv0PRN1KUMt2tp6KiaXsd96BAr5QkQEKmP8+7EivypQzcv2EF6g933
         nBLjPG9ah0sfCN8hqlPFCxqC5zUX5j9WBKd/kf2g5vp+dmUrJgOJmOwlf5wFs2e2di4P
         j45w==
X-Gm-Message-State: ACgBeo2+CHY8EBGTbTVbNO7h+wIf5rEF1Kiqss7UYFBQgR+qn6KSS8Eu
        ntywvD0n90O6t/aDs7WsdWDphQ==
X-Google-Smtp-Source: AA6agR6mbkVKvTFOT42qF/i7lu1Gz70hK93yc9UJvNcVj5Z6ed6r33DSj5rC/gPINepqjhD/JWdAfA==
X-Received: by 2002:a05:6512:5c5:b0:497:f192:78ac with SMTP id o5-20020a05651205c500b00497f19278acmr1214013lfo.63.1662640511127;
        Thu, 08 Sep 2022 05:35:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w9-20020a19c509000000b004947984b385sm635694lfe.87.2022.09.08.05.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:35:10 -0700 (PDT)
Message-ID: <e93ef041-89d3-5718-4b1d-55bfd0c72797@linaro.org>
Date:   Thu, 8 Sep 2022 14:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 13/13] dt-bindings: serial: atmel,at91-usart: Add gclk
 as a possible USART clock
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-14-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906135511.144725-14-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06/09/2022 15:55, Sergiu Moga wrote:
> The Devicetree nodes for FLEXCOM's USART can also have an alternative
> clock source for the baudrate generator (other than the peripheral
> clock), namely the Generick Clock. Thus make the binding aware of
> this potential clock that someone may place in the clock related
> properties of the USART node.

Last sentence is confusing - what is the potential? Just skip it.

> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before

You have confusing order of patches. Bindings mixed with DTS mixed with
drivers. Keep things ordered.
1. DTS changes needed for aligning to schema.
2. all bindings
3. rest

Best regards,
Krzysztof
