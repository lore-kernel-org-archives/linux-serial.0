Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F77FC7618A
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 07:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCPHjP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCPHjN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 03:39:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CBDD538
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:39:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd5so3915713edb.7
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952342;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L80D9NzBtpET8zgBI2TIGG8S31tA19Skk/lPpa1cvUU=;
        b=u//MdYRS0r42kik8XCyqsuBQFuINbDrXTIOJEKYnG3tqfPtBuC+KZc3T9jvFF7sXoW
         Bfbk+Cxi1ob15CQlMLw72r+YU4UWTpV8OuXwnFUJcFE0ecrEIBtjo7SkREW9IZl40GdX
         0SiHSaTaKGRxmspn7C7k8LApCCDVGhBWlfwZ06xuYTHRGyQLubIeKSjymrDZ001ZOZnO
         tpivkVMAeSKpUBEzRzI20Z8i7hBHLFmZtJXqlkVX7CVsBZ63Kbnm69DQAXEVJhQQRHA/
         3Au4GBk8DYzC6VQeLUh7FWA83riRgzb4WYD4zFjyNUoAuC05pJw8rjfOUs4DevZqg/Lh
         dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952342;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L80D9NzBtpET8zgBI2TIGG8S31tA19Skk/lPpa1cvUU=;
        b=uTUxsTRmK6j4VTD/sL21GIHla4b4mrz51Dbs7f95FzFS/dBVzGWDHzVb9u2bga3BZc
         VliZiT7Dsuk0pqZqfgcWHd7LjEAQ5lYL1AIILtBJaeWahkeSfUAbMtv+lHm5M1IqvChm
         TKC4ZyEUz+3h/n1B8H8KAXcL48ZzliKMfkCZauQmX16GWbK4hgLuDaFo9sRdrsPXVDEA
         f4Kt6CF/5AMcULAMuWpidsreQT3RCdvE0ivmBtl1lfhnj4OgHJvxzM/mooy4dO3ebXy6
         uz9d6Q3tni2P6+ldPtOLKTK7sTU6sP52jE1ZPnRC/1prQoCrQ/q0fIMGLYpWUSVn02Cb
         ZAww==
X-Gm-Message-State: AO0yUKVIM7DhDDwcv/AbyZRfhlAU9UmWnHDKey+la5em7OnBetsblR6j
        GnHTO5uUw19KgtUZZ7QjgnvU/Q==
X-Google-Smtp-Source: AK7set+X7bdwNzSqtxKylbf4V544my6LOLVFYGokzYyuR1B0XP1meCH+xiaR2+xKI0kHvIiNDxq3MA==
X-Received: by 2002:a05:6402:651:b0:4ef:9bf0:7177 with SMTP id u17-20020a056402065100b004ef9bf07177mr5564351edx.9.1678952342340;
        Thu, 16 Mar 2023 00:39:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id a1-20020a509b41000000b004fb00831851sm3424666edj.66.2023.03.16.00.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:39:02 -0700 (PDT)
Message-ID: <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
Date:   Thu, 16 Mar 2023 08:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-10-ychuang570808@gmail.com>
 <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
In-Reply-To: <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16/03/2023 08:37, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 reset driver bindings.
> 
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
> 
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>  .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> new file mode 100644
>> index 000000000000..f66c566c6dce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Reset Controller
>> +
>> +maintainers:
>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +description:
>> +  The system reset controller can be used to reset various peripheral
>> +  controllers in MA35D1 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-reset
>> +
>> +  regmap:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the register map node.
> 
> You need to be specific what is this. As you can easily check, there is
> no such property in any devices. I don't understand why do you need it
> in the first place.
> 
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - regmap
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # system reset controller node:
>> +  - |
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +    sys: system-management@40460000 {
>> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
> 
> And your patchset is not bisectable.... Test for bisectability before
> sending.

Ah, no, it's correct. I see the compatible in previous patch. You need
to clearly describe the dependencies and merging strategy/requirements
in cover letter.

Best regards,
Krzysztof

