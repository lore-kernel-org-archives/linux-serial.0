Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C81C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 20:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5789E611C0
	for <linux-serial@archiver.kernel.org>; Mon, 27 Sep 2021 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhI0UgE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235825AbhI0UgE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Sep 2021 16:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFEFD61058;
        Mon, 27 Sep 2021 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632774866;
        bh=c2nFPj85/x3iFgHhji/OkgYydYNHJudouzIDw9eH2Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdwp4HgrzQD1xEc9iZqEzphZN+0PfksY4Ve+BdWy5sxt9RAA9Xe1N50TPXn92RyFW
         jgQGCJTBRDU4ijJcsCs+eXUm4bmF9W7GwmIlWdVv4bhKIeectCrVKE+SU6Yx+c+AlI
         D/300N6DuCkGVAQbqj9LC1s25+GMBKK0k5KWJUQ8LyJvIn+7/UYv/1ja4DgS7NpaHh
         H1j0iarj1ZgXxe/C9uZCgfXSDdmRuUG7jP9pI49l+9WPG1jYl1+38+ASuhjSQTzdyN
         gr0DxECBVUlAcO1rfB09V4q0zMRwd7SXDPOuF0xVfoIOT/goEQ9yc2whIsruqUz9XF
         GslN8oLPGWIKw==
Received: by pali.im (Postfix)
        id 545DBC83; Mon, 27 Sep 2021 22:34:23 +0200 (CEST)
Date:   Mon, 27 Sep 2021 22:34:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH v5 3/6] dt-bindings: mvebu-uart: document DT
 bindings for marvell,armada-3700-uart-clock
Message-ID: <20210927203423.o7aulgj7osaaksxr@pali>
References: <20210922105433.11744-1-pali@kernel.org>
 <20210922105433.11744-4-pali@kernel.org>
 <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKS1rjEeM558d2n6Uk1+tCazASoGJ-kDS144PsH8-Akwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Monday 27 September 2021 15:17:59 Rob Herring wrote:
> On Wed, Sep 22, 2021 at 5:56 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > This change adds DT bindings documentation for device nodes with compatible
> > string "marvell,armada-3700-uart-clock".
> 
> Please resend to the DT list so that checks run and this gets reviewed
> in a timely manner.

OK

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../bindings/clock/armada3700-uart-clock.yaml | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > new file mode 100644
> > index 000000000000..5bdb23e0ba3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> Dual license. checkpatch will tell you which ones.

OK

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +title: Marvell Armada 3720 UART clocks
> > +
> > +properties:
> > +  compatible:
> > +    const: marvell,armada-3700-uart-clock
> > +
> > +  reg:
> > +    items:
> > +      - description: UART Clock Control Register
> > +      - description: UART 2 Baud Rate Divisor Register
> > +
> > +  clocks:
> > +    description: |
> > +      List of parent clocks suitable for UART from following set:
> > +        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
> > +      UART clock can use one from this set and when more are provided
> > +      then kernel would choose and configure the most suitable one.
> > +      It is suggest to specify at least one TBG clock to achieve
> > +      baudrates above 230400 and also to specify clock which bootloader
> > +      used for UART (most probably xtal) for smooth boot log on UART.
> > +
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
> Don't need maxItems equal to length of 'items'.

OK

> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    uartclk: uartclk@12000 {
> 
> clock-controller@12010
> 
> > +      compatible = "marvell,armada-3700-uart-clock";
> > +      reg = <0x12010 0x4>, <0x12210 0x4>;
> 
> However, looks like this is part of some other block.

Yes, it is part of UART block.

Explanation is in commit message of patch 2/6.

And also discussed here:
https://lore.kernel.org/linux-serial/20210812200804.i4kbcs6ut27mapd3@pali/

> The whole block
> needs a binding (or at least the parent and whatever sub-functions you
> know about).

Whole UART block has already binding. Clock driver just needs access to
these clock bits of these two registers which are in UART block. HW
designers decided that clock which drives UART2 has configuration in
UART1 address space. As explained in commit message of patch 2/6 there
is no easy way how to deal with it in DTS backward compatible way. So
clock and UART driver shares mutex for accessing these two shared
registers, and these two registers are defined in all 3 DT nodes: UART1,
UART2 and UART-clock.

> > +      clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> > +      clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
> > +      #clock-cells = <1>;
> > +    };
> > --
> > 2.20.1
> >
