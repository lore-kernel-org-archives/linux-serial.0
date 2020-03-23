Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A2C54FCF
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A20A20753
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584990035;
	bh=OWIJDZpQXbFyz2hg7RD+fmgwKJdocriC/oPehC3qluw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2YF6Olew0QvZN6BkZuK52tzSCk9tR6SiVqEA6b7+fDKUaVWfA9GTVo596aSG4+PAc
	 /KhkuKn5JIAvJBCYyOz0K2H+ZrDR4Cw44nA8WTw4/JmQjbE9pl6895z+Re7JgPlSbH
	 cKWVS0pOrkMP+OCt63EeFOoMW393NZYgUk9JLpsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCWTAb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgCWTAb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 15:00:31 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8E52072D;
        Mon, 23 Mar 2020 19:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584990030;
        bh=OWIJDZpQXbFyz2hg7RD+fmgwKJdocriC/oPehC3qluw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U3W+fW0RmvbdgZB+JjcZxIYfF1ybLXRGHjElXHueCZPD3GSty7UwhwRfgIlxosDNe
         37r47Zsm9ZxvzKgRqs3M+6PzF2uvnOazZJ91ZKyftEythqicVo84051qtg2uMrNaM1
         8G6gnlLZOrN/DIxDaH6TCVBh4G1tz7uQV/CRJHkE=
Received: by mail-qv1-f47.google.com with SMTP id f7so1509331qvr.11;
        Mon, 23 Mar 2020 12:00:30 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2t96uZQTzx1xUn532IVi0EXFci4gBXYcXkkiFJCC+9YvDu9M79
        SBmAWn7y8jmiOEY51Mg648vkfP2tvTOWczs2vQ==
X-Google-Smtp-Source: ADFU+vt5fPloqxATEzZeWN8BcOPyhi0bdMlxeXX/WkEb8iPkU0cDTP674v4mkmIkmBAx7W46QPHOvJK5jKp0fCmQN58=
X-Received: by 2002:ad4:4829:: with SMTP id h9mr21116070qvy.135.1584990028598;
 Mon, 23 Mar 2020 12:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200320174107.29406-1-lkundrak@v3.sk> <20200320174107.29406-11-lkundrak@v3.sk>
In-Reply-To: <20200320174107.29406-11-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 Mar 2020 13:00:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+GDnYviCdszhghhEVB55giPHk8N9w_KASPXG_=H+ZQig@mail.gmail.com>
Message-ID: <CAL_Jsq+GDnYviCdszhghhEVB55giPHk8N9w_KASPXG_=H+ZQig@mail.gmail.com>
Subject: Re: [PATCH 10/10] dt-bindings: serial: Convert 8250 to json-schema
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 20, 2020 at 11:41 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Some fixes were done during the conversion:

Thanks for doing this!

>
> Slightly better examples. The original example was for an OMAP serial
> port, which is not even described by this binding, but by
> omap_serial.txt instead.
>
> Added compatible strings, that were used, byt not documented:
> andestech,uart16550, cavium,octeon-3860-uart, fsl,16550-FIFO64,
> nvidia,tegra186-uart, nvidia,tegra194-uart, nxp,lpc1850-uart,
> opencores,uart16550-rtlsvn105, ralink,mt7620a-uart, ralink,rt3052-uart,
> ralink,rt3883-uart and xlnx,xps-uart16550-2.00.b.
>
> Removed "serial" compatible string. It's redundant with the node name
> (which, in OFW, serves the same purpose as the compatible string).

Yeah, that seems fairly useless to me.

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/serial/8250.txt       | 102 --------
>  .../devicetree/bindings/serial/8250.yaml      | 246 ++++++++++++++++++
>  2 files changed, 246 insertions(+), 102 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/8250.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/8250.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> new file mode 100644
> index 0000000000000..88192f94385b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -0,0 +1,246 @@
> +# Copyright 2020 Lubomir Rintel <lkundrak@v3.sk>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/8250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UART (Universal Asynchronous Receiver/Transmitter) bindings

Perhaps: "8250 series UART..."

> +
> +maintainers:
> +  - devicetree@vger.kernel.org
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#

> +  - if:
> +      not:
> +        required:
> +          - clock-frequency
> +    then:
> +      required:
> +        - clocks
> +  - if:
> +      not:
> +        required:
> +          - clocks
> +    then:
> +      required:
> +        - clock-frequency

anyOf:
  - required: [ clock-frequency ]
  - required: [ clocks ]

> +  - if:
> +      required:
> +        - aspeed,sirq-polarity-sense
> +    then:
> +      properties:
> +        compatible:
> +          const: aspeed,ast2500-vuart
> +  - if:
> +      properties:
> +        compatible:
> +          const: mrvl,mmp-uart
> +    then:
> +      properties:
> +        reg-shift:
> +          const: 2
> +      required:
> +        - reg-shift
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ns8250
> +      - const: ns16450
> +      - const: ns16550
> +      - const: ns16550a
> +      - const: ns16850
> +      - const: aspeed,ast2400-vuart
> +      - const: aspeed,ast2500-vuart
> +      - const: intel,xscale-uart
> +      - const: mrvl,pxa-uart
> +      - const: nuvoton,npcm750-uart
> +      - const: nvidia,tegra20-uart
> +      - const: nxp,lpc3220-uart
> +      - items:
> +          - enum:
> +              - altr,16550-FIFO32
> +              - altr,16550-FIFO64
> +              - altr,16550-FIFO128
> +              - fsl,16550-FIFO64
> +              - fsl,ns16550
> +              - andestech,uart16550
> +              - nxp,lpc1850-uart
> +              - opencores,uart16550-rtlsvn105
> +              - ti,da830-uart
> +          - const: ns16550a
> +      - items:
> +          - enum:
> +              - ns16750
> +              - cavium,octeon-3860-uart
> +              - xlnx,xps-uart16550-2.00.b
> +              - ralink,rt2880-uart
> +          - const: ns16550

