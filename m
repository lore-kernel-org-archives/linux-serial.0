From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Tue, 28 Jul 2015 09:03:47 -0700
Message-ID: <20150728160347.642.31950@quantum>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
 <alpine.DEB.2.11.1507030006280.3916@nanos> <2009463.YLtdMegFel@wuerfel>
 <alpine.LNX.2.00.1507042327490.1296@localhost.localdomain>
 <20150724034229.642.88156@quantum>
 <alpine.LNX.2.00.1507262211470.28341@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LNX.2.00.1507262211470.28341@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <r.herring@freescale.com>, Alexander Potashev <aspotashev@emcraft.com>, Frank Li <Frank.Li@freescale.com>, Jiri Slaby <jslaby@suse.cz>, linux-clk@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Anson Huang <b20788@freescale.com>, devicetree@vger.kernel.org, Paul Osmialowski <pawelo@king.net.pl>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingchang Lu <jingchang.lu@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

Quoting Paul Osmialowski (2015-07-26 13:24:08)
> Hi Mike,
> 
> Thank you for spending time on this and pointing me into the right 
> direction. I'm wondering about going even further with it. Assuming that I 

Hi Paul,

No problem! And thanks for the quick turnaround on your patches so far.

> know everything about my board, I can skip run-time discovery phase (note 
> that the original driver was designed for other Kinetis-based boards too) 
> and move everything into DTS, somewhat like this:
> 
> / {
>         osc0: clock {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <50000000>;
>         };
> 
>         osc1: clock {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <12000000>;
>         };
> 
>         rtc: clock {
>                 compatible = "fixed-clock";
>                 #clock-cells = <0>;
>                 clock-frequency = <32768>;
>         };
> 
>         mcgout: clock {
>                 compatible = "fixed-factor-clock";
>                 #clock-cells = <0>;
>                 clocks = <&osc0>;
>                 clock-mult = <12>;
>                 clock-div = <5>;
>         };

I think this is a step backwards.

Did you look at the qcom clock binding and read the email where I
detailed how that binding works?

The point of that type of binding is to not shove per-clock data into
DT, but instead to declare every clock controller IP block (e.g. the
device) as well as every board-level clock (e.g. as osc that feeds into
your mcu). Once these "clock providers" are enumerated in DT, then we
create linkage between the clock providers and the clock consumers by
using phandles + an index. Linux device drivers tap into this by using
clk_get() and using the "clock-names" property from DT.

Put another way: we mostly use DT to model "devices". That is open to
interpretation for but for clock-related stuff we typically interpret
the clock controller as the device, not the individual clock outputs
coming out of the controller.

Note that a clock controller IP block may be both a provider and a
consumer.  I/O controllers are a very common type of consumer (e.g. USB
host controller, MMC controller, GPU, etc).

Additionally, from my reading of the reference manual, mcgout is defined
as:

"""
MCG output of either IRC, MCGFLLCLK MCGPLL0CLK,
MCGPLL1CLK, or MCG's external reference clock that
sources the core, system, bus, FlexBus, and flash clock. It is
also an option for the debug trace clock.
"""

So why is it listed here as a fixed-factor clock? Is it not a
multiplexer? Also, why is it listed here at all? Please take another
look at the qcom binding example I linked to in my previous mail.

> 
>         core: clock {
>                 compatible = "fixed-factor-clock";
>                 #clock-cells = <0>;
>                 clocks = <&mcgout>;
>                 clock-mult = <1>;
>                 clock-div = <1>;
>         };
> 
>         bus: clock {
>                 compatible = "fixed-factor-clock";
>                 #clock-cells = <0>;
>                 clocks = <&mcgout>;
>                 clock-mult = <1>;
>                 clock-div = <2>;

These are actually not fixed dividers but programmable dividers. You can
probably use drivers/clk/clk-divider.c for these. I'm fine with using
fixed-dividers for the initial merge just to get things up and running
if that is your strategy, but you'll need to revisit them later on when
you need more flexible support for other boards.

Again, I'm not sure why these clocks are enumerated in DT. Why not just
enumerate your mcg clock controller and your sim clock controller? If
you want to be a perfectionist then it appears that there is an osc
clock controller upstream from the mcg controller as well ;-)

It occurs to me that maybe you are trying to use fixed-factor clocks so
that you can program a sane default rate? We use the
assigned-clock-rates property for that. Note that this value is a
property of some device which *consumes* the clock, not the clock
controller or the clock output itself.

>         };
> 
>         soc {
>                 cmu@0x40047000 {
>                         compatible = "fsl,kinetis-gate-clock";
>                         reg = <0x40047000 0x1100>;
> 
>                         mcg_core_gate: clock-gate {
>                                 clocks = <&core>;
>                                 #clock-cells = <2>;
>                         };
> 
>                         mcg_bus_gate: clock-gate {
>                                 clocks = <&bus>;
>                                 #clock-cells = <2>;
>                         };
> 
>                         osc0_erclk_gate: clock-gate {
>                                 clocks = <&osc0>;
>                                 #clock-cells = <2>;
>                         };
>                 };
> 
>                 uart0: serial@4006a000 {
>                         compatible = "fsl,kinetis-lpuart";
>                         reg = <0x4006a000 0x1000>;
>                         interrupts = <45>, <46>;
>                         interrupt-names = "uart-stat", "uart-err";
>                         clocks = <&mcg_core_gate 3 10>;

Magic numbers are not good. dtc has been able to use preprocessor macros
for a while now which means we can use constants instead of magic
numbers. Please look at the shared header in the qcom binding for an
example.

>                         clock-names = "ipg";
>                         dmas = <&edma 0 2>;
>                         dma-names = "rx";
>                         status = "disabled";
>                 };
>         };
> };
> 
> As you can see, mcg part is not required anymore.

