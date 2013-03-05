From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 3/3] ARM: mach-shmobile: r8a7740: Setup the serial
 devices using DT
Date: Tue, 5 Mar 2013 16:04:39 +0900
Message-ID: <20130305070439.GA15907@verge.net.au>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <1361898208-6683-3-git-send-email-hechtb+renesas@gmail.com>
 <20130301094205.GG27938@verge.net.au>
 <CABYn4syZJjDzuj2YqT3wCvnEuyE0Ab-8x=g1+_Fr9gw43_w_rw@mail.gmail.com>
 <20130302013147.GB3273@verge.net.au>
 <CANqRtoTQ5mRCk1bRjkFOf9gj3w1N5ErO9i1HjBGbw=MA=Rh1aQ@mail.gmail.com>
 <Pine.LNX.4.64.1303041424310.14249@axis700.grange>
 <20130305032744.GO16128@verge.net.au>
 <Pine.LNX.4.64.1303050740330.24699@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45153 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab3CEHEm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Mar 2013 02:04:42 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1303050740330.24699@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb@gmail.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

On Tue, Mar 05, 2013 at 07:52:21AM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Tue, 5 Mar 2013, Simon Horman wrote:
> 
> > On Mon, Mar 04, 2013 at 02:33:40PM +0100, Guennadi Liakhovetski wrote:
> 
> [snip]
> 
> > > That would be the best, I agree. However, we discussed this already on the 
> > > example of mmcif, you might remember. I asked what's the difference 
> > > between extending a DT node (from .dtsi) with additional properties (in a 
> > > board-specific .dts) using an "&phandle" syntax and a full path? Or are 
> > > they equivalent? There was no reply, so, for such nodes (MMC/SD) I so far 
> > > settled with complete nodes in .dts. We do use the "&phandle" syntax for 
> > > pinctrl function groups, for I2C devices. I used a complete path for 
> > > CPUFreq... Mostly because other platforms did that too.
> > 
> > I am confused.
> > 
> > Using phandle syntax we can add a device to an soc's dtsi file and then add
> > extra properties in the board file.  This seems to be match the HW well.
> > 
> > What is your alternate suggestion?
> 
> Let me give you examples. In sh73a0-reference.dtsi we define an I2C device 
> #0:
> 
> 	i2c0: i2c@0xe6820000 {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		compatible = "renesas,rmobile-iic";
> 		reg = <0xe6820000 0x425>;
> 		...
> 	};
> 
> Then in sh73a0-kzm9g-reference.dts I can use the phandle syntax to put 
> devices on that I2C bus:
> 
> &i2c0 {
> 	as3711@40 {
> 		compatible = "ams,as3711";
> 		reg = <0x40>;
> 		...
> 	};
> 	...
> };
> 
> This is one possibility. In sh73a0.dtsi we've got
> 
> 	cpus {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		cpu@0 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a9";
> 			reg = <0>;
> 		};
> 		...
> 	};
> 
> Now, I can also extend this in sh73a0-kzm9g-reference.dts to add CPUFreq 
> support to CPU0:
> 
> 	cpus {
> 		cpu@0 {
> 			cpu0-supply = <&vdd_dvfs>;
> 			operating-points = <
> 				/* kHz  uV */
> 				1196000 1315000
> 				 598000 1175000
> 				 398667 1065000
> 			>;
> 			voltage-tolerance = <1>; /* 1% */
> 		};
> 	};
> 
> Which AFAICS does a similar thing (adds more properties to an existing DT 
> node) but uses a different syntax. Maybe they are completely equivalent, 
> the only difference being, that the former example uses a phandle and the 
> latter a complete path, maybe there are differences, I don't know.

Interesting. Thanks for the example, I now understand.

To be honest I'm not sure what the answer is.
But if they are both working then I'm not particularly fussed either way.
