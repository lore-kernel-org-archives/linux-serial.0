Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AEAC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AE361181
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 16:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhIVQJa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232357AbhIVQJ3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 12:09:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77EC361090;
        Wed, 22 Sep 2021 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632326879;
        bh=yctlIi1HkrolODiWaucLlNNuDJShRbGjTDeBFQoL+sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTjlHne/yiD8nTOLATvSGiGbB5StrT2948rLIcHyuE9np1uUUEFoiqlCBFXOechzg
         IUQjs14cF6Wkte3RZIwukniCLCpi6agkYoB4q1FJevwdIsPnggI9V1DugAmO1MGDu6
         ywXQAEoCMhw0FTxPsPsob8cvocfL74j1uBcap/Yu20S94miYrnXROrj0V0L0SURCTa
         EMRvUESwBJBj0nY1K3PD/yiEc66jJ2KSNUNuXjpTqyd0051s0bJzbLOx7RD2Z3jsWm
         P9SGCmdjeAMYgOqZnbykk4OEJhpdljIUOg4SP0v2HlUDZfl38KFWvIcI8ulHRrDdpk
         SVFyH8Fb5o9FA==
Received: by pali.im (Postfix)
        id 09B5579F; Wed, 22 Sep 2021 18:07:56 +0200 (CEST)
Date:   Wed, 22 Sep 2021 18:07:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 5/6] arm64: dts: marvell: armada-37xx: add
 device node for UART clock and use it
Message-ID: <20210922160756.flcllzfixsn7xjxt@pali>
References: <20210922105433.11744-1-pali@kernel.org>
 <20210922105433.11744-6-pali@kernel.org>
 <87o88k63p5.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o88k63p5.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wednesday 22 September 2021 17:16:22 Gregory CLEMENT wrote:
> Hello Pali,
> 
> > This change defines DT node for UART clock "marvell,armada-3700-uart-clock"
> > and use this UART clock as a base clock for all UART devices.
> 
> Sorry to not have pointed this earlier but I found something a little
> unusual, see below:
> 
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
> >  .../boot/dts/marvell/armada-3720-espressobin.dtsi |  4 ++++
> >  .../boot/dts/marvell/armada-3720-turris-mox.dts   |  4 ++++
> >  arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts  |  4 ++++
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 15 +++++++++++++--
> >  5 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > index 3e5789f37206..accf014a6a1e 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> > @@ -191,6 +191,10 @@
> >  	};
> >  };
> >  
> > +&uartclk {
> > +	status = "okay";
> 
> I found unusual to have to enable the clock at device tree level.
> Usually the clock driver is always loaded and then the clock is really
> enabled or disabled through the clock framework.
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > index 9acc5d2b5a00..5bc61c9615f5 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > @@ -132,10 +132,21 @@
> >  				reg = <0x11500 0x40>;
> >  			};
> >  
> > +			uartclk: uartclk@12000 {
> > +				compatible = "marvell,armada-3700-uart-clock";
> > +				reg = <0x12010 0x4>, <0x12210 0x4>;
> > +				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
> > +					<&tbg 3>, <&xtalclk>;
> > +				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
> > +					"TBG-B-S", "xtal";
> > +				#clock-cells = <1>;
> 
> I think you could remove the following line and thanks to this there
> won't be any change in the dts of the board:
> > +				status = "disabled";

After removing "status" from dtsi and then also from board bts files,
UART is still working fine.

So I will include this change into V6.

Is there anything else?

> > +			};
> > +
> 
> Gregory
> 
> 
> >  			uart0: serial@12000 {
> >  				compatible = "marvell,armada-3700-uart";
> >  				reg = <0x12000 0x18>;
> > -				clocks = <&xtalclk>;
> > +				clocks = <&uartclk 0>;
> >  				interrupts =
> >  				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> >  				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > @@ -147,7 +158,7 @@
> >  			uart1: serial@12200 {
> >  				compatible = "marvell,armada-3700-uart-ext";
> >  				reg = <0x12200 0x30>;
> > -				clocks = <&xtalclk>;
> > +				clocks = <&uartclk 1>;
> >  				interrupts =
> >  				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
> >  				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
> > -- 
> > 2.20.1
> >
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
