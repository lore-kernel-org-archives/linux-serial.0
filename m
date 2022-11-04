Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198BFC433FE
	for <linux-serial@archiver.kernel.org>; Fri,  4 Nov 2022 14:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiKDO21 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiKDO1y (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Nov 2022 10:27:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCB31EE1
        for <linux-serial@vger.kernel.org>; Fri,  4 Nov 2022 07:25:44 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i9so3109044qki.10
        for <linux-serial@vger.kernel.org>; Fri, 04 Nov 2022 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sD8EciRvb46rdf2K+kL45tZIE2mUCgw2o7OORvwigA=;
        b=lyVoSJjJdrYXF7iBhSXbA2hQWrHZBCsUHunCw2aZE9p4yHHID2AdHsUpJqBGMyR6Bz
         CUWJwUfAfeoJpammVHa8axjeWM++BWimWDMx4ePwliO4qwh5r3MC3hlLB6Qg+dVCxl0x
         GTprG77sDlWGUXDm2Qt3ajk+AAOhWUTkdCqIDVmBxwf/s3DkuxUtDb4qV5CZ7Itu/yXl
         ukbJxVl4WYS0WVXV3ShiVHJW1f97HcR1mCiwYP8KbMHLDnP4/tr/EqjbKVp99rFPsAUD
         zRZJy9kLLYF2mCb0bwq9H8hm/9wpPXICI1aGb8YSnnU838dZZGOGiibNlB0u2MEere6U
         ZsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sD8EciRvb46rdf2K+kL45tZIE2mUCgw2o7OORvwigA=;
        b=Pix3rUN1S1O2FjpMVq8BtVXRsg/JeaPFDMcr8xaeQCw6Yx8UP1tTGICW/4wynsLg2A
         1VECOMPrZ1msK8rJMD/41DclNFkKbDG+ckiciI6LTImqq7Q0XkGbCRm9T3/crAFZy1KZ
         GB6FLyDLSuptDl9ZPv3PYRAjznjOa2EpoWC9IQBrsxrMMOV0uElUt5eKhveSRwQpXikO
         c3l5ZXrV24nxJbB//HLxQvRV5PdfAzxp6ET/J8Y1U3JLnJUDTb8hLpRinYF24xbcz2iW
         /IkNq5pV63gOF0amql/AvNlx4M4olyHpDCdiqRUCILOGNrL2xm1cNfoUp0hFqBKyLrCq
         dytg==
X-Gm-Message-State: ACrzQf1FBT3/32SJLqhTzpPJDywyGJbFwGeYGVu/TDT0idqt8KrP9M3Q
        n+QtLN5GgNMaOH40AhVg/p5Keiz7hHFVpA==
X-Google-Smtp-Source: AMsMyM5yd4v4Lf5ChlcAa3i9aOx0jZgX3ZtOSNqQoEiBB2464wyApfZu45Vmm9dPLD61sWqFzgV1zg==
X-Received: by 2002:a05:620a:cec:b0:6fa:a3d:dda5 with SMTP id c12-20020a05620a0cec00b006fa0a3ddda5mr26567414qkj.564.1667571943916;
        Fri, 04 Nov 2022 07:25:43 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id k7-20020ac84747000000b003a4f22c6507sm2508637qtp.48.2022.11.04.07.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:25:43 -0700 (PDT)
Message-ID: <0f97ef6c-234e-d677-75ba-11b22586c95e@linaro.org>
Date:   Fri, 4 Nov 2022 10:25:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: serial: arm,sbsa-uart: Convert to
 json-schema
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221104104303.1534876-1-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104104303.1534876-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 04/11/2022 06:43, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the ARM SBSA UART device tree bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/serial/arm,sbsa-uart.yaml        | 37 +++++++++++++++++++
>  .../bindings/serial/arm_sbsa_uart.txt         | 10 -----
>  2 files changed, 37 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> new file mode 100644
> index 000000000000..afaa1ef7f2e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/arm,sbsa-uart.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/arm,sbsa-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM SBSA defined generic UART
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This shouldn't be Greg but someone nothing the hardware. Rob might work,
but maybe also Russell who is mentioned in maintainers entry?

Please resend with him cced.

> +
> +description:
> +  This UART uses a subset of the PL011 registers and consequently lives
> +  in the PL011 driver. It's baudrate and other communication parameters
> +  cannot be adjusted at runtime, so it lacks a clock specifier here.
> +
> +properties:
> +  compatible:
> +    const: arm,sbsa-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +allOf:
> +  - $ref: serial.yaml
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +...

Example would be nice, although it  is not a requirement.


Best regards,
Krzysztof

