Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8252C43217
	for <linux-serial@archiver.kernel.org>; Sat, 16 Oct 2021 06:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D491F60ED4
	for <linux-serial@archiver.kernel.org>; Sat, 16 Oct 2021 06:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbhJPGoW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 16 Oct 2021 02:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234161AbhJPGoU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 Oct 2021 02:44:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7B4B60C51;
        Sat, 16 Oct 2021 06:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634366533;
        bh=RXTvpdSIJPEdj8DR1Hd+ZGmvnr6cvXK/MIOSPrX32YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7VuFXm4gpXm26e36Z9AhtuYwSj031q9rXweHLTQ+zbL4rFHCnETdig4XpJnpf97A
         FgkT9/7JeU798yEa/0Qfbs4CktY/1pmH3hwMMEozUL/Kb8z/RnxODgAsrl/FT+rj7R
         kb+Or1CC3RB5PVtAJPrztJLopwPYBuJ0wZDD3lIdaOfX9ohnS3tX28Cg+JEc+X0HKY
         wW/vg9O7SfSy+LvZPt5PaPDu6mJtwCsNdv9xXADtRPC9w7BEre9e1qorcR3chmCeXq
         oL1GORlbCMka8h5/Dsj8Lq/yrdyEZce7UaiBBblatTpl5etf94XXyJaNMgxQx0LKNy
         2p9nwPWrbH75Q==
Received: by pali.im (Postfix)
        id 4BB337DE; Sat, 16 Oct 2021 08:42:10 +0200 (CEST)
Date:   Sat, 16 Oct 2021 08:42:10 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell,armada-3700-uart-clock
Message-ID: <20211016064210.7ahqfqcvf66wtt66@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-4-pali@kernel.org>
 <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
 <20211015090937.gnt66hgugrhwnkei@pali>
 <20211015093701.pfvkighxsndj4ujg@pali>
 <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Friday 15 October 2021 14:55:47 Stephen Boyd wrote:
> Quoting Pali Rohár (2021-10-15 02:37:01)
> > On Friday 15 October 2021 11:09:37 Pali Rohár wrote:
> > > On Thursday 14 October 2021 17:13:03 Stephen Boyd wrote:
> > > > Quoting Pali Rohár (2021-09-30 02:58:35)
> > > > > diff --git a/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..175f5c8f2bc5
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> > > > > @@ -0,0 +1,59 @@
> > > > [..]
> > > > > +  '#clock-cells':
> > > > > +    const: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - clocks
> > > > > +  - clock-names
> > > > > +  - '#clock-cells'
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    uartclk: clock-controller@12010 {
> > > > 
> > > > The uart device is at 0x12000 and the clock-controller is at 0x12010?
> > > > This looks like a node is being put into DT to represent a clk driver.
> > > > Why can't we register a clk from the uart device driver itself? I think
> > > > we talked about this a month or two ago but it still isn't clear to me.
> > > 
> > > We have already talked about it and I have already wrote reasons. UART
> > > clk is shared for both UART1 and UART2. And UART clk regs are in both
> > > address spaces of UART1 and UART2. UART1 or UART2 can be independently
> > > disabled on particular board (as pins are MPP which may be configured to
> > > different function). So you have a board only with UART2, you have to
> > > disable UART1 node, but at the same time you have to access UART clk to
> > > drive UART2. And UART clk bits are in UART1 address space.
> > 
> > It is explained also in commit message of patch 2/6.
> 
> Cool, thanks for the pointer.
> 
> Why are the two uarts split into different device nodes?

I do not know. Looks like decision of people implementing this driver
and providing DT bindings.

I cannot change this existing DT binding due to backward compatibility.

> It looks like
> it's one device that was split into two nodes because they're fairly
> similar hardware blocks, and one or the other may not be used on the
> board so we want to use status = "disabled" to indicate that. Sadly the
> hardware team has delivered them as a single package into the SoC at
> address 0x12000 and then stuck a common clk for both uarts into the same
> uart wrapper. Here's a clk, job done!
> 
> Is it a problem to map UART1 address space when it isn't used on the
> board? I'm trying to understand why it can't work to register two uart
> ports from one device node and driver. It seems to be the main reason
> why we're introducing another node for the clk registers when it feels
> like it could all be handled in the existing uart driver.

Mapping address space should work. Also because in UART1 address space
is configuration of UART clock (which is common for both UART1 and
UART2). Moreover each UART has its own bit for disabling clock and these
two bits are in UART1 address space. Also it is a good idea to disable
unused UART clock (which seems to be magically/automatically done by
kernel when nobody use specified UART clock, as UART clock driver
exports two clocks).

> For example, we could have a static clk pointer in the uart driver
> indicating the clk has been registered, and then register the clk if
> uart1 or uart2 is the first device to probe and then store that clk in a
> global (with clk_hw_get_clk(), I think that's a thing now). If uart2
> probes first it can take the reg property and subtract some number to
> find the clk, and if uart1 probes first it can take the reg property and
> add some number to find the clk. Either way, the binding doesn't change
> in this case and we don't have to add another binding for this same uart
> hardware.
> 
> Then if someone wants to cleanup the binding they can combine both uarts
> into one node, make a new compatible string and add some property to
> indicate that one or the other uart isn't used. Probably also add some
> property to map the uart alias to the uart hardware block inside the
> wrapper node.

If I was designing this driver and DTS bindings I would have choose
something like this:

uart@0x12000 {
    reg = <0x12000 0x18>, <0x12200 0x30>;
    clock-controller {
        ...
    };
    serial1 {
        ...
        status = "disabled";
    };
    serial2 {
        ...
        status = "disabled";
    };
};

Meaning that 0x12000 node would be 3 subnodes and all registers would be
defined in top level nodes and would be handled by one driver.

This is really how hardware block looks like. But it is not backward
compatible...
