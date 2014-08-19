From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH 5/7] ARM: meson: dts: add basic
 Meson/Meson6/Meson6-atv1200 DTSI/DTS
Date: Tue, 19 Aug 2014 18:16:52 +0200
Message-ID: <20140819161652.GB869@carlo-MacBookPro>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
 <20140818161744.GD3302@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:40895 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbaHSQQ6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2014 12:16:58 -0400
Content-Disposition: inline
In-Reply-To: <20140818161744.GD3302@leverpostej>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "b.galvani@gmail.com" <b.galvani@gmail.com>

On Mon, Aug 18, 2014 at 05:17:44PM +0100, Mark Rutland wrote:
> On Sun, Aug 17, 2014 at 11:49:52AM +0100, Carlo Caione wrote:

<cut>

> > +	soc@c8100000 {
> 
> What's the unit-address for? This node doesn't have a reg or compatible.

I used it to indicate the starting address of the memory mapped region.

> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		uart_AO: serial@c81004c0 {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc81004c0 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart_A: serial@c81084c0 {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc81084c0 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart_B: serial@c81084dc {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc81084dc 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart_C: serial@c8108700 {
> > +			compatible = "amlogic,meson-uart";
> > +			reg = <0xc8108700 0x14>;
> > +			interrupts = <0 90 1>;
> > +			clocks = <&clk81>;
> > +			status = "disabled";
> 
> I guess these are disabled because they aren't always wired up?

Yes

<cut>

> > +	clocks {
> > +		#address-cells = <1>;
> > +
> > +		clk81: clk@0 {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <200000000>;
> > +		};
> > +	};
> 
> There is really no need to put clocks in a container.
> 
> Just put them under the root, and drop the unit-address.

I'll do, thanks.

-- 
Carlo Caione
