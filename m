Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CEC6FD19
	for <linux-serial@archiver.kernel.org>; Thu, 16 Mar 2023 07:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjCPHiD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCPHiC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Mar 2023 03:38:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A329B983
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:37:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w9so3975113edc.3
        for <linux-serial@vger.kernel.org>; Thu, 16 Mar 2023 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hF/zNj1V0FG7Xst+DyFdaV0IqlsgpWiuTDh6rcAehuI=;
        b=UZpv1cNZxXWcEX/fMRoA3CV/3HFENAHzHCospOSmfTP22Qjiz9f12YHg5fSt9D7Te1
         TyuwtPZsy6fyGGEXDH8ZLAfSWrTo1kO5+QlbyE/EjAyAO1BnNjks7uT9BBzmTHXF407m
         h/Ad2EnyY70WDkeCuNRxZfjgo2KlmGmUpnWfQAfug7WePy+N5IjRsk2iDanu0XowtAGJ
         gvltWl5uy+aSaJBjiEhYeOX5f/cTJoiLMAyjEdmLuwnuuE7TF4XJp0tCs5OC3PyjZ4LE
         ngeY2We5dC+XJYajz6nxGQMVkMihdHaktyvXV+2lmVMbJFBfO3G2koGyPrg7Vg4qsZ2j
         4HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hF/zNj1V0FG7Xst+DyFdaV0IqlsgpWiuTDh6rcAehuI=;
        b=btrohFsC1OZq33e7N6cq4dN0mCv/DLb2ykiAs4UIqMrXrI3ITsXe22T+njeKab0gaR
         BPSwDyJBcITGA1RmukvbQPtSGgFp1tg2f4XqtbDJz2Al3UdsANM+KacZJlmsRfYy7/BS
         xpK/Bqw2UzVs4Gmjti8jwp2gN2nfGSAtAT2gH3LyE0UjsLRu6Fficb+QNob8zpTicix8
         bRjNei4uDAQiHSNa1xNFDLCYuA1TDRcG0NT9WULkyW8GgZs3Aa19uxRcFcnqXkqpq2IV
         GyO59mum9FFJ454jCCv+PdQoi9JtUFVkJTtWLe04MbXWBZagfy4SA8ehemNE87aqxYEK
         IH6Q==
X-Gm-Message-State: AO0yUKXnH+x73drrSgmNCusDigG0/rkng9D+TB1l069Y58LhRNbxEfs9
        n97TuEsLoWHJtoCh+IDdJ4DAxQ==
X-Google-Smtp-Source: AK7set99BARYiABWdxSucm1AIAG1CMIxyxg7JeEMhWzwH/fPGwk27qMXxPmFMvOKuIreidu+KbUQJQ==
X-Received: by 2002:aa7:d14a:0:b0:4bb:f229:9431 with SMTP id r10-20020aa7d14a000000b004bbf2299431mr5712363edo.19.1678952271472;
        Thu, 16 Mar 2023 00:37:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170907985100b009300424a2fdsm760791ejc.144.2023.03.16.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:37:51 -0700 (PDT)
Message-ID: <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
Date:   Thu, 16 Mar 2023 08:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-10-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 reset driver bindings.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> new file mode 100644
> index 000000000000..f66c566c6dce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 Reset Controller
> +
> +maintainers:
> +  - Chi-Fang Li <cfli0@nuvoton.com>
> +  - Jacky Huang <ychuang3@nuvoton.com>
> +
> +description:
> +  The system reset controller can be used to reset various peripheral
> +  controllers in MA35D1 SoC.
> +
> +properties:
> +  compatible:
> +    const: nuvoton,ma35d1-reset
> +
> +  regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the register map node.

You need to be specific what is this. As you can easily check, there is
no such property in any devices. I don't understand why do you need it
in the first place.

> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - regmap
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # system reset controller node:
> +  - |
> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
> +
> +    sys: system-management@40460000 {
> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";

And your patchset is not bisectable.... Test for bisectability before
sending.


Best regards,
Krzysztof

