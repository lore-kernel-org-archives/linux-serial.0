Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA2C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BAE61077
	for <linux-serial@archiver.kernel.org>; Thu, 12 Aug 2021 19:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhHLTdq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhHLTdq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Aug 2021 15:33:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A1606103E;
        Thu, 12 Aug 2021 19:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628796800;
        bh=YI8Ka6ZHWlucnyLQIu6sspluqaLo4KckF0oA5V5Hkaw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M+XvW7qnRmgxRCv6QtS5ZAp99QDaaS2Lgz4GOc7j47iAdJRLYJK9JzsuMCaxPGAZa
         Lcu6OqN08Jq65mi8wtjrWUA9YW1fWIivJ80KL63MRNlNB0+8shC1zr1Ery57DKoHtT
         bfKeutBPXt07b7Qacdzq7dmhnu68CLbQgR2qd58GKOY9qIn4itwbUfRYhlxIErh6Bj
         F+QL28E62rdvsHipNQ4h1xQFbwJZEmY1M+4qZYxcAr1KffYlV3v7Ic6o1MRZCj4BND
         +LdX1SlRM2CQvOVnGiXTqg4N462M9S14pO7NqNGuJ+FYTt2b0OVN0OSosLBtsDkDMd
         1tZrg5ew99h+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210806082818.k3awj72j2yb2bbhe@pali>
References: <20210624224909.6350-1-pali@kernel.org> <20210802144529.1520-1-pali@kernel.org> <20210802144529.1520-4-pali@kernel.org> <162820981926.19113.12529765873453602213@swboyd.mtv.corp.google.com> <20210806082818.k3awj72j2yb2bbhe@pali>
Subject: Re: [PATCH v4 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>, kabel@kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     <pali@kernel.org>
Date:   Thu, 12 Aug 2021 12:33:19 -0700
Message-ID: <162879679919.19113.10297499909721773583@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Pali (2021-08-06 01:28:18)
> On Thursday 05 August 2021 17:30:19 Stephen Boyd wrote:
> > > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-=
clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.=
yaml
> > > new file mode 100644
> > > index 000000000000..5ef04f3affda
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.y=
aml
> > > @@ -0,0 +1,49 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-cl=
ock#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +title: Marvell Armada 3720 UART clocks
> >=20
> > Please add a newline here
> >=20
> > > +properties:
> > > +  compatible:
> > > +    const: marvell,armada-3700-uart-clock
> >=20
> > Please add a newline here
> >=20
> > > +  reg:
> > > +    items:
> > > +      - description: UART Clock Control Register
> > > +      - description: UART 2 Baud Rate Divisor Register
> >=20
> > Please add a newline here
> >=20
> > > +  clocks:
> > > +    description: |
> > > +      List of parent clocks suitable for UART from following set:
> > > +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> > > +      UART clock can use one from this set and when more are provided
> > > +      then kernel would choose and configure the most suitable one.
> > > +      It is suggest to specify at least one TBG clock to achieve
> > > +      baudrates above 230400 and also to specify clock which bootloa=
der
> > > +      used for UART (most probably xtal) for smooth boot log on UART.
> >=20
> > Please use items and const like clock-names for the clocks property.
>=20
> It is already there, see below.
>=20
> > The description makes me feel like the DT is configuring the choices
> > available.
>=20
> See description. It is kernel (driver) who is choosing one clock from
> the set and then configure it a UART clock.

Can that be done with assigned-clock-parents?

>=20
> > Ideally, the clocks and clock-names properties are fixed in
> > length and never change unless the compatible changes.
> >=20
> > Please add a newline here
> >=20
> > > +  clock-names:
> > > +    items:
> > > +      - const: TBG-A-P
> > > +      - const: TBG-B-P
> > > +      - const: TBG-A-S
> > > +      - const: TBG-B-S
> > > +      - const: xtal
> > > +    minItems: 1
> > > +    maxItems: 5
> >=20
> > Please add a newline here
> >=20
> > > +  '#clock-cells':
> > > +    const: 1
> >=20
> > Please add a newline here
> >=20
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - '#clock-cells'
> >=20
> > Please add a newline here
> >=20
> > > +additionalProperties: false
> >=20
> > Please add a newline here
> >=20
> > > +examples:
> > > +  - |
> > > +    uartclk: uartclk@12000 {
> > > +      compatible =3D "marvell,armada-3700-uart-clock";
> > > +      reg =3D <0x12010 0x4>, <0x12210 0x4>;

The reg property looks like this is poking a mux that is part of a
larger device. What device is this actually part of? The uart hardware?

> > > +      clocks =3D <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> > > +      clock-names =3D "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "x=
tal";
