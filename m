Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1834EC76195
	for <linux-serial@archiver.kernel.org>; Sun, 19 Mar 2023 11:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCSLFZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Mar 2023 07:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCSLFY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Mar 2023 07:05:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83408234CF
        for <linux-serial@vger.kernel.org>; Sun, 19 Mar 2023 04:05:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so36519437edc.3
        for <linux-serial@vger.kernel.org>; Sun, 19 Mar 2023 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679223918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oz7Mn5Slt/oCZXIyID1LQ+0ctRwDR+H2/7RiKV/KiC8=;
        b=z9Ary3jPwxWtnf6V3vNq0eQZ+9bqPM/Bmrbyxfk9GUbrahRuXb97qVmkFUmRYa+xxt
         qhxjdZkanTFpgKwk3LMFZGwT2krOqdSJTTd89h8jm1Ukus9cQ+uXQu0/ys8Xz1Z92NRb
         3gRq0JyWpgV72Tez7iS2oLGKsS1QH6vKeeZ0NUUbJpGm88JDLx5NLWIFiZiXJisNgFTx
         fWy9a6H+0Np2gR8nFkyHjMJ8xJP2Wwkmp5Bkf3bitmkacsmQY6nOvlu0K6TpkaBnIuIu
         qY4YhIT+o/gQme3tKSptm/4YKxG5u7+uK+tOffmdCMIhsbM5d6rsaFIz+uTHFIa8XpRM
         jd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679223918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oz7Mn5Slt/oCZXIyID1LQ+0ctRwDR+H2/7RiKV/KiC8=;
        b=lFlZVwMmBxY4PobRMG6WYcfcy++6n4nPJCPr5J1wo1z0vaHlCu+cQHzoaTZfskxIyb
         5ux5c+Fpbipxq6zP6zfyS1tRmK3eQjklgY6CwBSMXSvC0KSDuXfi59bGKm0HeY8ypFXZ
         gWNDNUzV1S4xgRFOH1KO15Z0Xqn1EGC9EvVXe3/lPGSNjCNVs3wWNYjqL6ML8lYPDek2
         EBYpd2QUuSQWlQgOt0/fQ0WeMCglpn41MB8rQrK6TpD+6r1QIQWWz5t4/WxtmkyD544P
         iqybuGbJPQ0r0+GU46b3ItaTsF1a0fUAg9kH0w4UPVJp2gdU+ubWcsgMp8KNlnUcTW45
         QL0w==
X-Gm-Message-State: AO0yUKWEd5lzLr8R0uE1AgnBfYP7XgVpxTS6w7GfPvQuXHHlfGHpR525
        9cJ0/iPS7nhL8UucGVkXVgDuIw==
X-Google-Smtp-Source: AK7set8iyweCO1S8OBE+lR0gDceMHD0ysV/bfRKB03FfwieiyiZ/Nrqp+yiz4a4BU9OPNpb08OMDEg==
X-Received: by 2002:a17:906:4ed3:b0:932:2282:dbd6 with SMTP id i19-20020a1709064ed300b009322282dbd6mr6255501ejv.5.1679223917979;
        Sun, 19 Mar 2023 04:05:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b0093048a8bd31sm3138943ejb.68.2023.03.19.04.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:05:17 -0700 (PDT)
Message-ID: <fd0cb506-707a-4f5d-b917-de6a03787f6a@linaro.org>
Date:   Sun, 19 Mar 2023 12:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
Content-Language: en-US
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
 <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
 <4d62376f-1b33-62ac-2ed9-6b71ae7485a2@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4d62376f-1b33-62ac-2ed9-6b71ae7485a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18/03/2023 05:30, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> Thanks for your advice.
> 
> 
> On 2023/3/16 下午 03:39, Krzysztof Kozlowski wrote:
>> On 16/03/2023 08:37, Krzysztof Kozlowski wrote:
>>> On 15/03/2023 08:28, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add documentation to describe nuvoton ma35d1 reset driver bindings.
>>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>>> prefix is already stating that these are bindings.
> 
> 
> OK, I will fix it.
> 
> 
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>>   .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>>>>   1 file changed, 50 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>> new file mode 100644
>>>> index 000000000000..f66c566c6dce
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>> @@ -0,0 +1,50 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Nuvoton MA35D1 Reset Controller
>>>> +
>>>> +maintainers:
>>>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>>>> +  - Jacky Huang <ychuang3@nuvoton.com>
>>>> +
>>>> +description:
>>>> +  The system reset controller can be used to reset various peripheral
>>>> +  controllers in MA35D1 SoC.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: nuvoton,ma35d1-reset
>>>> +
>>>> +  regmap:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: Phandle to the register map node.
>>> You need to be specific what is this. As you can easily check, there is
>>> no such property in any devices. I don't understand why do you need it
>>> in the first place.
> 
>          reset: reset-controller {
>              compatible = "nuvoton,ma35d1-reset";
>              regmap = <&sys>;
>              #reset-cells = <1>;
>          };
> 
> The dt_binding_check check report an error about the above "regmap".
> 
> I found that add this can pass the test.

Do not add properties to bindings to "pass the test". That's not the
goal of bindings. Add there properties because they make sense...

Anyway, you did not answer my question at all. So one by one - address them:
1. As you can easily check, there is no such property in any devices.
Explanation: do you see it anywhere in existing bindings?

2. I don't understand why do you need it in the first place.
Explanation: your binding suggest this is not needed. If you think
otherwise, you need to provide rationale.



Best regards,
Krzysztof