Seems to me these are just as likely to be wrong as the fsl,ns16550 as
it's unlikely the FIFO is broken. Perhaps a note here to use
'ns16550a' instead unless you have a broken FIFO.

> +      - items:
> +          - enum:
> +            - ralink,mt7620a-uart
> +            - ralink,rt3052-uart
> +            - ralink,rt3883-uart
> +          - const: ralink,rt2880-uart
> +          - const: ns16550
> +      - items:
> +          - enum:
> +              - mediatek,mt7622-btif
> +              - mediatek,mt7623-btif
> +          - const: mediatek,mtk-btif
> +      - items:
> +          - enum:
> +              - mediatek,mt7622-btif
> +              - mediatek,mt7623-btif
> +          - const: mediatek,mtk-btif
> +      - items:
> +          - const: mrvl,mmp-uart
> +          - const: intel,xscale-uart
> +      - items:
> +          - enum:
> +              - nvidia,tegra30-uart
> +              - nvidia,tegra114-uart
> +              - nvidia,tegra124-uart
> +              - nvidia,tegra186-uart
> +              - nvidia,tegra194-uart
> +              - nvidia,tegra210-uart
> +          - const: nvidia,tegra20-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-frequency: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  current-speed:
> +    description: The current active speed of the UART.

Needs a type reference.

> +  reg-offset:
> +    description: |
> +      Offset to apply to the mapbase from the start of the registers.
> +
> +  reg-shift:
> +    description: Quantity to shift the register offsets by.
> +
> +  reg-io-width:
> +    description: |
> +      The size (in bytes) of the IO accesses that should be performed on the
> +      device. There are some systems that require 32-bit accesses to the
> +      UART (e.g. TI davinci).

We'll assume these have a type definition elsewhere.

> +
> +  used-by-rtas:
> +    description: |
> +      Set to indicate that the port is in use by the OpenFirmware RTAS and
> +      should not be registered.

Needs a type reference.

> +
> +  no-loopback-test:
> +    description: |
> +      Set to indicate that the port does not implements loopback test mode.

s/implements/implement/

Needs a type reference (or 'type: boolean').

> +
> +  fifo-size:
> +    description: The fifo size of the UART.
> +
> +  auto-flow-control:
> +    description: |
> +      One way to enable automatic flow control support. The driver is
> +      allowed to detect support for the capability even without this
> +      property.
> +
> +  tx-threshold:
> +    description: |
> +      Specify the TX FIFO low water indication for parts with programmable
> +      TX FIFO thresholds.

Need a type reference for all these.

> +
> +  resets:
> +    description: Phandle + reset specifier pairs

Is there a range of number of resets? Use minItems/maxItems.

> +
> +  overrun-throttle-ms:
> +    description: |
> +      How long to pause uart rx when input overrun is encountered.
> +
> +  rts-gpios:
> +    description: |
> +      Specify a GPIO for RTS line to be used instead of the peripheral
> +      function pin for the UART feature.

No need to define properties from serial.yaml again. Just 'rts-gpios: true'.

> +
> +  cts-gpios:
> +    description: |
> +      Specify a GPIO for CTS line to be used instead of the peripheral
> +      function pin for the UART feature.
> +
> +  dtr-gpios:
> +    description: |
> +      Specify a GPIO for DTR line to be used instead of the peripheral
> +      function pin for the UART feature.
> +
> +  dsr-gpios:
> +    description: |
> +      Specify a GPIO for DSR line to be used instead of the peripheral
> +      function pin for the UART feature.
> +
> +  rng-gpios:
> +    description: |
> +      Specify a GPIO for RNG line to be used instead of the peripheral
> +      function pin for the UART feature.
> +
> +  dcd-gpios:
> +    description: |
> +      Specify a GPIO for DCD line to be used instead of the peripheral
> +      function pin for the UART feature.
> +
> +  aspeed,sirq-polarity-sense:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description: |
> +      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> +      offset and bit number to identify how the SIRQ polarity should be
> +      configured. One possible data source is the LPC/eSPI mode bit. Only
> +      applicable to aspeed,ast2500-vuart.
> +
> +required:
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    serial@80230000 {
> +        compatible = "ns8250";
> +        reg = <0x80230000 0x100>;
> +        interrupts = <10>;
> +        reg-shift = <2>;
> +        clock-frequency = <48000000>;
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    serial@49042000 {
> +        compatible = "andestech,uart16550", "ns16550a";
> +        reg = <0x49042000 0x400>;
> +        interrupts = <80>;
> +        clock-frequency = <48000000>;
> +        cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
> +        rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> +        dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +        dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +        dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +        rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
> +    };
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    serial@1e787000 {
> +        compatible = "aspeed,ast2500-vuart";
> +        reg = <0x1e787000 0x40>;
> +        reg-shift = <2>;
> +        interrupts = <8>;
> +        clocks = <&syscon ASPEED_CLK_APB>;
> +        no-loopback-test;
> +        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
> +    };
> +
> +...
> --
> 2.25.1
>
