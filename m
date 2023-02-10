Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA67C6379F
	for <linux-serial@archiver.kernel.org>; Fri, 10 Feb 2023 09:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBJJMi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Feb 2023 04:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBJJMh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Feb 2023 04:12:37 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A634037723
        for <linux-serial@vger.kernel.org>; Fri, 10 Feb 2023 01:12:34 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so4326653wrg.13
        for <linux-serial@vger.kernel.org>; Fri, 10 Feb 2023 01:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mL4KyztuyODt2VU+CZBnxvtMdXCFPb2+6mKlAc4eZC8=;
        b=S20XtXRxLi9OLqhtFW8XCPtwUd+Rl4Faq9mS8wjYKBgh31Pnoh3OfEhL9S/ERdUNNQ
         yLlBtKlU6rhe6r+TrlYMC8QfO588W2aP63SV3Z+WAEzAK1C4urenJDD5KiVvg2daSj1t
         cwjThEK4YvPEY8SK7FdBXltg2tqfL0GZHLuUYa2XsSJHZDEFamzxlzsYXPTVrrsCrIvl
         vGgSY5ucvFQK2Mus3hGr7HtbQDicLcI7ubQJsA5SSPrJUPn3eTl32eZZkcmOfL/i7Bon
         DcK0i3RSGKJk29gnQf2yHapwDWHj28CKZmpy1cYTYOEZBYBREB7nCijj1gheA1xBn8vG
         h3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL4KyztuyODt2VU+CZBnxvtMdXCFPb2+6mKlAc4eZC8=;
        b=i+qYE5YzfSkM8j6jrfAn/3lO3SxvaTyOiYcI9g2Z5My4QEtb7bh/9XwhWahJwMnVhW
         H2DLL4yDiiL3p1pIptsYcrMPtqeCUZbgcibcu1qsc7B3NLymuqQXpTUla8Rx5M727tnJ
         5kIyl7hPzGyyucwO2FiXUAIS0120OynpNs8fmGXMmlouMKuL66IyIXvJb1ExCf/XwGkm
         VvlqONVLxdEJ5Uw5Em+1TF0HcS50YIHLfkBCkaX0/RKCWAGmcrQTpUILQ1cpz5Zkprdn
         QxR2ml2H8yW7wLrEUqvjlxQwpjSwvi+yL2cPcxqzQgzIQ6PBZei8TxZNcu21LkIj+6eh
         8fOg==
X-Gm-Message-State: AO0yUKWVntCIckV63sj+IlK1YFVgiSVK5uDbR6gXJebtDr7wlBh2DW5F
        gxj5SiDbuCiiBm2VMidlJ+bDXQ==
X-Google-Smtp-Source: AK7set+2hQaPKBxAjcdrkUNWE2GxbNQBY+5ujjxLnyWUu6HynLLF+1AwbHMoQHYvLNkJGD0AWK7PKw==
X-Received: by 2002:adf:e946:0:b0:2c4:83e:2784 with SMTP id m6-20020adfe946000000b002c4083e2784mr6068680wrn.63.1676020353212;
        Fri, 10 Feb 2023 01:12:33 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b002bfc0558ecdsm3065098wrp.113.2023.02.10.01.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 01:12:32 -0800 (PST)
Message-ID: <2d0d1866-95f9-942d-57e0-06a5ed17d35d@linaro.org>
Date:   Fri, 10 Feb 2023 10:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: aspeed: Add UART controller
Content-Language: en-US
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210072643.2772-2-chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10/02/2023 08:26, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed UART controller.

Describe the hardware. What's the difference against existing Aspeed
UART used everywhere?

> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../bindings/serial/aspeed,uart.yaml          | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/aspeed,uart.yaml

Filename: aspeed,ast2600-uart.yaml
(unless you are adding here more compatibles, but your const suggests
that it's not going to happen)

> 
> diff --git a/Documentation/devicetree/bindings/serial/aspeed,uart.yaml b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
> new file mode 100644
> index 000000000000..10c457d6a72e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/aspeed,uart.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/aspeed,uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Universal Asynchronous Receiver/Transmitter

This title matches other Aspeed UARTs, so aren't you duplicating bindings?

> +
> +maintainers:
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +description: |
> +  The Aspeed UART is based on the basic 8250 UART and compatible
> +  with 16550A, with support for DMA
> +
> +properties:
> +  compatible:
> +    const: aspeed,ast2600-uart
> +
> +  reg:
> +    description: The base address of the UART register bank

Drop description

> +    maxItems: 1
> +
> +  clocks:
> +    description: The clock the baudrate is derived from
> +    maxItems: 1
> +
> +  interrupts:
> +    description: The IRQ number of the device

Drop description

> +    maxItems: 1
> +
> +  dma-mode:
> +    type: boolean
> +    description: Enable DMA

Drop property. DMA is enabled on presence of dmas.

> +
> +  dma-channel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The channel number to be used in the DMA engine

That's not a correct DMA property. dmas and dma-names
git grep dma -- Documentation/devicetree/bindings/


> +
> +  virtual:
> +    type: boolean
> +    description: Indicate virtual UART

Virtual means not existing in real world? We do not describe in DTS
non-existing devices. Drop entire property.

> +
> +  sirq:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The serial IRQ number on LPC bus interface

Drop entire property.

> +
> +  sirq-polarity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The serial IRQ polarity on LPC bus interface

Drop entire property.

> +
> +  pinctrl-0: true
> +
> +  pinctrl_names:
> +    const: default


Drop both, you do no not need them.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +

Best regards,
Krzysztof

