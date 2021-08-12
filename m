Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48692C4320A
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 20:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B29861077
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 20:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhHLUIc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:08:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhHLUIc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 16:08:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1EBC61019;
        Thu, 12 Aug 2021 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628798886;
        bh=yW8Gq2XLubTJ2ImCMOcmC9imUwRfUmOzDB7GbvLjvgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnkHWpXQMqAM1JAMAN+5qF9s1LHjczr//l/jhvydQDZTtPw+3DloXilQrUDbumHl4
         RPKmopJN+WMH2bCAiDKIxeF1ksGTUmjOHniqedjJt5OYEr9i5UFvAOC1D4DYZfnG/i
         b8Y8tl3OCkkmsQcT+qxu5NdCUYLkSrUZMwcBwBOwOYu5G+DSO6zEj4cWMXL6o6KPNZ
         p+SO/lR7VopLhiFOux6sudLbZKQ7lmfF9DAJXms/kRmwNiKwywIwBEClTDreQu/g5k
         s8W9YUnrf0rSwXBeWyCPHF270FDamWpiJbv7urxToogsoFjQ/DcMfjclK5khEN5FNN
         Ug9j1SoNELccg==
Received: by pali.im (Postfix)
        id 569E57B9; Thu, 12 Aug 2021 22:08:04 +0200 (CEST)
Date:   Thu, 12 Aug 2021 22:08:04 +0200
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
Message-ID: <20210812200804.i4kbcs6ut27mapd3@pali>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210802144529.1520-1-pali@kernel.org>
 <20210802144529.1520-4-pali@kernel.org>
 <162820981926.19113.12529765873453602213@swboyd.mtv.corp.google.com>
 <20210806082818.k3awj72j2yb2bbhe@pali>
 <162879679919.19113.10297499909721773583@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162879679919.19113.10297499909721773583@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thursday 12 August 2021 12:33:19 Stephen Boyd wrote:
> Quoting Pali (2021-08-06 01:28:18)
> > On Thursday 05 August 2021 17:30:19 Stephen Boyd wrote:
> > > > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > > > new file mode 100644
> > > > index 000000000000..5ef04f3affda
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > > > @@ -0,0 +1,49 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +title: Marvell Armada 3720 UART clocks
> > > 
> > > Please add a newline here
> > > 
> > > > +properties:
> > > > +  compatible:
> > > > +    const: marvell,armada-3700-uart-clock
> > > 
> > > Please add a newline here
> > > 
> > > > +  reg:
> > > > +    items:
> > > > +      - description: UART Clock Control Register
> > > > +      - description: UART 2 Baud Rate Divisor Register
> > > 
> > > Please add a newline here
> > > 
> > > > +  clocks:
> > > > +    description: |
> > > > +      List of parent clocks suitable for UART from following set:
> > > > +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> > > > +      UART clock can use one from this set and when more are provided
> > > > +      then kernel would choose and configure the most suitable one.
> > > > +      It is suggest to specify at least one TBG clock to achieve
> > > > +      baudrates above 230400 and also to specify clock which bootloader
> > > > +      used for UART (most probably xtal) for smooth boot log on UART.
> > > 
> > > Please use items and const like clock-names for the clocks property.
> > 
> > It is already there, see below.
> > 
> > > The description makes me feel like the DT is configuring the choices
> > > available.
> > 
> > See description. It is kernel (driver) who is choosing one clock from
> > the set and then configure it a UART clock.
> 
> Can that be done with assigned-clock-parents?

I'm not sure if it is possible. Frequencies of "TBG-A-P", "TBG-B-P",
"TBG-A-S" and "TBG-B-S" clocks are set by firmware and frequency of
"xtal" by strapping pin. So they are not static constants. And also
kernel cannot change frequency of these clocks.

Driver reads frequencies of these clocks and choose the one which is the
most suitable for UART at runtime.

> > > Ideally, the clocks and clock-names properties are fixed in
> > > length and never change unless the compatible changes.
> > > 
> > > Please add a newline here
> > > 
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: TBG-A-P
> > > > +      - const: TBG-B-P
> > > > +      - const: TBG-A-S
> > > > +      - const: TBG-B-S
> > > > +      - const: xtal
> > > > +    minItems: 1
> > > > +    maxItems: 5
> > > 
> > > Please add a newline here
> > > 
> > > > +  '#clock-cells':
> > > > +    const: 1
> > > 
> > > Please add a newline here
> > > 
> > > > +required:
> > > > +  - compatible
> > > > +  - reg
> > > > +  - clocks
> > > > +  - clock-names
> > > > +  - '#clock-cells'
> > > 
> > > Please add a newline here
> > > 
> > > > +additionalProperties: false
> > > 
> > > Please add a newline here
> > > 
> > > > +examples:
> > > > +  - |
> > > > +    uartclk: uartclk@12000 {
> > > > +      compatible = "marvell,armada-3700-uart-clock";
> > > > +      reg = <0x12010 0x4>, <0x12210 0x4>;
> 
> The reg property looks like this is poking a mux that is part of a
> larger device. What device is this actually part of? The uart hardware?

Yes, UART hardware.

> > > > +      clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> > > > +      clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
