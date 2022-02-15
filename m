Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DFDC4332F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Feb 2022 14:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiBOOyP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Feb 2022 09:54:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbiBOOyJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Feb 2022 09:54:09 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835CAF1E8
        for <linux-serial@vger.kernel.org>; Tue, 15 Feb 2022 06:53:56 -0800 (PST)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 315E240334
        for <linux-serial@vger.kernel.org>; Tue, 15 Feb 2022 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644936829;
        bh=nPMJHTnYZbzS8znk5AsEiCmewu+zF2DU271/1BBA6Eo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=pgRbLzC7Vma+2T8v8tH4OvJds0ho/7egymd3saiOKXwwXSX61jtQweMxveFjob4dv
         kh3XAf7kP6zlVfNIVT23jwUnu08ia97GcUtVWdCnH4sP1WNHqV7vWZ+F5c54nGcQBI
         z2HmQgeJNv1KDHqWGlgk6DqqjSXYERtHaIdJh6mN5yJdoKg4+jqMMgeE/suR817taD
         drevrlMBF9I0Ax918bdQdeyjn7q0zLSeLlJnt+q6+vRbtp638nxKnzV2TUXAdATGtu
         q2TB8+9u0kKc6UAzicSq+nTG9vfktlSVikLjOO99BlOtEiBevb1H5Qxc7VrSl6NLq9
         sCYXp0T/AxVGw==
Received: by mail-wr1-f71.google.com with SMTP id i10-20020adfaaca000000b001e4b2db0303so6484850wrc.23
        for <linux-serial@vger.kernel.org>; Tue, 15 Feb 2022 06:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nPMJHTnYZbzS8znk5AsEiCmewu+zF2DU271/1BBA6Eo=;
        b=fYg6TXnH+1q8IEZA+rEbukxIxLv1Wvx8tkVlqS5/s7BwDqzh5lICRTmvC6y9tzP8zc
         rqWg8wMhQVPYb03W7CQDrodjw4ixhaDrc1sLNGbgvVxblqvro/e23H64fQOFcKTJhmjy
         9IsW3NKEqRGLnUIF9rBiBYzuKhkjuy/jrYLpt2aGDti3FsFAOnBMKuomiLes7Z7hktq9
         mSQp1E1LbGVgXwoEQZwHhXhiJjQp+9f+dw9NS8fbgLblZ7o6vf1vo0bnHw/NWaczapxb
         FPxCMnD9F66C2XoFRH9emetU1Vl3Cgk1CDw+HwUkigK7UBQ4hd21GG3zokjsrd24jE3o
         cvBg==
X-Gm-Message-State: AOAM532NhX5wKVEF2iJzuvWgo7RO+WAF5JRL6aTGTX1qvvnmA7r5NQ9u
        UZZNt8QL0gviL5mt+LrCojidWMwps6Aq8iFm6/Nz8ke14oMzkZM3MlrjdDIZ2OQQxwGJ0o1Jjna
        T3pPGi5Th2Rmpw/ufVpdmKUkgEKZd35q+sETFRpvzUw==
X-Received: by 2002:a05:600c:34c4:b0:37b:f84d:d55a with SMTP id d4-20020a05600c34c400b0037bf84dd55amr3308656wmq.123.1644936828656;
        Tue, 15 Feb 2022 06:53:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwon3JF6xxLKESk658q0+LTv95ZfTFy8vR9jXtExV/jZEWdqZ1UK6aKau2J/Bpu24pZQ9e+pQ==
X-Received: by 2002:a05:600c:34c4:b0:37b:f84d:d55a with SMTP id d4-20020a05600c34c400b0037bf84dd55amr3308637wmq.123.1644936828425;
        Tue, 15 Feb 2022 06:53:48 -0800 (PST)
Received: from [192.168.0.108] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r2sm19588933wmq.24.2022.02.15.06.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:53:48 -0800 (PST)
Message-ID: <b50bf9ef-eb38-8e86-70f9-7a9a959be67b@canonical.com>
Date:   Tue, 15 Feb 2022 15:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8 1/2] dt-bindings:serial:Add bindings doc for Sunplus
 SoC UART Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com
References: <1644917065-23168-1-git-send-email-hammerh0314@gmail.com>
 <1644917065-23168-2-git-send-email-hammerh0314@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1644917065-23168-2-git-send-email-hammerh0314@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 15/02/2022 10:24, Hammer Hsieh wrote:
> Add bindings doc for Sunplus SoC UART Driver
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
> ---
> Changes in v8:
>  - no change.
> 
>  .../bindings/serial/sunplus,sp7021-uart.yaml       | 56 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> new file mode 100644
> index 0000000..894324c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/sunplus,sp7021-uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Sunplus SoC SP7021 UART Controller Device Tree Bindings
> +
> +maintainers:
> +  - Hammer Hsieh <hammerh0314@gmail.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    aliases {
> +            serial0 = &uart0;

Incorrect indentation. With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
