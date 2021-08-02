Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99781C4320A
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 20:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ECE60F93
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 20:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhHBU6E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:58:04 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:37667 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhHBU6E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Aug 2021 16:58:04 -0400
Received: by mail-io1-f48.google.com with SMTP id r18so21915937iot.4;
        Mon, 02 Aug 2021 13:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hv9R9uX/9Exwcr0vk3gW4fJPMgYHDULDKeCFcu/R1KM=;
        b=kmU9Tc9voZMV3VoO2dAN86grqQi/SedWcrUfCSnmJFp+hR/5a1RMZqyOKIY8UbDbW8
         Nyk4zk44bGEkcVC/Pxm8YVkxr49ATmiicdp41sV8scYJBN4btKQrsxaSoVWL26J2Y+ac
         pK/wX3bdkx/YzKdUiHt6m0Mg2AceT5M2FpgXnyMyrf5+Xu/UekEtgGcaGpJy/des4xEe
         r+N+ETFhdHmRl0sHjxMrkNx/j1qYIgX3vidJIukncVSxcxji4LpGMO4yNpjcv9oliD2R
         QM+A1XzALpaqqJY/cppXFdFCzBeF18XBZCbvdWSYnv7WyQIXFplFaV76j6LjPNiJnmQs
         /LZw==
X-Gm-Message-State: AOAM5304z/MudEIWln5LDB8ifRjgoEENT3G3hNfq150P5fCAckD362vL
        g85I757WQNdCUpU8t+fPnwahKNBXMA==
X-Google-Smtp-Source: ABdhPJzixwLjci4+iW7Ky6PRSd/rUvs5wjNDYhhd29hWdI5dE8PIPAqhPrVTQtWnhpRdzTVupn7DFw==
X-Received: by 2002:a02:ca19:: with SMTP id i25mr16481252jak.78.1627937873930;
        Mon, 02 Aug 2021 13:57:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o13sm6285739ilq.58.2021.08.02.13.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:57:52 -0700 (PDT)
Received: (nullmailer pid 1597856 invoked by uid 1000);
        Mon, 02 Aug 2021 20:57:50 -0000
Date:   Mon, 2 Aug 2021 14:57:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: serial: uartlite: Convert to
 json-schema
Message-ID: <YQhcTmq9NIiOkaMS@robh.at.kernel.org>
References: <20210727221740.1997731-1-sean.anderson@seco.com>
 <20210727221740.1997731-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727221740.1997731-2-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 27, 2021 at 06:17:37PM -0400, Sean Anderson wrote:
> This converts the existing documentation for the uartlite binding to
> json-schema.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> (no changes since v1)
> 
>  .../bindings/serial/xlnx,opb-uartlite.txt     | 23 --------
>  .../bindings/serial/xlnx,opb-uartlite.yaml    | 53 +++++++++++++++++++
>  2 files changed, 53 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
> deleted file mode 100644
> index c37deb44dead..000000000000
> --- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -Xilinx Axi Uartlite controller Device Tree Bindings
> ----------------------------------------------------------
> -
> -Required properties:
> -- compatible		: Can be either of
> -				"xlnx,xps-uartlite-1.00.a"
> -				"xlnx,opb-uartlite-1.00.b"
> -- reg			: Physical base address and size of the Axi Uartlite
> -			  registers map.
> -- interrupts		: Should contain the UART controller interrupt.
> -
> -Optional properties:
> -- port-number		: Set Uart port number
> -- clock-names		: Should be "s_axi_aclk"
> -- clocks		: Input clock specifier. Refer to common clock bindings.
> -
> -Example:
> -serial@800c0000 {
> -	compatible = "xlnx,xps-uartlite-1.00.a";
> -	reg = <0x0 0x800c0000 0x10000>;
> -	interrupts = <0x0 0x6e 0x1>;
> -	port-number = <0>;
> -};
> diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> new file mode 100644
> index 000000000000..4ef29784ae97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/xlnx,opb-uartlite.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Axi Uartlite
> +
> +maintainers:
> +  - Peter Korsgaard <jacmet@sunsite.dk>
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - xlnx,xps-uartlite-1.00.a
> +        - xlnx,opb-uartlite-1.00.b
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  port-number:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set Uart port number
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: s_axi_aclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#
> +
> +additionalProperties: true

unevaluatedProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +      serial@800c0000 {
> +        compatible = "xlnx,xps-uartlite-1.00.a";
> +        reg = <0x800c0000 0x10000>;
> +        interrupts = <0x0 0x6e 0x1>;
> +        port-number = <0>;
> +      };
> +...
> -- 
> 2.25.1
> 
> 
