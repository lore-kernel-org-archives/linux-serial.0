Return-Path: <SRS0=s89U=ID=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1485C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 23:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949AD650A1
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 23:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhCEXOl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:14:41 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39409 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCEXOl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 18:14:41 -0500
Received: by mail-ot1-f42.google.com with SMTP id h22so3423658otr.6;
        Fri, 05 Mar 2021 15:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5nXz+NHeNvgfQP7Thr5OxhfCzkTfrNsANsOPr8cVUT0=;
        b=JNufiOxKrYrJtergWoICzH2bJJpavcYrSfBueCtSZxMP8PNNXTlCukW6GFsZj8B+x0
         5mZ/moATlBvowr4nQj3voRucmZORRDq7l2VDcYhWXuQySyaS6rN/4ILju74myMZpSabk
         sz5fCcV0H1lPzCajhnvwYdv4i24ibtF2yJChiR6d3HtFdyVSZbFozp/fSS8Iu8swgAmS
         Q0n7KC/VzORg7uoVrkQQ/ptkVmIUbBRQr4Uv2kdq1tzamQawQ8uDIEBjB1ryt5/M5B5R
         wJ4E+vr6dEBvT2nLh5vXB/AoZJUX8d55T+jugRHRf0ma150qejqH+tIJj+seys24yNGe
         23wg==
X-Gm-Message-State: AOAM533V/Lm3T//9au+cH/6TfpyLDydcRHXry+wG+gqBV3ZuqNXJ0LNK
        3aQqGJnzbUUEwvWiW1CFmw==
X-Google-Smtp-Source: ABdhPJyfbgPitOj8ncVestAxDYpBaKWyTKEtfDYwnWakIsyGPzKPUXorveqf8hsf/u+CHRZE0EMT4w==
X-Received: by 2002:a05:6830:13c1:: with SMTP id e1mr9788567otq.310.1614986080859;
        Fri, 05 Mar 2021 15:14:40 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k68sm895763otk.28.2021.03.05.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:14:39 -0800 (PST)
Received: (nullmailer pid 819644 invoked by uid 1000);
        Fri, 05 Mar 2021 23:14:37 -0000
Date:   Fri, 5 Mar 2021 17:14:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add support for the Broadcom UART
 driver
Message-ID: <20210305231437.GA814293@robh.at.kernel.org>
References: <20210219203708.49056-1-alcooperx@gmail.com>
 <20210219203708.49056-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219203708.49056-2-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 19, 2021 at 03:37:07PM -0500, Al Cooper wrote:
> Add DT bindings for the Broadcom 8250 based UART driver. This
> UART is based on an 8250 but adds additional functionality. The
> additional features include the ability to use DMA for transfers and
> a baud rate clock system that is more accurate at high baud rates.
> This UART is backward compatible with the standard 8250 UART.
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

Reference serial.yaml and you can drop this (and have slave devices).

You'll need to use 'unevaluatedProperties' instead of 
'additionalProperties' as well.

> +
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm7271-uart
> +          - brcm,bcm7278-uart

Blank line.

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

Drop the oneOf and add 'minItems: 1'.

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
