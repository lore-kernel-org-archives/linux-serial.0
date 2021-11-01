Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A36C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C24260FC4
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 19:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhKAThU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:37:20 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:46687 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKAThT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 15:37:19 -0400
Received: by mail-oi1-f176.google.com with SMTP id bd30so6738694oib.13;
        Mon, 01 Nov 2021 12:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/CLSb5CgKegFKHKytZg90KV98ydhoqUrhMNoJ+i398=;
        b=N498Z2t9QQrVNDMC0tmGoJy9Ggo/Wz1UGzGeguFjVlXcXoIbw8YbXKVs+h0nHI5LJC
         YulliP8OcqowMDVi9+g/yjJwvLHaFwxREcFMbD+atDsV1FEjjHZYI4A3pq9KjPKazPBn
         /6A2/YkIrVUZolG9o4UCtCO7/7V3qE8h3Lfxe2Y1ftpbXDqESw9nGs7qARGoxdUurwt6
         gFTh9Vhv0kmbQ1B5wZKUAfNg8J8vbMKGaSOU6LhFm8c6ecnJHAsVhMhZNCKoRORQo/qv
         SDkc53wJ6mhQMMaLNoodaVHCf1BnCiIvvHSgGYbfFn5FoE4YESePvrAGEZYKd5ugz9OP
         Qamg==
X-Gm-Message-State: AOAM532y8sxVfVmEuaWpsOhNYfqIzRvhgwyUip5ZSA4SdVHZZeyvDRVl
        vqRrhulcPOQDhaCNluiJZQ==
X-Google-Smtp-Source: ABdhPJzbCROu1FfrFNPXsvUcRW58+bChO2LWQzwVSOf9yxQCXbghbysMFMwpm8AfjfwJc1+3boyGHw==
X-Received: by 2002:aca:bec1:: with SMTP id o184mr817398oif.43.1635795285218;
        Mon, 01 Nov 2021 12:34:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g17sm4392898otq.17.2021.11.01.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:34:44 -0700 (PDT)
Received: (nullmailer pid 889789 invoked by uid 1000);
        Mon, 01 Nov 2021 19:34:43 -0000
Date:   Mon, 1 Nov 2021 14:34:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     "hammer.hsieh" <hammerh0314@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de,
        tony.huang@sunplus.com, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH 1/2] dt-bindings:serial:Add bindings doc for Sunplus SoC
 UART Driver
Message-ID: <YYBBU+EPkheiUMuH@robh.at.kernel.org>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
 <1635752903-14968-2-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635752903-14968-2-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 01, 2021 at 03:48:22PM +0800, hammer.hsieh wrote:
> Add bindings doc for Sunplus SoC UART Driver
> 
> Signed-off-by: hammer.hsieh <hammer.hsieh@sunplus.com>
> ---
>  .../devicetree/bindings/serial/sunplus,uart.yaml   | 116 +++++++++++++++++++++
>  MAINTAINERS                                        |   5 +
>  2 files changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sunplus,uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,uart.yaml
> new file mode 100644
> index 0000000..f2ca9ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sunplus,uart.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/sunplus,uart.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Sunplus SoC UART Controller Device Tree Bindings
> +
> +maintainers:
> +  - Tony Huang <tony.huang@sunplus.com>
> +  - Hammer Hsieh <hammer.hsieh@sunplus.com>
> +  - Wells Lu <wells.lu@sunplus.com>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-uart
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +        - const: UADMA
> +        - const: PERI0
> +      - items:
> +        - const: UADMA
> +        - const: PERI1

These 2 can be:

items:
  - const UADMA
  - pattern: '^PERI[0-1]$'

But why the difference for only one model of UART? The names should 
reflect the function of the clock. 

> +      - items:
> +        - const: HWUA
> +        - const: PERI0
> +      - items:
> +        - const: HWUA
> +        - const: PERI1
> +
> +  resets:
> +    maxItems: 1
> +
> +  which-uart:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 3, 4]

What's this for? Looks like an index and we don't do indices in DT. 
There is 'aliases' though.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +    aliases {
> +            serial0 = &uart0;
> +            serial1 = &uart1;
> +            serial10 = &uartdmarx0;
> +            serial20 = &uartdmatx0;
> +    };
> +
> +    uart0: serial@9c000900 {
> +      compatible = "sunplus,sp7021-uart";
> +      reg = <0x9c000900 0x80>;
> +      interrupt-parent = <&intc>;
> +      interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&clkc UA0>;

The schema says you must have 2 clocks.

> +      resets = <&rstc RST_UA0>;
> +    };
> +
> +    // UART1 PIO mode
> +    uart1: serial@9c000980 {
> +        compatible = "sunplus,sp7021-uart";
> +        reg = <0x9c000980 0x80>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc UA1>;
> +        resets = <&rstc RST_UA1>;
> +    };
> +
> +    // UART1 DMA mode for RX
> +    uartdmarx0: serial@9c008980 {
> +        compatible = "sunplus,sp7021-uart";
> +        reg = <0x9c008980 0x40>;
> +        interrupt-parent = <&intc>;
> +        interrupts = <138 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc UADMA>, <&clkc PERI0>;
> +        clock-names = "UADMA", "PERI0";
> +        resets = <&rstc RST_UADMA>;
> +        which-uart = <1>;
> +    };
> +
> +    // UART1 DMA mode for TX
> +    uartdmatx0: serial@9c008a00 {
> +        compatible = "sunplus,sp7021-uart";
> +        reg = <0x9c008a00 0x40>, <0x9c008880 0x80>;
> +        clocks = <&clkc HWUA>, <&clkc PERI0>;
> +        clock-names = "HWUA", "PERI0";
> +        resets = <&rstc RST_HWUA>;
> +        which-uart = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..f863e97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17945,6 +17945,11 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/dlink/sundance.c
>  
> +SUNPLUS UART DRIVER
> +M:	Hammer Hsieh <hammer.hsieh@sunplus.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/serial/sunplus,uart.yaml
> +
>  SUPERH
>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:	Rich Felker <dalias@libc.org>
> -- 
> 2.7.4
> 
> 
