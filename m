Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC950C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAA8611C8
	for <linux-serial@archiver.kernel.org>; Fri, 15 Oct 2021 09:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhJOJLq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhJOJLq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Oct 2021 05:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BFAE60F70;
        Fri, 15 Oct 2021 09:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634288980;
        bh=gKlmBZCKfh377td8Ai6w0QzUjV+rvKC3o7zhAOzeFS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd8YKgeP+xXi8oXh/Q0MY+iTcyS6Os7t5d0ZReea+QOPW8mm/Ofwv/96h81wbBMWL
         6OGgpY8NKVIEMJkEfttNQZ1rvAnKgY+FjPbWb0cxDajhudVdH32dmrTlyBmnAG483F
         LmPmGLNitQvXTKq/Sl9CVvw0sf72uYPKTJFTKnWSpNasgxTNGN2/wB/xlqnZUpaeV1
         fe72nGFHS/v42AUGNhtXoJj6DR3/AiSJjA5mDbAlaTmu6O5rHgpQNPmlYIhKSXQoAM
         Vfy51Ob0BZc0SxziOeybOOOi/UGfx3cINJHtxxCXd1QZBzbnZY4Cbc5rlw58L8ykl8
         pCANqiz3vKJ1w==
Received: by pali.im (Postfix)
        id 8374D80A; Fri, 15 Oct 2021 11:09:37 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:09:37 +0200
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
Message-ID: <20211015090937.gnt66hgugrhwnkei@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-4-pali@kernel.org>
 <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163425678347.1688384.10695189000353676651@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thursday 14 October 2021 17:13:03 Stephen Boyd wrote:
> Quoting Pali Rohár (2021-09-30 02:58:35)
> > diff --git a/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> > new file mode 100644
> > index 000000000000..175f5c8f2bc5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> > @@ -0,0 +1,59 @@
> [..]
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
> > +    uartclk: clock-controller@12010 {
> 
> The uart device is at 0x12000 and the clock-controller is at 0x12010?
> This looks like a node is being put into DT to represent a clk driver.
> Why can't we register a clk from the uart device driver itself? I think
> we talked about this a month or two ago but it still isn't clear to me.

We have already talked about it and I have already wrote reasons. UART
clk is shared for both UART1 and UART2. And UART clk regs are in both
address spaces of UART1 and UART2. UART1 or UART2 can be independently
disabled on particular board (as pins are MPP which may be configured to
different function). So you have a board only with UART2, you have to
disable UART1 node, but at the same time you have to access UART clk to
drive UART2. And UART clk bits are in UART1 address space.

> > +      compatible = "marvell,armada-3700-uart-clock";
> > +      reg = <0x12010 0x4>, <0x12210 0x4>;
> > +      clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
> > +      clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
> > +      #clock-cells = <1>;
> > +    };
> > -- 
> > 2.20.1
> >
