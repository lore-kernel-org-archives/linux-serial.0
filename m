Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF6C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 02:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9160206DA
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 02:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597717077;
	bh=tDq39NGvAq7ClgPqKMPFIsTTSpYNe/iL4mOaoa92Sqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l6edpJktsbUT1qnV4T9j6z3lrI+P2fiNGFfUIBnDNsUQY/Rt2N7/w4rnG5ztuliuF
	 JPXulRaWZpCFK/nCy8xG6l9aFxlvOVNcVkB6BigQui2JYCY4QMEs5+hjtOiPWZNgZE
	 QJmZyWsp0+j1ieCPQj9HNKiJ2q/KWP+EwkbMfrcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHRCR5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:17:57 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:41584 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRCR4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 22:17:56 -0400
Received: by mail-il1-f193.google.com with SMTP id q14so16308058ilj.8;
        Mon, 17 Aug 2020 19:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2DmIHf8Mh8SNKm1ILcK/25kWLaKGTlrOIMEK4j6/RY=;
        b=qIzZnJRWG4DxhyHNlcDL1y5jLoeijkqIWr+Fnm4EZxIUCtRaPNHiyabQAEzLnuqtfz
         3LIqUvrffhyAxRwF1MD85szLfrKLEwVYbfRlFqw35j2gxerQz4Q7V76TyErWrSUGdWlL
         GoBDq1Z8/AD06LCi2zqLKP3Hgp7OOuTwgb9VWwZBI6u4XHFrHyaQqInxQv/Pi6wVm+1o
         De3L8wlhtotmFjyMRUElgN7YvcAkkUjiwruPNl0dvPdFbCg1gxgvw1GtAoVssrTdE8HA
         CSXXklWOOfLCp8n8TAiLa+CUmUbBMbucNo6QzFfm/X5iWN6GR5W4kytN2qWvzNPxHz3E
         Yztg==
X-Gm-Message-State: AOAM530oiFtRAQrlqGLC1DznrE4X9mrSBeBzsc/cYmy7P8xE5+wTZMcg
        OBYSnOr2K+wq7OVheZi2Bg==
X-Google-Smtp-Source: ABdhPJzTb9iSNtnstPFXCiIr/7pUPmze817MTsOvNPQH0tN118nNw17Oexeqp2mDQdOIwbH7Kkg05Q==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr14177402ilm.160.1597717074835;
        Mon, 17 Aug 2020 19:17:54 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a11sm7422830ilh.74.2020.08.17.19.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 19:17:54 -0700 (PDT)
Received: (nullmailer pid 2151391 invoked by uid 1000);
        Tue, 18 Aug 2020 02:17:52 -0000
Date:   Mon, 17 Aug 2020 20:17:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        gregkh@linuxfoundation.org, galak@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 4/5] dt-bindings: serial: Convert MXS auart to
 json-schema
Message-ID: <20200818021752.GA2147074@bogus>
References: <1597222284-32609-1-git-send-email-Anson.Huang@nxp.com>
 <1597222284-32609-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597222284-32609-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 12, 2020 at 04:51:23PM +0800, Anson Huang wrote:
> Convert the MXS auart binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- update examples to align with i.MX23/i.MX28 clock bindings;
> 	- add minItem to clocks/clock-names property as i.MX23/i.MX28 have optional clocks
> 	  property with one item.
> ---
>  .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 53 -------------
>  .../devicetree/bindings/serial/fsl-mxs-auart.yaml  | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
> deleted file mode 100644
> index 5c96d41..0000000
> --- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -* Freescale MXS Application UART (AUART)
> -
> -Required properties for all SoCs:
> -- compatible : Should be one of fallowing variants:
> -	"fsl,imx23-auart" - Freescale i.MX23
> -	"fsl,imx28-auart" - Freescale i.MX28
> -	"alphascale,asm9260-auart" - Alphascale ASM9260
> -- reg : Address and length of the register set for the device
> -- interrupts : Should contain the auart interrupt numbers
> -- dmas: DMA specifier, consisting of a phandle to DMA controller node
> -  and AUART DMA channel ID.
> -  Refer to dma.txt and fsl-mxs-dma.txt for details.
> -- dma-names: "rx" for RX channel, "tx" for TX channel.
> -
> -Required properties for "alphascale,asm9260-auart":
> -- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
> -- clock-names : should be set to
> -	"mod" - source for tick counter.
> -	"ahb" - ahb gate.
> -
> -Optional properties:
> -- uart-has-rtscts : Indicate the UART has RTS and CTS lines
> -  for hardware flow control,
> -	it also means you enable the DMA support for this UART.
> -- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
> -  line respectively. It will use specified PIO instead of the peripheral
> -  function pin for the USART feature.
> -  If unsure, don't specify this property.
> -
> -Example:
> -auart0: serial@8006a000 {
> -	compatible = "fsl,imx28-auart", "fsl,imx23-auart";
> -	reg = <0x8006a000 0x2000>;
> -	interrupts = <112>;
> -	dmas = <&dma_apbx 8>, <&dma_apbx 9>;
> -	dma-names = "rx", "tx";
> -	cts-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> -	dsr-gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> -	dcd-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> -};
> -
> -Note: Each auart port should have an alias correctly numbered in "aliases"
> -node.
> -
> -Example:
> -
> -aliases {
> -	serial0 = &auart0;
> -	serial1 = &auart1;
> -	serial2 = &auart2;
> -	serial3 = &auart3;
> -	serial4 = &auart4;
> -};
> diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> new file mode 100644
> index 0000000..5c4fa75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/fsl-mxs-auart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale MXS Application UART (AUART)
> +
> +maintainers:
> +  - Kumar Gala <galak@codeaurora.org>

Why is Kumar maintainer and that's a really old email address?

> +
> +allOf:
> +  - $ref: "serial.yaml"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx23-auart
> +      - fsl,imx28-auart
> +      - alphascale,asm9260-auart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for RX
> +      - description: DMA controller phandle and request line for TX
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +  clocks:
> +    items:
> +      - description: mod clock
> +      - description: ahb clock
> +    minItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: mod
> +      - const: ahb
> +    minItems: 1
> +
> +  uart-has-rtscts: true
> +  rts-gpios: true
> +  cts-gpios: true
> +  dtr-gpios: true
> +  dsr-gpios: true
> +  rng-gpios: true
> +  dcd-gpios: true
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - alphascale,asm9260-auart
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - dmas
> +  - dma-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    aliases {
> +        serial0 = &auart0;
> +    };
> +
> +    auart0: serial@8006a000 {
> +        compatible = "fsl,imx28-auart";
> +        reg = <0x8006a000 0x2000>;
> +        interrupts = <112>;
> +        dmas = <&dma_apbx 8>, <&dma_apbx 9>;
> +        dma-names = "rx", "tx";
> +        clocks = <&clks 45>;
> +    };
> -- 
> 2.7.4
> 

