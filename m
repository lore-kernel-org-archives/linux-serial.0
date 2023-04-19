Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB4C77B73
	for <linux-serial@archiver.kernel.org>; Wed, 19 Apr 2023 08:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjDSIqt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjDSIqr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Apr 2023 04:46:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7528C17B
        for <linux-serial@vger.kernel.org>; Wed, 19 Apr 2023 01:46:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ud9so79440586ejc.7
        for <linux-serial@vger.kernel.org>; Wed, 19 Apr 2023 01:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893997; x=1684485997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Qlld2XzCVc9i+xQE2LggHCC3Vx3E3mH6+jFp7qQ9zM=;
        b=MduE4DHJYpYX+4Z6wgZ3OC+ZDMyRLERM8BiJKfNWT9m++IVpL9Yc9EYhsCO1GsxAvE
         s+JY7chVmt2eSmGliP6EJOt7x6eTq3f+K+RVcztMzx5AP76uAovJu/0uy/RbJrGXTUKz
         Y8/t376OT2br4IWEycIIzYKo9Q4V8+t/6LZ5AraS/3OXPa9zZbLC0sig0VZPrETv2Ss+
         zVhggOZVv81Svmej57j0HwptfjUkSTse9gIEYiDm6/YEhKCCTpqPREILsRuc0r5p39nq
         hJooQISbvzJsD6bF3wAPxD8H976HWt7EoxKnnGrN+NtMj3EmQONubbSshTEJh22GBuyz
         zdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893997; x=1684485997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qlld2XzCVc9i+xQE2LggHCC3Vx3E3mH6+jFp7qQ9zM=;
        b=VpsuNfyWgordOZ4DzBb1ggVrJ8VcVTJLv7KRme10VNySAFrMsUcUUeI98LKxsDrErC
         8DeCCwm2HvS+iN0ecWZqY9QwbYLkuoMe/16+DWP56MSxBhPfNtUp+hBQ4s/9qIW2Efcn
         RVo7ITKDPq+RHc5hTP/Dc17LL7JP+tEqf5cflJ6z0TOj3570XWo0XMc3cw1iwYvpaNcU
         edgAC/TUGwGmuOnsBaV7m/hYdDFQkNuAQhULZfidAo4bcfy6yPLW8THQuDEulSAKKj9V
         iG/BQfK/N3pV+rIshlFfUeSjtHwb6NpPeCie19j00TyuP5C9JDZlXApggEXqcA8TmI99
         6KVQ==
X-Gm-Message-State: AAQBX9fFaK3cF3GXsQe3VKQSM6qabGZHs5QZNNgybWWZWzmBu5NPSynI
        /nZI7oZPCEGaCVXNbBFhfg+kfg==
X-Google-Smtp-Source: AKy350a3ad4rvpuXlGu5kLo02wt9E68lw9Fg1s5V7be19/JE7DHuyesuKe2dSzP8ohc25nQ1DxZMWQ==
X-Received: by 2002:a17:906:5255:b0:94a:5a9e:9da0 with SMTP id y21-20020a170906525500b0094a5a9e9da0mr12067444ejm.77.1681893994109;
        Wed, 19 Apr 2023 01:46:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090603c100b00882f9130eafsm8961438eja.26.2023.04.19.01.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:46:33 -0700 (PDT)
Message-ID: <a663a061-f882-ec37-013f-90c5cb0181ea@linaro.org>
Date:   Wed, 19 Apr 2023 10:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 tty-next 1/2] dt-bindings: serial: ni,ni16650: add
 bindings
Content-Language: en-US
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230410211152.94332-1-brenda.streiff@ni.com>
 <20230418223800.284601-1-brenda.streiff@ni.com>
 <20230418223800.284601-2-brenda.streiff@ni.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418223800.284601-2-brenda.streiff@ni.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 19/04/2023 00:37, Brenda Streiff wrote:
> Add bindings for the NI 16550 UART.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>
> ---
>  .../bindings/serial/ni,ni16550.yaml           | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/ni,ni16550.yaml b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> new file mode 100644
> index 000000000000..93b88c8206b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/ni,ni16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NI 16550 asynchronous serial interface (UART)
> +
> +maintainers:
> +  - Brenda Streiff <brenda.streiff@ni.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: ni,ni16550
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
> +  clock-names:
> +    items:
> +      - const: baudclk

No need for names for one clock entry.

> +
> +  # legacy clock property; prefer 'clocks' instead
> +  clock-frequency: true

Drop it, we do not want legacy or deprecated properties on new bindings.
It's not a legacy binding...

> +
> +  ni,serial-port-mode:
> +    description: Indicates whether this is an RS-232 or RS-485 serial port.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ RS-232, RS-485 ]
> +    default: RS-485
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    serial@80000000 {
> +      compatible = "ni,ni16550";
> +      reg = <0x80000000 0x8>;
> +      interrupts = <0 30 4>;

I still wonder what are these. Flags? Then use common defines.

> +      clock-names = "baudclk";
> +      clocks = <&clk_uart>;
> +      ni,serial-port-mode = "RS-232";
> +    };
> +
> +    clk_uart: clock {

Drop node, not related to your code. You are not documenting usage of
fixed-clock as it is obvious and already documented in other place.


Best regards,
Krzysztof

