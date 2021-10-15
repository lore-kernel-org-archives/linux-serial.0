Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD5DC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 22:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DB861163
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbhJOWKj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 18:10:39 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:63365 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbhJOWKh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 18:10:37 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 1702a20a;
        Sat, 16 Oct 2021 00:08:25 +0200 (CEST)
Date:   Sat, 16 Oct 2021 00:08:25 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     pali@kernel.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, robh+dt@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        vladimir.vid@sartura.hr, kabel@kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
In-Reply-To: <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
        (message from Stephen Boyd on Fri, 15 Oct 2021 14:55:47 -0700)
Subject: Re: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for
 marvell, armada-3700-uart-clock
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-4-pali@kernel.org>
 <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
 <20211015090937.gnt66hgugrhwnkei@pali> <20211015093701.pfvkighxsndj4ujg@pali> <163433494758.1688384.5994009027317282677@swboyd.mtv.corp.google.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <d3ca657877a01872@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> From: Stephen Boyd <sboyd@kernel.org>
> Date: Fri, 15 Oct 2021 14:55:47 -0700
> 
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
> Why are the two uarts split into different device nodes? It looks like
> it's one device that was split into two nodes because they're fairly
> similar hardware blocks, and one or the other may not be used on the
> board so we want to use status = "disabled" to indicate that. Sadly the
> hardware team has delivered them as a single package into the SoC at
> address 0x12000 and then stuck a common clk for both uarts into the same
> uart wrapper. Here's a clk, job done!
> 
> Is it a problem to map UART1 address space when it isn't used on the
> board? I'm trying to understand why it can't work to register two uart
> ports from one device node and driver.

Separate nodes are needed because stdin-path and stdout-patch need to
be able to point at a specific device node.
