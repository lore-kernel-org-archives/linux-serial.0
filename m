Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F98C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 13 Oct 2021 14:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6339D610FB
	for <linux-serial@archiver.kernel.org>; Wed, 13 Oct 2021 14:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhJMOWA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Oct 2021 10:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhJMOWA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Oct 2021 10:22:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F18D1610A2;
        Wed, 13 Oct 2021 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634134797;
        bh=RgljqDQdPTL+CF9pUvoROzzd39ppgepx5tkwdX4IFlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZE09hVk9RTlI4WPH4BsfFNydLErWjVQ1ilSgAcDrcxX+PB7fyz63xSv55wINJIB7
         y8xpt6IHPkOIm8jYgsEQw617skRpGK+uuLabbXSWuc5jws20Szxlb3e/eoNFdPGO6N
         Nqxp6/XnZjzy3YOp+BaredaL9dNXS2Zy0CUMftWAZ9nh2h9fBCpJG27vzHdmQBsN0l
         ipG3Q9tM86KNImZeNK7FYj/Dk0O+z6WqhY8Cwk4ZGNo+c1tKJDdXAsuexdTbUZFvzL
         FhA/JQQ4WmRlrHrZiFBFFywmW9ydMnUDzaePGLyNrGl2E3iyIH5wtXUPWB2HbgRzgc
         wr9hC52im7ZAA==
Received: by pali.im (Postfix)
        id B36B87FF; Wed, 13 Oct 2021 16:19:54 +0200 (CEST)
Date:   Wed, 13 Oct 2021 16:19:54 +0200
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/6] arm64: dts: marvell: armada-37xx: add device node
 for UART clock and use it
Message-ID: <20211013141954.cg7reu5nnj5tdsrp@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20210930095838.28145-6-pali@kernel.org>
 <87r1cpdncz.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1cpdncz.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wednesday 13 October 2021 16:13:16 Gregory CLEMENT wrote:
> Hello Pali,
> 
> > This change defines DT node for UART clock "marvell,armada-3700-uart-clock"
> > and use this UART clock as a base clock for all UART devices.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> >
> > ---
> > Changes in v6:
> > * Do not disable uartclk by default
> > * Rename node to clock-controller@12010
> > ---
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > index 9acc5d2b5a00..f9bfe73d8ec2 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> > @@ -132,10 +132,20 @@
> >  				reg = <0x11500 0x40>;
> >  			};
> >  
> > +			uartclk: clock-controller@12010 {
> > +				compatible = "marvell,armada-3700-uart-clock";
> > +				reg = <0x12010 0x4>, <0x12210 0x4>;
> > +				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
> > +					<&tbg 3>, <&xtalclk>;
> > +				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
> > +					"TBG-B-S", "xtal";
> > +				#clock-cells = <1>;
> > +			};
> > +
> >  			uart0: serial@12000 {
> >  				compatible = "marvell,armada-3700-uart";
> >  				reg = <0x12000 0x18>;
> > -				clocks = <&xtalclk>;
> > +				clocks = <&uartclk 0>;
> 
> What happens if we have a new kernel using on old device tree ?

Hello! There would be no change. New kernel would work as old kernel.
Into clocks property you can still set xtatclk as before and it would
still works.

> Gregory
> 
> >  				interrupts =
> >  				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> >  				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> > @@ -147,7 +157,7 @@
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
