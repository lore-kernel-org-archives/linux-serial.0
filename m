Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7BBC6FA8A
	for <linux-serial@archiver.kernel.org>; Thu,  8 Sep 2022 12:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiIHMdQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Sep 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbiIHMdM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Sep 2022 08:33:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150111316E2
        for <linux-serial@vger.kernel.org>; Thu,  8 Sep 2022 05:33:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z23so19740612ljk.1
        for <linux-serial@vger.kernel.org>; Thu, 08 Sep 2022 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Qyru9SAfxdnNAoiz22FTxnAwNC5Cr+8SPNsc9ocSsIc=;
        b=f7wa2z+PB3fEAcSD3njThDARidFNQguSSunU6swdNpXzExqTrXH4PJgNHVhFxxvqct
         lYKOp2jWPUSJltKRlEsrvQexdKtaQT3i3dwr0iztMGW7jS+Jy927WOXT4DbmDQiFreKV
         wAFzs2TPxXf+6O0lIn3hJ0uB9wzGMAhxGSyuJqAFow8FmDkHjGTyCz33v9pZRtLLU8Bp
         iT+q+odD5f59VF/J/8iP35GYJflHIc0y0E8ANwCol0kCp0FhPGNJhjXrQdxmgI5UxSLS
         qhUTBv86bbgKwFlQZW7ELbvbwQ+MCIt2FPQpkGroIuea5QJ8BX/ZhbN4GghfQdEw8UZ1
         Qdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Qyru9SAfxdnNAoiz22FTxnAwNC5Cr+8SPNsc9ocSsIc=;
        b=n96gamanh1xu/FbNP1I9vuO2ULZiGBh0+L5ue2tFjYIqVGD98G1EkOQtwenagE1PpP
         zYniVqxouHujqdQMmDybhvlNlVT4+s6jrwxXXsiMRN6bT9lGjRcWdATKLFz+xfrScO1A
         nj+D6ZXxBmy3QKhIy6rPJvXhU+/PHDzvreC28VBJUbE/CiaMg0gsiEitPFL/gC30af1L
         Ok5eLCcWBnTldooOLgvyDpxZ/2f0tBSL/+4G7njwIDW+J0JIMs6wi88vfeoUGmu6SC2l
         dasXy1hEKKR/dDEQammmqopZJ8NQmMGX7nnzggEYyVwhjr/KXmXNc4LDSdZsccjtt4xk
         Sxgg==
X-Gm-Message-State: ACgBeo0AdlVvvZSm6LxzVvHBYCRX44EdBnUrbnxOXbwKVik/ZhY5y33G
        6ehhiJIRt52Hx83dRTFFyzLtlQ==
X-Google-Smtp-Source: AA6agR7V97zwiD9pYqVJ0dFEam4iMWv2WsE07yb8VQiXEY40nYMp8wnTZhtCr1GIsKgf9/LZQCcqVg==
X-Received: by 2002:a2e:b16d:0:b0:26a:d1da:db8 with SMTP id a13-20020a2eb16d000000b0026ad1da0db8mr1709534ljm.217.1662640385823;
        Thu, 08 Sep 2022 05:33:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b0048b17852938sm145414lfr.162.2022.09.08.05.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 05:33:05 -0700 (PDT)
Message-ID: <633c8aa3-cc05-b855-24db-110a4863ff75@linaro.org>
Date:   Thu, 8 Sep 2022 14:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 07/13] dt-bindings: mfd: atmel,sama5d2-flexcom: Add
 USART child node ref binding
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
 <20220906135511.144725-8-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220906135511.144725-8-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 06/09/2022 15:55, Sergiu Moga wrote:
> FLEXCOM, among other functionalities, has the ability to offer the USART
> serial communication protocol. To have the FLEXCOM binding properly
> validate its USART children nodes, we must reference the correct binding.
> To differentiate between the SPI of FLEXCOM and the SPI of USART in SPI
> mode, use the clock-names property, since the latter's respective
> property is supposed to contain the "usart" string.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - Nothing
> 
> 
> 
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml      | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> index 0db0f2728b65..b5fb509f07ec 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> @@ -72,13 +72,21 @@ properties:
>  
>  patternProperties:
>    "^serial@[0-9a-f]+$":
> -    type: object
> +    $ref: /schemas/serial/atmel,at91-usart.yaml
>      description:
> -      Child node describing USART. See atmel-usart.txt for details
> -      of USART bindings.
> +      Child node describing USART.
>  
>    "^spi@[0-9a-f]+$":
> -    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
> +    allOf:
> +      - if:
> +          properties:
> +            clock-names:
> +              contains:
> +                const: usart

Devices are not different because they have or have not clock. Devices
are different... because they are simply different models, so this
should be different compatible.

Best regards,
Krzysztof
