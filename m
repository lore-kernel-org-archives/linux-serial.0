From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Thu, 23 Jul 2015 20:42:29 -0700
Message-ID: <20150724034229.642.88156@quantum>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
 <alpine.DEB.2.11.1507030006280.3916@nanos> <2009463.YLtdMegFel@wuerfel>
 <alpine.LNX.2.00.1507042327490.1296@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1507042327490.1296@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <r.herring@freescale.com>, Alexander Potashev <aspotashev@emcraft.com>, Frank Li <Frank.Li@freescale.com>, Jiri Slaby <jslaby@suse.cz>, linux-clk@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Anson Huang <b20788@freescale.com>, devicetree@vger.kernel.org, Paul Osmialowski <pawelo@king.net.pl>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Yuri Tikhonov <yur@emcraft.com>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.>
List-Id: linux-serial@vger.kernel.org

Quoting Paul Osmialowski (2015-07-04 14:50:03)
> Hi Arnd,
> 
> I'm attaching excerpt from Kinetis reference manual that may make 
> situation clearer.

Hi Paul,

Can you please post the patch in the body of the email instead of an
attachment? It makes it easier to review. Another small nitpick is that
the $SUBJECT for this patch might be better off as something like:

clk: mcg and sim clock drivers for twr-k70f120m Kinetis SoC

At least it helps me find the patch I care about when skimming the
series ;-)

> 
> These MCG and SIM registers are used only to determine configuration 
> (clock fixed rates and clock signal origins) at run time.
> 
> Namely, the real MCGOUTCLK source (in the middle) which is the parent for 
> core clock (CCLK) and peripheral clock (PCLK) is determined at run time by 
> reading MCG registers, let me quote commit message from Emcraft git repo:
> 
>       * Determine in run-time what oscillator module (OSC0 or OSC1) is used
>      as clock source for the main PLL.

According to [0] there are three options: a 32k RTC osc clock and osc0
both feed into a mux. You should model this 32k clock with the
fixed-rate binding.

>       * When OSC1 is selected, assume its frequency to be 12 MHz on all
>      boards (there is a 12 MHz oscillator on XTAL1/EXTAL1 on K70-SOM and
>      TWR-K70F120M boards).
> 
> In my .dts I'm trying to possibly follow real clock hierarchy, but to go 
> anywhere behind MCGOUTCLK would require ability to rewrite .dtb e.g. by 
> U-boot. But that's too demanding for any potential users of this BSP. So 
> let's asume that MCGOUTCLK is the root clock and a parent for CCLK and 
> PCLK.

I'm confused. The point of device tree is to solve problems like this;
i.e. board-specific differences such as different oscillator
frequencies.

OSC0 and OSC1 should each be a fixed-rate clock in your board-specific
TWR-K70F120M DTS (not a chip-specific file). They do not belong in the
cmu node, and they should use the "fixed-clock" binding. The 32k RTC osc
can probably go in your chip-specific .dtsi as a fixed-rate clock since
it appears to mandated in the reference manual[0].

These three fixed-rate clocks are your root clock nodes. Customers only
need to worry about this if they spin a board, and then they will need
to populate the frequencies of OSC0 and OSC1 in their board-specific
.dts.

Please break clk-kinetis.c into two files:
drivers/clk/kinetis/clk-mcg.c
drivers/clk/kinetis/clk-sim.c

Below is what your binding/dts should look like:

{
	osc0: clock {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <50000000>;
	};

	osc1: clock {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <12000000>;
	};

	rtc: clock {
		compatible = "fixed-clock";
		#clock-cells = <0>;
		clock-frequency = <32768>;
	};

	soc: soc {
		mcg: clock-controller@40064000 {
			compatible = "fsl,kinetis-mcg";
			clock-cells = <1>;
			reg = <0x40064000 0x14>;
			clocks = <&osc0>, <&osc1>, <&rtc>;
			clock-names = "osc0", "osc1", "rtc";
		};

		sim: clock-controller@40047000 {
			compatible = "fsl,kinetis-sim";
			clock-cells = <1>;
			reg = <0x40047000 0x1100>;
			clocks = <&mcg MCG_MCGOUTCLK_DIV1>, <&mcg MCG_MCGOUTCLK_DIV2>, <&mcg MCG_MCGOUTCLK_DIV3> <&mcg MCG_MCGOUTCLK_DIV4>;
			clock-names = "core", "bus", "flexbus", "flash";
		};
	};

	uart0: serial@4006a000 {
		compatible = "fsl,kinetis-lpuart";
		reg = <0x4006a000 0x1000>;
		clocks = <&sim SIM_SCGC4_UART1_CLK>;
		clock-names = "gate";
	};

I removed the interrupts and dma stuff from the uart0 node for clarity.
The above is the only style of binding that I have been accepting for
some time; first declare the clock controller and establish its register
space, and then consumers can consume clocks by providing the phandle to
the controller plus an offset corresponding to a unique clock. The
clock-names property makes it really easy to use with the clkdev stuff
(e.g. clk_get()).

I've covered this before on the mailing list so here is a link
describing how the qcom bindings do it in detail:

http://lkml.kernel.org/r/<20150416192014.19585.9663@quantum>

Technically you could encode the same bits as sub-nodes of the mcg and
sim nodes, but the shared header is how the magic happens with the
driver so it's best to keep the clock controller binding small and
light.

I think this means you can also get rid of kinetis_of_clk_get_name and
kinetis_clk_gate_get but my brain is tired so I'll leave that as an
exercise to the reader.

[0] http://cache.freescale.com/files/microcontrollers/doc/ref_manual/K70P256M150SF3RM.pdf

Regards,
Mike

> 
> In my most recent version I added OSC0ERCLK explicitly as one more root 
> clock, since it is also used directly (through CG reg. 1 bit 0) by 
> Freescale fec network device whose in-tree driver I'm trying to make 
> usable for Kinetis.
> 
> On Sat, 4 Jul 2015, Arnd Bergmann wrote:
> 
> > On Friday 03 July 2015 00:08:27 Thomas Gleixner wrote:
> >> On Thu, 2 Jul 2015, Paul Osmialowski wrote:
> >>> On Thu, 2 Jul 2015, Arnd Bergmann wrote:
> >>>
> >>>> I wonder if you could move out the fixed rate clocks into their own
> >>>> nodes. Are they actually controlled by the same block? If they are
> >>>> just fixed, you can use the normal binding for fixed rate clocks
> >>>> and only describe the clocks that are related to the driver.
> >>>
> >>> In my view having these clocks grouped together looks more convincing. After
> >>> all, they all share the same I/O regs in order to read configuration.
> >>
> >> The fact that they share a register is not making them a group. That's
> >> just a HW design decision and you need to deal with that by protecting
> >> the register access, but not by trying to group them artificially at
> >> the functional level.
> >
> > I'd disagree with that: The clock controller is the device that owns the
> > registers and that should be one node in DT, as Paul's first version does.
> >
> > The part I'm still struggling with is understanding how the fixed-rate
> > clocks are controlled through those registers. If they are indeed configured
> > through the registers, the name is probably wrong and should be changed
> > to whatever kind of non-fixed clock this is.
> >
> >       Arnd
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
