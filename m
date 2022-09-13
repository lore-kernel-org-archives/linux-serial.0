Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA78DC6FA82
	for <linux-serial@archiver.kernel.org>; Tue, 13 Sep 2022 16:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiIMQEK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Sep 2022 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiIMQDu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Sep 2022 12:03:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B96442
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 08:00:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c7so3322336ljm.12
        for <linux-serial@vger.kernel.org>; Tue, 13 Sep 2022 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GdCZkIFjdClxi+04hng0a7G/PMlIDrFRIuLM/UuEOzs=;
        b=Y0rQYv9z8beilzQx2ugOfa92UcpqtypBzYziOGjbc06KtET4+8LgctThDgk38PA3Ap
         1O+JSIIsyci3bP1SW2JFp5rqIe0G+8kMnHfcnVIa0uIZoPdEuMe4Pt2whD0LMvvVp3FW
         VpZRd+n8LGLqIq+fcSPCx7y62bZRwILmW3ct1e3SbnGg4tE2TntChCCEHZYxQlYcxs5I
         ZUuyfM8Ce9QfkzMOMssRo1IeBefHkv2qdOX26DjzEp3X26o+0014Hndv+HxcVZ3ur+FH
         bCYQkl5/zO/DUW4C2kRzvM7skiIS2mLHOZeO82pfbHUtS6OHUJr3Me+wlmkMjoNb4ghU
         1e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GdCZkIFjdClxi+04hng0a7G/PMlIDrFRIuLM/UuEOzs=;
        b=B6GF0BwVMZZ13ePdJA8HB/HjGv51wl11jeVLf7cf2vIazTwp1nAB12a2MUi59BlOj5
         gNrOwtrDZ619oTJeEf91dEjPdY0ebvOPiBZmH6x7qP0fsp9h7N9qByre8SQfO+gafHh/
         YiVwVc5m4TikB2kiIryeB5qcsPQnOqfWys2NreEzxNdbnffQ61rftHgRFfITbQ29VKNQ
         4UdmBGe+RxgZE/VKOgnr9GMB92knTlI28/XtJDfr9r3RkxD9/6jW+ytQ7alCJhStxYGr
         99AQwPkPIfiXD+oa79E9oxeqqlXZK5tVj22vdmOyFU5dUYfNfAPExiLcaZNBFiCzEYkO
         RvlQ==
X-Gm-Message-State: ACgBeo3LpMhfcXV7ZV+fa6UEPGbYZBL8mm2rABgzPB8sZrgpg21N28JB
        sHBFZ9Tiy1q6UP8zH0T/fUyuo6lwsKTLR/G+
X-Google-Smtp-Source: AA6agR7PeWmSBtKuOC1mG30e5zw+xbQsmAU90w5V231Ig4DCodUPhBcpEgZgQwBke/+4NDhIQ1m22w==
X-Received: by 2002:adf:f2c5:0:b0:226:e838:3ed8 with SMTP id d5-20020adff2c5000000b00226e8383ed8mr17490014wrp.545.1663079299598;
        Tue, 13 Sep 2022 07:28:19 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.67])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm14437149wmq.28.2022.09.13.07.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:28:19 -0700 (PDT)
Message-ID: <4f201ad4-ea4a-43af-9ec8-c2a3c1b80d2c@linaro.org>
Date:   Tue, 13 Sep 2022 16:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 06/14] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
 <20220913142205.162399-7-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913142205.162399-7-sergiu.moga@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/09/2022 16:21, Sergiu Moga wrote:
> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> json-schema format. Furthermore, move this binding to the
> serial directory, since binding directories match hardware,
> unlike the driver subsystems which match Linux convention.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - only do what the commit says, split the addition of other compatibles and
> properties in other patches
> - remove unnecessary "|"'s
> - mention header in `atmel,usart-mode`'s description
> - place `if:` under `allOf:`
> - respect order of spi0's DT properties: compatible, then reg then the reset of properties
> 
> v2 -> v3:
> - Previously [PATCH 5]
> - Check value of `atmel,usart-mode` instead of the node regex
> - Define all properties top level and disallow them explicitly for other type,
> since additionalProperties:false conflicts with referencing other schemas
> - Remove useless else if: after else:
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
