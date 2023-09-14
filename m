Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5CEDE980
	for <linux-serial@archiver.kernel.org>; Thu, 14 Sep 2023 05:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjINFy3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Sep 2023 01:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbjINFy3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Sep 2023 01:54:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C57CE
        for <linux-serial@vger.kernel.org>; Wed, 13 Sep 2023 22:54:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso351022f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 13 Sep 2023 22:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694670863; x=1695275663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vont974mPR+vR1R39yYi+/MSVKxLVG/yjvIZF0kTQRc=;
        b=yl2CJ87hp4cn8MtdgQLfoCHnHcykGpuXop7iShtXDX7LhcLlqybZO98Kx/IjGSQAni
         +nC+k0jCfvsFkYLyNAvoMputiAr0cHhLfcE5jyAt56FkSYiSnNONx5RTk0WTbcyxLGHn
         ++axWqnoT2npLOC1EN+nF0XfGI2kUEDd/tdPUxfhD7nYsBBTGYotVeixUUn0B9TDNq7u
         eQyrN08COo63Dobzuqpc981PobbI7/xHNxADPu9DGHKi5qetJrgfiPkadOtkTNkmBDv3
         S8FG36YEjzW8W6PFvP8yMUYb1DCcv9/e7IYGdDkoIV6PEZu+Er9T1u7NOTxWyQ2OlksC
         8bqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670863; x=1695275663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vont974mPR+vR1R39yYi+/MSVKxLVG/yjvIZF0kTQRc=;
        b=pgbv5P2xbDdu5CFRFX/PfU3st1AUs9BYA/ProDfrOxIH7jGfM6SVuPgvIY1q+r1Fa4
         TURSm8DgTdkzj3skGb5AXKWnZHNCuTXOnlso17jv3S1zBaKQyXEsnzaAk4aAnf7NVC/C
         OM4H+xJUsw8XB6+5YkptXvYeox0n3kiTGFi8dZqUc4BMpnX1icBVhlLL3iPYycSBTDkX
         ecVdeQknK7XFzDs/R1sdr/8qry/csAU+h1nkLbupLBr7KFnd3VGW3v6Leru2iTJikiHj
         iheHezYORpptLxsFObnk4BdEzvD3TLsoTY37zWJ1O57pcLvanxOOb0vjgpDsRjDkfoff
         LoMQ==
X-Gm-Message-State: AOJu0YzT8FJkLKjzHOxVrIt/D2haYBdlfJHjqU+xfo1oDarxHBpREgCY
        G6RetGar1YQhRIiffxoEI+lK6g==
X-Google-Smtp-Source: AGHT+IFCo+0UH+egV7WEJxmQZmqKJAcM2k6gd0KiChB1i4jHeNdtLdZ6CD4BZ9jTtvogt60rDLTlgg==
X-Received: by 2002:a5d:4c49:0:b0:31f:c9a4:667b with SMTP id n9-20020a5d4c49000000b0031fc9a4667bmr538888wrt.31.1694670863060;
        Wed, 13 Sep 2023 22:54:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b003142e438e8csm747480wrv.26.2023.09.13.22.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:54:22 -0700 (PDT)
Message-ID: <465dc390-a5ff-547a-2bd3-54b29e1b6c43@linaro.org>
Date:   Thu, 14 Sep 2023 07:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] dt-bindings: serial: document esp32-uart bindings
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-2-jcmvbkbc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913211449.668796-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 13/09/2023 23:14, Max Filippov wrote:
> Add documentation for the ESP32xx UART controllers.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  .../bindings/serial/esp,esp32-uart.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> new file mode 100644
> index 000000000000..8b45ef808107
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/esp,esp32-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESP32 UART controller
> +
> +maintainers:
> +  - Max Filippov <jcmvbkbc@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  ESP32 UART controller is a part of ESP32 SoC series.
> +
> +properties:
> +  compatible:
> +    oneOf:

That's just enum. Your descriptions are useless - tell nothing - so drop
them.

> +      - description: UART controller for the ESP32 SoC
> +        const: esp,esp32-uart

Looks quite generic, so just to be sure? This is not a family name,
right? Neither family names nor wildcards are allowed.

> +      - description: UART controller for the ESP32S3 SoC
> +        const: esp,esp32s3-uart
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
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    serial0: serial@60000000 {

Drop unused label.

> +            compatible = "esp,esp32s3-uart";

Use 4 spaces for example indentation.

> +            reg = <0x60000000 0x80>;
> +            interrupts = <27 1 0>;

Use proper define for IRQ flags.

> +            clocks = <&serial_clk>;
> +    };

Best regards,
Krzysztof

