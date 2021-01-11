Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D71C072AD
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA00C22D57
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 00:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403769AbhALA0D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Jan 2021 19:26:03 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]:42713 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404129AbhAKXbb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Jan 2021 18:31:31 -0500
Received: by mail-oo1-f49.google.com with SMTP id x203so164444ooa.9;
        Mon, 11 Jan 2021 15:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Uknbc1xGolFNlNAiQcwBCWCnZAbMbcUXo++S6Xq6PEE=;
        b=RUeLFbSFyrUjGM/abUa3L3LZ57pEY3l2x2wDoTgV6X52sz3YPjpUFUWuXms1+WYdij
         qIN+fleXNLRoi5TZ8hVWLd7mQA+5FLoYkBRS/pV3nT1g7obdAN1iT2glAChw0BSVMjqu
         v3X+H/4pd7lBomixodWbdHqDi8s/mKKSQzw/dUeYu+RObOd5keEt3O7vGxoWyRVFrqJs
         NfocwsDreovN1mtgiMc4YZovGPdl4/HbtXtOKbtr552RsTmicgd9pALO/U2La3Mecglb
         1lN0gEk5LRX2946ypksQAd/o7et6TXXspfVIW7YpY4xhfq8svqW3MxpQU1yyIBgXk3Wa
         TO3w==
X-Gm-Message-State: AOAM530a/lgkuXb5NmEDEPqDmLZw3CQ3jFdduncG2mgJHUxoQvLaYsYG
        z1Po52VpEvfwqpjlSlnlbQ==
X-Google-Smtp-Source: ABdhPJweJ8rbeoE1Ac+/EnQKCqetMX4SfaRxu3UZACsdHvAw9DRNpRbnFgZjBw3DMMPhlhWmJC+owQ==
X-Received: by 2002:a4a:4592:: with SMTP id y140mr1085458ooa.26.1610407849857;
        Mon, 11 Jan 2021 15:30:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm220854oos.47.2021.01.11.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 15:30:48 -0800 (PST)
Received: (nullmailer pid 3257128 invoked by uid 1000);
        Mon, 11 Jan 2021 23:30:48 -0000
Date:   Mon, 11 Jan 2021 17:30:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7,2/2] dt: bindings: add silabs,si4455 schema
Message-ID: <20210111233048.GA3252430@robh.at.kernel.org>
References: <20210105103027.GA15137@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105103027.GA15137@dev>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 05, 2021 at 10:30:29AM +0000, József Horváth wrote:
> This is a device tree schema for serial port driver for
>  Silicon Labs Si4455 Sub-GHz transciver.
> 
> Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> 
> Guide: https://github.com/dministro/linux-serial-si4455
> 
> Signed-off-by: Jozsef Horvath <info@ministro.hu>
> ---
> 
> changes v1:
>  - fixed: dt: bindings: rename sdn-gpios to shutdown-gpios
> 
> changes v3:
>  - fixed: dt: bindings: silabs,si4455: more detailed description
>  - added: dt: bindings: silabs,si4455: properties silabs,package-size,
>    silabs,tx-channel, silabs,rx-channel, silabs,ez-config
> 
> changes v4:
>  - fixed: dt: bindings: silabs,si4455: $id
>    from http://devicetree.org/schemas/serial/silabs,si4455.yaml
>    to http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
> 
> changes v5:
>  - fixed: dt: bindings: silabs,si4455: $id
>    from http://devicetree.org/schemas/staging/serial/silabs,si4455.yaml
>    to http://devicetree.org/schemas/serial/silabs,si4455.yaml
>  - fixed: dt: bindings: silabs,si4455: serial.yaml reference added
> 
> changes v7:
>  - added: dt: bindings: silabs,si4455: silabs,tx-timeout property definition
> ---
>  .../bindings/serial/silabs,si4455.yaml        | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/silabs,si4455.yaml b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> new file mode 100644
> index 000000000000..8ba4956064b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/silabs,si4455.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/silabs,si4455.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Silicon Labs Si4455 device tree bindings
> +
> +maintainers:
> +  - József Horváth <info@ministro.hu>
> +
> +description:
> +  This document is for describing the required device tree parameters for si4455 serial driver.
> +  The si4455 driver tries to represent the Silicon Labs Si4455 sub-GHz transceiver device
> +  like a serial port. The required parameters for proper operation are described below.
> +  https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> +
> +allOf:
> +  - $ref: "serial.yaml#"
> +
> +properties:
> +  compatible:
> +    const: silabs,si4455
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description: maximum clock frequency on SPI port
> +    maximum: 500000
> +
> +  shutdown-gpios:
> +    description: gpio pin for SDN
> +    maxItems: 1
> +
> +  silabs,package-size:
> +    description:
> +      Radio payload length, variable packet length is not supported by driver.
> +      This value should equal with EZConfig payload length.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 64
> +    minimum: 1
> +
> +  silabs,tx-channel:
> +    description:
> +      Radio transmit channel selection.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 255
> +    minimum: 0
> +
> +  silabs,rx-channel:
> +    description:
> +      Radio receive channel selection.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 255
> +    minimum: 0
> +
> +  silabs,tx-timeout:
> +    description:
> +      Radio transmit timeout(ms)

Use a unit suffix as defined in property-units.txt.

> +    $ref: /schemas/types.yaml#/definitions/uint32

With that, you can drop the type.

> +    maximum: 1000
> +    minimum: 1
> +
> +  firmware-name:
> +    description:
> +      Radio configuration data file name.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    items:
> +      pattern: ^[0-9a-z\._\-]{1,255}$
> +
> +required:
> +  - reg
> +  - interrupts
> +  - spi-max-frequency
> +  - shutdown-gpios
> +  - silabs,package-size
> +  - silabs,tx-channel
> +  - silabs,rx-channel
> +  - firmware-name
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      si4455_0: serial@0 {
> +        compatible = "silabs,si4455";
> +        reg = <0>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <7 2>;
> +        shutdown-gpios = <&gpio 26 1>;
> +        spi-max-frequency = <300000>;
> +        silabs,package-size = <30>;
> +        silabs,tx-channel = <1>;
> +        silabs,rx-channel = <2>;
> +        firmware-name = "si4455_spi0_0.ez.bin";
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
