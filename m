Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C28C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 02:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD5864FD9
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhCJCug (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Mar 2021 21:50:36 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:35963 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhCJCue (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Mar 2021 21:50:34 -0500
Received: by mail-io1-f52.google.com with SMTP id n14so16334709iog.3;
        Tue, 09 Mar 2021 18:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGkhmyvB04/++GcI6nNGGGhJTLlh0dJy/BDKFiCIA44=;
        b=skuOGICKHk9aWyOUoE+fveG1LE7gVP5Q0SF78bTgXylS4Ft6U947Qn+QK7DF4+oa/O
         KyAKrJ0l0UKS1xaLIZdei2z/D1ueAPkOncphSl2OryPvzIYqRsvCALdBcm9II28JbCLY
         UkVudliu/0hAcVRAqy8UnS+Qxu8o3S+Io1iwe0ynwUM9re+Q3bXH9VKw3XCQpz3IegrN
         DdQst39WSSNQLcknrQY52pr7DtqNlsBroGz8HAl/qqF6fjsyOQKYgEklXcB14GJzuTBD
         g2tPJ00vru+75M+xLacCaZBZVyb1aJepW5iFFsIYb4u8ydsTSfwdBIkDGEhSGvAX+oFL
         +6ZQ==
X-Gm-Message-State: AOAM530f+HC9/t+LTJM9J1vR+sl3Qoh/HKIFFSItvNsMDlOM+kQ3wOdL
        C05DfRvC/oVsB7TZNSNJ/g==
X-Google-Smtp-Source: ABdhPJwmlsy2Cjw0y3wmn+ItEQ3eGdZ0VIhmu+UkmB+AUjgJsc1KgVxKNoaMvsyuyx2Kk5n+k7eTew==
X-Received: by 2002:a02:6c8d:: with SMTP id w135mr1144154jab.125.1615344633132;
        Tue, 09 Mar 2021 18:50:33 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g5sm8128792ild.25.2021.03.09.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:50:32 -0800 (PST)
Received: (nullmailer pid 1648376 invoked by uid 1000);
        Wed, 10 Mar 2021 02:50:30 -0000
Date:   Tue, 9 Mar 2021 19:50:30 -0700
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add support for the Broadcom UART
 driver
Message-ID: <20210310025030.GA1645614@robh.at.kernel.org>
References: <20210308170522.4272-1-alcooperx@gmail.com>
 <20210308170522.4272-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308170522.4272-2-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 08, 2021 at 12:05:21PM -0500, Al Cooper wrote:
> Add DT bindings for the Broadcom 8250 based UART driver. This
> UART is based on an 8250 but adds additional functionality. The
> additional features include the ability to use DMA for transfers and
> a baud rate clock system that is more accurate at high baud rates.
> This UART is backward compatible with the standard 8250 UART.

My comments on the previous v4 still apply.

> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  .../bindings/serial/brcm,bcm7271-uart.yaml    | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> new file mode 100644
> index 000000000000..f3d58e613480
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/brcm,bcm7271-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom 8250 based serial port devicetree bindings
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +
> +description: |+
> +  The Broadcom UART is based on the basic 8250 UART but with
> +  enhancements for more accurate high speed baud rates and support
> +  for DMA.
> +
> +properties:
> +  $nodename:
> +    pattern: "^serial@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm7271-uart
> +          - brcm,bcm7278-uart
> +  reg:
> +    minItems: 1
> +    maxItems: 5
> +
> +  reg-names:
> +    description: The UART register block and optionally the DMA register blocks.
> +    oneOf:
> +      - items:
> +          - const: uart
> +      - items:
> +          - const: uart
> +          - const: dma_arb
> +          - const: dma_rx
> +          - const: dma_tx
> +          - const: dma_intr2
> +
> +  clocks:
> +    minItems: 1
> +
> +  clock-names:
> +    const: sw_baud
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description: The UART interrupt and optionally the DMA interrupt.
> +    oneOf:
> +      - items:
> +          - const: uart
> +      - items:
> +          - const: uart
> +          - const: dma
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    serial@840d000 {
> +        compatible = "brcm,bcm7271-uart";
> +        reg = <0x840d000 0x20>;
> +        reg-names = "uart";
> +        interrupts = <0x0 0x62 0x4>;
> +        interrupt-names = "uart";
> +        clocks = <&scmi_clk 190>;
> +        clock-names = "sw_baud";
> +    };
> +
> +    serial@840e000 {
> +        compatible = "brcm,bcm7271-uart";
> +        reg = <0x840e000 0x20>,
> +              <0x840e080 0x8>,
> +              <0x840e100 0xa8>,
> +              <0x840e200 0x4c>,
> +              <0x840e300 0x30>;
> +        reg-names = "uart", "dma_arb", "dma_rx", "dma_tx", "dma_intr2";
> +        interrupts = <0x0 0x62 0x4>, <0x0 0x75 0x4>;
> +        interrupt-names = "uart", "dma";
> +        clocks = <&scmi_clk 190>;
> +        clock-names = "sw_baud";
> +    };
> -- 
> 2.17.1
> 
