Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C8C7618A
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 07:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCPHgX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCPHgT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 03:36:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F096F01
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:35:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so3910454edb.6
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhl2NOXrZaXDT00C+3VE/RhnKTkQDskMniAh1B77lnA=;
        b=Zlg0DQoCqWbvQe5zraj7foLmCzl02hkkoplpGeFMSUQ9o2DYe8Ex/wkWK/jk7Oqc7o
         bAoufyuz1fyVShfF3eoMhmA5ktdqtNiX9fwImNRNXSYW6ObFKkh+Zwq2pL9J46dPTX6E
         5rWEBuKn7KGRqf29d07xnEy8mtyUf3eUNfAFSSkaMiWv48vONA1U2POBaLcQc5Y5KsWk
         G2yUtEEKq02pQVZrnYRb4yJb+hAHYAFNLL6G9mFyZIj9gqFU/vxVhPDOkkEKB/bAXt3J
         U2c7/xI/apfvt67r8+obvBmP99Mjc2/+kFKXrYV7WSxSxWjhpfuyNXE9q/MHr+HiP0ef
         9oNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhl2NOXrZaXDT00C+3VE/RhnKTkQDskMniAh1B77lnA=;
        b=ZO7KWcTAfA10QsqIbQDqMHwC67y+vCxe2zlmsNsk/yI8L6sBGoG8Ca1sh0fPb+tXwM
         xx1zZO3OphPQnqJvGQacj1bCO2JIXwNK9ElnPOrB2xBkcmn2lrGJKtIWHUo8+rSQ+KWf
         2Ufy1jsC/kAgJTJIAP+yzY+LSeRvU3hTSNg+E5y3VLUNQIekiVoGmBjEwLX4VaC8DfKM
         bEOimcTDxaaL16Vw6t2vF15MnFhkQCbBJiMBWSm0XMBsi9AdT9h7FNmUnvuXLyI0Owj2
         xjpAaD1ts1zVfJFWmP9VA7o/Yyx2hg3btjSfpu4FaS03h+nHtzDkJXeyEi9121c+wE8T
         dQow==
X-Gm-Message-State: AO0yUKUtcnthIkxKziNAGz9F/J0mVuOCbC/bAIv1FVudb+tbmeRzDUyC
        LMCw/LH9sQhpTHYBxeQJVHkqmA==
X-Google-Smtp-Source: AK7set+UTB+nuf8X4b/+VvemGysEkDy+ZZwHcNpcny2PAKMHvUNUVSCzeWyL3GifxDuJH3hXyCN+YA==
X-Received: by 2002:a17:906:5592:b0:930:b35b:5a53 with SMTP id y18-20020a170906559200b00930b35b5a53mr486390ejp.16.1678952150383;
        Thu, 16 Mar 2023 00:35:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709064b1500b00905a1abecbfsm3476379eju.47.2023.03.16.00.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:35:50 -0700 (PDT)
Message-ID: <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
Date:   Thu, 16 Mar 2023 08:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
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
 <20230315072902.9298-9-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-9-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 clock driver bindings.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> new file mode 100644
> index 000000000000..5c2dea071b38
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Clock Controller Module Binding
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description: |
> +  The MA35D1 clock controller generates clocks for the whole chip,
> +  including system clocks and all peripheral clocks.
> +
> +  See also:
> +    include/dt-bindings/clock/ma35d1-clk.h
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: nuvoton,ma35d1-clk
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: clk_hxt

Drop clock-names. You do not need it for one clock.


> +
> +  assigned-clocks:
> +    maxItems: 5
> +
> +  assigned-clock-rates:
> +    maxItems: 5

Drop both properties, you do not need them in the binding.

> +
> +  nuvoton,pll-mode:
> +    description:
> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
> +      integer mode, 1 is for fractional mode, and 2 is for spread
> +      spectrum mode.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 5
> +    items:
> +      minimum: 0
> +      maximum: 2

Why exactly this is suitable for DT?

> +
> +  nuvoton,sys:
> +    description:
> +      Phandle to the system management controller.
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"

Drop quotes.

You need here constraints, look for existing examples.



Best regards,
Krzysztof