I think the mcg should be required. The mcg is a real IP block on your
SoC, according to my reading of your technical reference manual. Just
because you can model a few of its output clocks in dts does not mean
that you should.

I did a quick grep and didn't find "cmu" anywhere in the reference
manual.

> 
> I guess that the approach above would require split into soc-specific and 
> board-specific part (as I said, dividers arrangement is something board 
> specific), but I wonder what you thing about this proposal.

Splitting is good. Chip-specific stuff can go into the chip-specific
dtsi file. The board-level (osc) stuff can go into the individual board
files. The ultimate goal is to make it trivial to add new boards.

Regards,
Mike

> 
> Thanks,
> Paul
> 
> On Thu, 23 Jul 2015, Michael Turquette wrote:
> 
> > Quoting Paul Osmialowski (2015-07-04 14:50:03)
> > > Hi Arnd,
> > > 
> > > I'm attaching excerpt from Kinetis reference manual that may make 
> > > situation clearer.
> > 
> > Hi Paul,
> > 
> > Can you please post the patch in the body of the email instead of an
> > attachment? It makes it easier to review. Another small nitpick is that
> > the $SUBJECT for this patch might be better off as something like:
> > 
> > clk: mcg and sim clock drivers for twr-k70f120m Kinetis SoC
> > 
> > At least it helps me find the patch I care about when skimming the
> > series ;-)
> > 
> > > 
> > > These MCG and SIM registers are used only to determine configuration 
> > > (clock fixed rates and clock signal origins) at run time.
> > > 
> > > Namely, the real MCGOUTCLK source (in the middle) which is the parent for 
> > > core clock (CCLK) and peripheral clock (PCLK) is determined at run time by 
> > > reading MCG registers, let me quote commit message from Emcraft git repo:
> > > 
> > >       * Determine in run-time what oscillator module (OSC0 or OSC1) is used
> > >      as clock source for the main PLL.
> > 
> > According to [0] there are three options: a 32k RTC osc clock and osc0
> > both feed into a mux. You should model this 32k clock with the
> > fixed-rate binding.
> > 
> > >       * When OSC1 is selected, assume its frequency to be 12 MHz on all
> > >      boards (there is a 12 MHz oscillator on XTAL1/EXTAL1 on K70-SOM and
> > >      TWR-K70F120M boards).
> > > 
> > > In my .dts I'm trying to possibly follow real clock hierarchy, but to go 
> > > anywhere behind MCGOUTCLK would require ability to rewrite .dtb e.g. by 
> > > U-boot. But that's too demanding for any potential users of this BSP. So 
> > > let's asume that MCGOUTCLK is the root clock and a parent for CCLK and 
> > > PCLK.
> > 
> > I'm confused. The point of device tree is to solve problems like this;
> > i.e. board-specific differences such as different oscillator
> > frequencies.
> > 
> > OSC0 and OSC1 should each be a fixed-rate clock in your board-specific
> > TWR-K70F120M DTS (not a chip-specific file). They do not belong in the
> > cmu node, and they should use the "fixed-clock" binding. The 32k RTC osc
> > can probably go in your chip-specific .dtsi as a fixed-rate clock since
> > it appears to mandated in the reference manual[0].
> > 
> > These three fixed-rate clocks are your root clock nodes. Customers only
> > need to worry about this if they spin a board, and then they will need
> > to populate the frequencies of OSC0 and OSC1 in their board-specific
> > .dts.
> > 
> > Please break clk-kinetis.c into two files:
> > drivers/clk/kinetis/clk-mcg.c
> > drivers/clk/kinetis/clk-sim.c
> > 
> > Below is what your binding/dts should look like:
> > 
> > {
> >       osc0: clock {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> >               clock-frequency = <50000000>;
> >       };
> > 
> >       osc1: clock {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> >               clock-frequency = <12000000>;
> >       };
> > 
> >       rtc: clock {
> >               compatible = "fixed-clock";
> >               #clock-cells = <0>;
> >               clock-frequency = <32768>;
> >       };
> > 
> >       soc: soc {
> >               mcg: clock-controller@40064000 {
> >                       compatible = "fsl,kinetis-mcg";
> >                       clock-cells = <1>;
> >                       reg = <0x40064000 0x14>;
> >                       clocks = <&osc0>, <&osc1>, <&rtc>;
> >                       clock-names = "osc0", "osc1", "rtc";
> >               };
> > 
> >               sim: clock-controller@40047000 {
> >                       compatible = "fsl,kinetis-sim";
> >                       clock-cells = <1>;
> >                       reg = <0x40047000 0x1100>;
> >                       clocks = <&mcg MCG_MCGOUTCLK_DIV1>, <&mcg MCG_MCGOUTCLK_DIV2>, <&mcg MCG_MCGOUTCLK_DIV3> <&mcg MCG_MCGOUTCLK_DIV4>;
> >                       clock-names = "core", "bus", "flexbus", "flash";
> >               };
> >       };
> > 
> >       uart0: serial@4006a000 {
> >               compatible = "fsl,kinetis-lpuart";
> >               reg = <0x4006a000 0x1000>;
> >               clocks = <&sim SIM_SCGC4_UART1_CLK>;
> >               clock-names = "gate";
> >       };
> > 
> > I removed the interrupts and dma stuff from the uart0 node for clarity.
> > The above is the only style of binding that I have been accepting for
> > some time; first declare the clock controller and establish its register
> > space, and then consumers can consume clocks by providing the phandle to
> > the controller plus an offset corresponding to a unique clock. The
> > clock-names property makes it really easy to use with the clkdev stuff
> > (e.g. clk_get()).
> > 
> > I've covered this before on the mailing list so here is a link
> > describing how the qcom bindings do it in detail:
> > 
> > http://lkml.kernel.org/r/<20150416192014.19585.9663@quantum>
> > 
> > Technically you could encode the same bits as sub-nodes of the mcg and
> > sim nodes, but the shared header is how the magic happens with the
> > driver so it's best to keep the clock controller binding small and
> > light.
> > 
> > I think this means you can also get rid of kinetis_of_clk_get_name and
> > kinetis_clk_gate_get but my brain is tired so I'll leave that as an
> > exercise to the reader.
> > 
> > [0] http://cache.freescale.com/files/microcontrollers/doc/ref_manual/K70P256M150SF3RM.pdf
> > 
> > Regards,
> > Mike
> > 
> > > 
> > > In my most recent version I added OSC0ERCLK explicitly as one more root 
> > > clock, since it is also used directly (through CG reg. 1 bit 0) by 
> > > Freescale fec network device whose in-tree driver I'm trying to make 
> > > usable for Kinetis.
> > > 
> > > On Sat, 4 Jul 2015, Arnd Bergmann wrote:
> > > 
> > > > On Friday 03 July 2015 00:08:27 Thomas Gleixner wrote:
> > > >> On Thu, 2 Jul 2015, Paul Osmialowski wrote:
> > > >>> On Thu, 2 Jul 2015, Arnd Bergmann wrote:
> > > >>>
> > > >>>> I wonder if you could move out the fixed rate clocks into their own
> > > >>>> nodes. Are they actually controlled by the same block? If they are
> > > >>>> just fixed, you can use the normal binding for fixed rate clocks
> > > >>>> and only describe the clocks that are related to the driver.
> > > >>>
> > > >>> In my view having these clocks grouped together looks more convincing. After
> > > >>> all, they all share the same I/O regs in order to read configuration.
> > > >>
> > > >> The fact that they share a register is not making them a group. That's
> > > >> just a HW design decision and you need to deal with that by protecting
> > > >> the register access, but not by trying to group them artificially at
> > > >> the functional level.
> > > >
> > > > I'd disagree with that: The clock controller is the device that owns the
> > > > registers and that should be one node in DT, as Paul's first version does.
> > > >
> > > > The part I'm still struggling with is understanding how the fixed-rate
> > > > clocks are controlled through those registers. If they are indeed configured
> > > > through the registers, the name is probably wrong and should be changed
> > > > to whatever kind of non-fixed clock this is.
> > > >
> > > >       Arnd
> > > >
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
