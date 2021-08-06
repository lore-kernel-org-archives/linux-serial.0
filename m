Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57189C4338F
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 00:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2936261184
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 00:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhHFAag (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Aug 2021 20:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235480AbhHFAaf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Aug 2021 20:30:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E4861078;
        Fri,  6 Aug 2021 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628209820;
        bh=+mtOWYvH54JQ4ZiwWjYbU3ADjpbxBcxt2+P8ungC1J0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BwJTq9/5xx4DFmhc/ONo+HPpbfsiwf+bPgoqWcSKhaWSRfSqFCfHvzZFjyKqTEaBZ
         zc516KgsQlmWP0Z3usUcswDhW8CPVovLNA4ZO8dH4Dvnauz/3ikXoYsWcbzyXRmg3N
         AWusR7+J4/skuj6FYHDC2Gy2sAjP4g2uQwlWJPF0uj0bGLEMS+AAPBj+vPLYq+t0Va
         CyVoFQRHvrJTDPDtm22tiDGaiJGD7xgCKwgXkG0UiVE4XJrF8FijNl/SPmXNk8zh9V
         Y9Ab0AJ57cssSm9RoRMrLzaSYJjgAMAjmlUaS/8DG1Br4m25bLH91AgXy4JMBOwgcH
         JZ/tfp7CxAHlw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210802144529.1520-4-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org> <20210802144529.1520-1-pali@kernel.org> <20210802144529.1520-4-pali@kernel.org>
Subject: Re: [PATCH v4 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>, <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>, <pali@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 05 Aug 2021 17:30:19 -0700
Message-ID: <162820981926.19113.12529765873453602213@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-cloc=
k.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> new file mode 100644
> index 000000000000..5ef04f3affda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +title: Marvell Armada 3720 UART clocks

Please add a newline here

> +properties:
> +  compatible:
> +    const: marvell,armada-3700-uart-clock

Please add a newline here

> +  reg:
> +    items:
> +      - description: UART Clock Control Register
> +      - description: UART 2 Baud Rate Divisor Register

Please add a newline here

> +  clocks:
> +    description: |
> +      List of parent clocks suitable for UART from following set:
> +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> +      UART clock can use one from this set and when more are provided
> +      then kernel would choose and configure the most suitable one.
> +      It is suggest to specify at least one TBG clock to achieve
> +      baudrates above 230400 and also to specify clock which bootloader
> +      used for UART (most probably xtal) for smooth boot log on UART.

Please use items and const like clock-names for the clocks property. The
description makes me feel like the DT is configuring the choices
available. Ideally, the clocks and clock-names properties are fixed in
length and never change unless the compatible changes.

Please add a newline here

> +  clock-names:
> +    items:
> +      - const: TBG-A-P
> +      - const: TBG-B-P
> +      - const: TBG-A-S
> +      - const: TBG-B-S
> +      - const: xtal
> +    minItems: 1
> +    maxItems: 5

Please add a newline here

> +  '#clock-cells':
> +    const: 1

Please add a newline here

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'

Please add a newline here

> +additionalProperties: false

Please add a newline here

> +examples:
> +  - |
> +    uartclk: uartclk@12000 {
> +      compatible =3D "marvell,armada-3700-uart-clock";
> +      reg =3D <0x12010 0x4>, <0x12210 0x4>;
> +      clocks =3D <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> +      clock-names =3D "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
> +      #clock-cells =3D <1>;
> +    };
