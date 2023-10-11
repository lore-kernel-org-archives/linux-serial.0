Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A02CD6E44
	for <linux-serial@archiver.kernel.org>; Wed, 11 Oct 2023 08:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjJKItP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 Oct 2023 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjJKItP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 Oct 2023 04:49:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255499D
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 01:49:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b95622c620so1197939466b.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697014151; x=1697618951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=goU66zG1Z8ZGxlkEzc0eoZzJ+tEswmSUbrbJMfgUSLU=;
        b=wmpspTAx8MANuNj6yvDA8hLV0wx7a29XhzMm55bx8Ihi8jY1CGvY82w/NTl3IGYPsM
         GFwdLpNwRTTf0xQwsyFOv2sGDgaKatu5Nka5G97Ai6I45EolVhijgI53mHuer3sw3vnI
         BHDqOnb0NuwmhXdPbUfFsWhQ4A6kK5fsL7SdSaFfMd8hIz5lUBVE/SRpUd0AN6V7kvaJ
         KHixLzqYM5v9Y2J+GE0Blz5deEdsJwbL1ht3gQVbWMt3Qh7P+Kpwya6WVivnKg9dn3sY
         rZfy+bUn9A6OVXtwQuNyNoPxSXm5ciyWiDRpHEAeSTyfiNdqH5mvBmlMqk5WsmdIRmFh
         iSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014151; x=1697618951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goU66zG1Z8ZGxlkEzc0eoZzJ+tEswmSUbrbJMfgUSLU=;
        b=vmiWfOBT0d9IDISzHT3Ix94CRmAu3P+8b4CaDbASCD/WRqCzoJvvP088Ipu257m7XC
         sUYjP37EGlVZaJJmC5S7IKcIOCVxDtJwzvHrn0qI2mIp2ArH6sqP9JWBWEsExivBUBQO
         dzJaak6U5Ewlj5trqy+dT5KmcwWh5mI38XAxx/N3zob+5sMKnvO+C3MX81Gx0RFHjsAo
         R9Rx8dtyGG/GaCa17AC6KlkXfEtHh6HVzkLZw0X2Eh/1H6xx5K61XjrXnw2/ol+Zdv6I
         /rVUfLk4L42UNzClTbfc8jOnunXmL9ijfhM7D214nzv4P0aEvsn0BLmUno7utSBBwVZk
         kbsA==
X-Gm-Message-State: AOJu0YzHGF5EjR/UzwCeZxbVOi4NFEK8xePEymR2x0oVZupwnv1ZoRwA
        xDRdISoLg0yl+rqeSGSlwlbLyA==
X-Google-Smtp-Source: AGHT+IExnFJCom6CH9oUPktlA1Qk1vtPOJTjoCod0Pf9vHRdBJj4j6vUQMY9Dt2O6Rng+8xy+rHUpA==
X-Received: by 2002:a17:906:844a:b0:9ae:73ca:bbae with SMTP id e10-20020a170906844a00b009ae73cabbaemr15809476ejy.62.1697014151564;
        Wed, 11 Oct 2023 01:49:11 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.123])
        by smtp.gmail.com with ESMTPSA id dc4-20020a170906c7c400b0098e34446464sm9555049ejb.25.2023.10.11.01.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:49:10 -0700 (PDT)
Message-ID: <a6c57156-d3a5-4524-8ef8-6f27cf0a2c97@linaro.org>
Date:   Wed, 11 Oct 2023 09:49:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] dt-bindings: serial: samsung: Add
 google-gs101-uart compatible
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Peter Griffin <peter.griffin@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
 <20231010224928.2296997-9-peter.griffin@linaro.org>
 <2023101111-banknote-satin-1f77@gregkh>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2023101111-banknote-satin-1f77@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Greg,

On 10/11/23 08:48, Greg KH wrote:
> On Tue, Oct 10, 2023 at 11:49:16PM +0100, Peter Griffin wrote:
>> Add dedicated google-gs101-uart compatible to the dt-schema for
>> representing uart of the Google Tensor gs101 SoC.
>>
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> index 8bd88d5cbb11..72471ebe5734 100644
>> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>> @@ -19,11 +19,13 @@ properties:
>>    compatible:
>>      oneOf:
>>        - items:
>> +          - const: google,gs101-uart
>>            - const: samsung,exynosautov9-uart
>>            - const: samsung,exynos850-uart
>>        - enum:
>>            - apple,s5l-uart
>>            - axis,artpec8-uart
>> +          - google,gs101-uart
> 
> These shouldn't be needed, just declare the device as the same as what

We should have SoC specific compatibles so that any further quirks or
incompatibilities can be easily addressed. It's not only the IP itself
that can differ, it's also the integration of the IP into the final
product that could have an influence on the behavior.

Cheers,
ta

> the chip really is (i.e. a samsung uart), that way no .yaml or kernel
> driver changes are needed at all.
> 
