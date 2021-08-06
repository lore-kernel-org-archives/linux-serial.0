Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE9AC4320A
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 08:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C4C604DB
	for <linux-serial@archiver.kernel.org>; Fri,  6 Aug 2021 08:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244350AbhHFI2n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244420AbhHFI2h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Aug 2021 04:28:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D9E861040;
        Fri,  6 Aug 2021 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628238501;
        bh=SgcNty6vS0z4/XwjB5bDBxA3xgae0FIu7/eN7OppIrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4uPA3Vs0wYnRRize85Cn3UvLSTjA1xuDDrFTszaeGcKjFwKzYkpsfedIVl0q8aL7
         15ZbDSQjB1IDfw7hfff/wxAKw+j4SimUu3CXH7WWQZ1bRj8J/6vBIH7Yzxf7EqS7Ts
         wBUnWSSsD3LI8r8Uc0peyHLjAZe9IIpXY50mZrsKxMG8XxfdHCv8OgnaScdLN/Dw/m
         AsApEqcM7R1sX8+q7ftmSyWK4Rf8cGAGEYkxBPiR06l/bIZqjGMxKGvbR/ZVx+SPlu
         qIrykTUOev6TWM3f+m/sNkbnSSXtJ5y+/nizNWuNek4ga+JZ/XoWD56g0G2pitVpcx
         J2bYULy1ODtGA==
Received: by pali.im (Postfix)
        id F16C2768; Fri,  6 Aug 2021 10:28:18 +0200 (CEST)
Date:   Fri, 6 Aug 2021 10:28:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>, kabel@kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <20210806082818.k3awj72j2yb2bbhe@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210802144529.1520-1-pali@kernel.org>
 <20210802144529.1520-4-pali@kernel.org>
 <162820981926.19113.12529765873453602213@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162820981926.19113.12529765873453602213@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thursday 05 August 2021 17:30:19 Stephen Boyd wrote:
> > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > new file mode 100644
> > index 000000000000..5ef04f3affda
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +title: Marvell Armada 3720 UART clocks
> 
> Please add a newline here
> 
> > +properties:
> > +  compatible:
> > +    const: marvell,armada-3700-uart-clock
> 
> Please add a newline here
> 
> > +  reg:
> > +    items:
> > +      - description: UART Clock Control Register
> > +      - description: UART 2 Baud Rate Divisor Register
> 
> Please add a newline here
> 
> > +  clocks:
> > +    description: |
> > +      List of parent clocks suitable for UART from following set:
> > +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> > +      UART clock can use one from this set and when more are provided
> > +      then kernel would choose and configure the most suitable one.
> > +      It is suggest to specify at least one TBG clock to achieve
> > +      baudrates above 230400 and also to specify clock which bootloader
> > +      used for UART (most probably xtal) for smooth boot log on UART.
> 
> Please use items and const like clock-names for the clocks property.

It is already there, see below.

> The description makes me feel like the DT is configuring the choices
> available.

See description. It is kernel (driver) who is choosing one clock from
the set and then configure it a UART clock.

> Ideally, the clocks and clock-names properties are fixed in
> length and never change unless the compatible changes.
> 
> Please add a newline here
> 
> > +  clock-names:
> > +    items:
> > +      - const: TBG-A-P
> > +      - const: TBG-B-P
> > +      - const: TBG-A-S
> > +      - const: TBG-B-S
> > +      - const: xtal
> > +    minItems: 1
> > +    maxItems: 5
> 
> Please add a newline here
> 
> > +  '#clock-cells':
> > +    const: 1
> 
> Please add a newline here
> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> 
> Please add a newline here
> 
> > +additionalProperties: false
> 
> Please add a newline here
> 
> > +examples:
> > +  - |
> > +    uartclk: uartclk@12000 {
> > +      compatible = "marvell,armada-3700-uart-clock";
> > +      reg = <0x12010 0x4>, <0x12210 0x4>;
> > +      clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> > +      clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
> > +      #clock-cells = <1>;
> > +    };
