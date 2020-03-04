Return-Path: <SRS0=+90y=4V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C44DC3F2CD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F25720838
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583330609;
	bh=c/7PbKWljRp0trpq1iIHJMt5H9ohH4AXeljh80TNni0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W3kov/va2bMH0IE18Ld5vXipYCM+TIBbpIXdhhQfu7hH3cHFF2otSmoeS8DsX2Sgi
	 CNUG6JtHA61hdlPwjJXQkfhOlnLNceAK37C2QdpqPkpTTAWlLx6EQuW8HbrB4GR9/1
	 6Q8LkMAWX4KhsNo+gDfQ80hfcLLkiufj+DPyX87w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCDOD2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDOD2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 09:03:28 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B01120838;
        Wed,  4 Mar 2020 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583330607;
        bh=c/7PbKWljRp0trpq1iIHJMt5H9ohH4AXeljh80TNni0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X2qaS1m0mn4bOQZcNPXvuutE1rY1DG0eK+e7r1ATiAFki2kUvFLIWISAnVJ1nQc85
         l/LiUfu7HlJ3gvS5CdVk2vvQy/fU8LuFp1JFDqpd4c+1R/TuxPMxOCX9kzoC3ZWMvJ
         CMJCycFiiGIIwvdA7E4mqk3/a2RE3+2aXvZ1Bwx8=
Received: by mail-qt1-f175.google.com with SMTP id h16so1370632qtr.11;
        Wed, 04 Mar 2020 06:03:27 -0800 (PST)
X-Gm-Message-State: ANhLgQ1m1evlek1CRSxV1OELvvioxGNE5qzpk91CxpA4h3a3FiCKG/Bb
        Ug+cUxowZGdvxPuK2RRTbbNZK+Am7w0+33IGwg==
X-Google-Smtp-Source: ADFU+vvkXmsZ7+dChOIng8XdX7Ybtyzwvh/1OvNSw/vFtYgEGvGFLxsUZgfeBBWYmteauSXqvDObiftDHxbxhfhdKdA=
X-Received: by 2002:aed:2344:: with SMTP id i4mr2563203qtc.136.1583330606186;
 Wed, 04 Mar 2020 06:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20200303134351.22270-1-geert+renesas@glider.be> <20200303134351.22270-2-geert+renesas@glider.be>
In-Reply-To: <20200303134351.22270-2-geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 4 Mar 2020 08:03:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7x-XevypLxUUksOCyezbn8=NpL9rMfo0rCQyYzrUxmw@mail.gmail.com>
Message-ID: <CAL_JsqL7x-XevypLxUUksOCyezbn8=NpL9rMfo0rCQyYzrUxmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert generic bindings to json-schema
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Mar 3, 2020 at 7:43 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Convert the generic serial interface Device Tree binding documentation
> to json-schema.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/serial/serial.txt     | 56 -----------
>  .../devicetree/bindings/serial/serial.yaml    | 95 +++++++++++++++++++
>  2 files changed, 95 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/serial.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/serial.yaml

> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
> new file mode 100644
> index 0000000000000000..d408335319f00215
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/serial/serial.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Serial Interface Generic DT Bindings
> +
> +maintainers:
> +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +
> +description:
> +  This document lists a set of generic properties for describing UARTs in a
> +  device tree.  Whether these properties apply to a particular device depends
> +  on the DT bindings for the actual device.
> +
> +properties:
> +  $nodename:
> +    pattern: "^serial@[0-9a-f]+$"

',' is also possible in unit-address. Probably shouldn't be defining
unit-address format at all here, so:

"^serial(@.*)?$"

> +
> +  cts-gpios:
> +    description:
> +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> +      the UART's CTS line.

These all need a 'maxItems: 1'.

> +
> +  dcd-gpios:
> +    description:
> +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> +      the UART's DCD line.
> +
> +  dsr-gpios:
> +    description:
> +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> +      the UART's DSR line.
> +
> +  dtr-gpios:
> +    description:
> +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> +      the UART's DTR line.
> +
> +  rng-gpios:
> +    description:
> +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> +      the UART's RNG line.
> +
> +  rts-gpios:
> +    description:
> +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> +      the UART's RTS line.
> +
> +  uart-has-rtscts:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The presence of this property indicates that the UART has dedicated lines
> +      for RTS/CTS hardware flow control, and that they are available for use
> +      (wired and enabled by pinmux configuration).  This depends on both the
> +      UART hardware and the board wiring.
> +      Note that this property is mutually-exclusive with "cts-gpios" and
> +      "rts-gpios" above, unless support is provided to switch between modes
> +      dynamically.

This can be expressed as:

oneOf:
  - {} # None of the properties present
  - required:
      - uart-has-rtscts
  - anyOf:
      - required:
          - cts-gpios
      - required:
          - rts-gpios

Or probably more clearly:

if:
  required:
    - uart-has-rtscts
then:
  properties:
    rts-gpios: false
    cts-gpios: false

(Untested)

> +
> +examples:

Personally, I'd just drop examples from schemas that aren't complete.

> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    serial@48022000 {
> +            compatible = "ti,am3352-uart", "ti,omap3-uart";
> +            ti,hwmods = "uart2";
> +            clock-frequency = <48000000>;
> +            reg = <0x48022000 0x2000>;
> +            interrupts = <73>;
> +            dmas = <&edma 28 0>, <&edma 29 0>;
> +            dma-names = "tx", "rx";
> +            dtr-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
> +            dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
> +            dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
> +            rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
> +            cts-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> +            rts-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/clock/sh73a0-clock.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    serial@e6c80000 {
> +            compatible = "renesas,scifa-sh73a0", "renesas,scifa";
> +            reg = <0xe6c80000 0x100>;
> +            interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
> +            clock-names = "fck";
> +            power-domains = <&pd_a3sp>;
> +            uart-has-rtscts;
> +    };
> --
> 2.17.1
>
