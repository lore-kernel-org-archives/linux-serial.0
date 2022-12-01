Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E184BC4708C
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 11:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiLALGq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiLALFl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 06:05:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E7AD98D
        for <linux-serial@vger.kernel.org>; Thu,  1 Dec 2022 03:05:08 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g12so1945215lfh.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Dec 2022 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJ+12nfyyTkgnpRxkhSczeW684U0Z3MyPpVBPUH63N4=;
        b=Pq3N/E3XVx4A+B6KaT7zATRc1xex4JEnlIeXASyXQwFiVfrDUYfA3LvfpILF8VzKpV
         nLihd5WxJLL6XeWFqCxhGGtuZCFRsDFq2VYSgQQoWxwZBwtVCHzYqRoLEoVXfBE5pBvW
         iy0kgt5+lptF0dQuw5bvFrVMZVIc+yVF7MLcUz9u/FB7DpoGBFGXGnZQmGv8Exw9Tl83
         H6u0kpC0Bs0Vspxe2O4AedRQhUGkKY4fq6F50gee2r/bUQ7X0kWm4Fle8VZHS4vm8zpk
         B2cYeN9tDPwGNV/gmu3GFRSHSB1EyJo1s6WCJMPwx/MKKAiur1dFrSLa69D5fAL18pAu
         m6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ+12nfyyTkgnpRxkhSczeW684U0Z3MyPpVBPUH63N4=;
        b=k+7KmbkG+TIw/ZCP2TMgzNxj6o8fJPYLTnR3renK4kdk9w6hrN3pN5EdjfbMEy+yea
         Z1hjjG3xXwSmB8pDw9YLP0mc6nC2B6Dfr0EDWyzmV7kxmbkfTCmvQP7WeV02IAmtmjVE
         Rd408h/P2Q4lFdE6n52CeLfMd/h1fp/tJaj3ljevAzdiW1kW6gei+Nh8t9fcwCB3Blpj
         CUFASxHvSPCtWIrnWavzcohZpJ9XT4hFLteCv9IjHjKVhOJA2hLAWdNXRh1yk+4EIyqd
         cyh57cgMQXefBQW2lYO8xL82mlTzQ7S4AS2Or8x5I1d0suw7ko+7P823pQ8F2F2w3mO6
         9THA==
X-Gm-Message-State: ANoB5pnRtCcD6VhYaiHBtlhyckU5V/4SSI4aB3ZVHeDOMsnMcQJy+YRE
        Zp9EjIsP4QWM5NO3xL5LBXf7gQ==
X-Google-Smtp-Source: AA0mqf5bNGiLehJjFTNkoSES7AUznPLQmpDmBmFmia/T8Abr14CJG2m8TfKNIbFLa5VW4x8mY6YbsQ==
X-Received: by 2002:a05:6512:258a:b0:4a2:27f0:46a5 with SMTP id bf10-20020a056512258a00b004a227f046a5mr18154806lfb.611.1669892706811;
        Thu, 01 Dec 2022 03:05:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b00492f0f66956sm611237lfb.284.2022.12.01.03.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:05:06 -0800 (PST)
Message-ID: <60991459-945f-35db-f26a-fb27824728ad@linaro.org>
Date:   Thu, 1 Dec 2022 12:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127132448.4034-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 27/11/2022 14:24, Jisheng Zhang wrote:
> Several SoMs and boards are available that feature the Bouffalolab
> bl808 SoC. Document the compatible strings.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> new file mode 100644
> index 000000000000..91ca9dbdc798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalo Lab Technology SoC-based boards
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +description:
> +  Bouffalo Lab Technology SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Sipeed M1s SoM:
> +        items:
> +          - const: sipeed,m1s
> +          - const: bouffalolab,bl808

I don't think that SoM is usable alone. It always needs a carrier, so
drop this entry.

Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).



Best regards,
Krzysztof

