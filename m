Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EBBC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 24 Aug 2021 14:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21E961163
	for <linux-serial@archiver.kernel.org>; Tue, 24 Aug 2021 14:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhHXO2l (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:28:41 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38887 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhHXO2k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Aug 2021 10:28:40 -0400
Received: by mail-ot1-f48.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso35288948ots.5;
        Tue, 24 Aug 2021 07:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Nb+8b7sSd8DLl7W6dDpH/W4tZiNwLlo8PJewGNallnc=;
        b=SeheYcQfW6gkNJc0kPesUgjx5uCOQlabZ6HHcXGRvCcR0MJdVyymW6pJ1/Y5yc5PXF
         gp8V9mbDxHZ1RUi2tEryBzrLkGAl6OFPg1WdGHkSYBF3t3qAISrT1NQ0mz+hUVgJH06V
         NMN2hSMyIagB+nm9TvpttEP1PLGw1dOzRFIJNAXMFi8f/nkg3OBYsj3QRZEkA06fho5f
         VDptfh8M3cNHvM57rOU7bwJIzEr2/ZCiszNrS0cBHPtu+NP3dwXH+cckOnR1NtB0ZPm+
         Jwd+oqhOgRLC/MvCRfIIyfdXcXDlB7UDjQGob15o1FcyHDL+Ciz2Zujqsd2oDNP3+wAM
         2pfA==
X-Gm-Message-State: AOAM530X6oLA29RzmIeIgNKgBoi3em7hz9a3GbrbRdhZjxZSKKI26KBa
        L5WUw23VQn2y+4epy7peqg==
X-Google-Smtp-Source: ABdhPJzR178d7Yu+gOhF1hpzef9SkuG5gyZGtS8YWXdxG+WfUBRoOM907Ov0YHXUEte5ai9XJH4wfw==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr23525649otr.315.1629815276317;
        Tue, 24 Aug 2021 07:27:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q7sm1329066otl.68.2021.08.24.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:27:55 -0700 (PDT)
Received: (nullmailer pid 389410 invoked by uid 1000);
        Tue, 24 Aug 2021 14:27:54 -0000
Date:   Tue, 24 Aug 2021 09:27:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: serial: brcm,bcm6345-uart: convert to the
 json-schema
Message-ID: <YSUB6v84Ds+SisgY@robh.at.kernel.org>
References: <20210819134859.19537-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819134859.19537-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 19, 2021 at 03:48:59PM +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> In example periph_clk@0 was replaced with periph_clk to fix validation.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I've verified this binding using the
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
> ---
>  .../bindings/serial/brcm,bcm6345-uart.txt     | 36 ------------
>  .../bindings/serial/brcm,bcm6345-uart.yaml    | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> deleted file mode 100644
> index 8b2b0460259a..000000000000
> --- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -* BCM63xx UART
> -
> -Required properties:
> -
> -- compatible: "brcm,bcm6345-uart"
> -
> -- reg: The base address of the UART register bank.
> -
> -- interrupts: A single interrupt specifier.
> -
> -- clocks: Clock driving the hardware; used to figure out the baud rate
> -  divisor.
> -
> -
> -Optional properties:
> -
> -- clock-names: Should be "refclk".
> -
> -Example:
> -
> -	uart0: serial@14e00520 {
> -		compatible = "brcm,bcm6345-uart";
> -		reg = <0x14e00520 0x18>;
> -		interrupt-parent = <&periph_intc>;
> -		interrupts = <2>;
> -		clocks = <&periph_clk>;
> -		clock-names = "refclk";
> -	};
> -
> -	clocks {
> -		periph_clk: periph_clk@0 {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <54000000>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
> new file mode 100644
> index 000000000000..0d4d03fc58ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/brcm,bcm6345-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BCM63xx UART
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6345-uart
> +
> +  reg:
> +    maxItems: 1
> +    description: The base address of the UART register bank

Drop. Don't need generic descriptions.

> +
> +  interrupts:
> +    description: A single interrupt specifier

Replace with 'maxItems: 1'

> +
> +  clocks:
> +    description: >
> +      Clock driving the hardware; used to figure out the baud rate divisor

Replace with 'maxItems: 1'

> +
> +  clock-names:
> +    const: refclk
> +
> +unevaluatedProperties: false
> +
> +required:
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    serial@14e00520 {
> +        compatible = "brcm,bcm6345-uart";
> +        reg = <0x14e00520 0x18>;
> +        interrupt-parent = <&periph_intc>;
> +        interrupts = <2>;
> +        clocks = <&periph_clk>;
> +        clock-names = "refclk";
> +    };
> +
> +    clocks {
> +        periph_clk: periph_clk {
> +            compatible = "fixed-clock";
> +            #clock-cells = <0>;
> +            clock-frequency = <54000000>;
> +        };

You don't need to show the clock provider (or any other) in examples.

> +    };
> -- 
> 2.26.2
> 
> 
