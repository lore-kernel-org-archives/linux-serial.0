From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/9] arm: twr-k70f120m: clock driver for Kinetis SoC
Date: Sat, 04 Jul 2015 21:54:12 +0200
Message-ID: <2009463.YLtdMegFel@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <alpine.LNX.2.00.1507022338070.28322@localhost.localdomain>
 <alpine.DEB.2.11.1507030006280.3916@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.11.1507030006280.3916@nanos>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <r.herring@freescale.com>, Alexander Potashev <aspotashev@emcraft.com>, Frank Li <Frank.Li@freescale.com>, Jiri Slaby <jslaby@suse.cz>, linux-clk@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Anson Huang <b20788@freescale.com>, Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, Paul Osmialowski <pawelo@king.net.pl>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Yuri Tikhonov <yur@emcraft.com>, linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutro>
List-Id: linux-serial@vger.kernel.org

On Friday 03 July 2015 00:08:27 Thomas Gleixner wrote:
> On Thu, 2 Jul 2015, Paul Osmialowski wrote:
> > On Thu, 2 Jul 2015, Arnd Bergmann wrote:
> > 
> > > I wonder if you could move out the fixed rate clocks into their own
> > > nodes. Are they actually controlled by the same block? If they are
> > > just fixed, you can use the normal binding for fixed rate clocks
> > > and only describe the clocks that are related to the driver.
> > 
> > In my view having these clocks grouped together looks more convincing. After
> > all, they all share the same I/O regs in order to read configuration.
> 
> The fact that they share a register is not making them a group. That's
> just a HW design decision and you need to deal with that by protecting
> the register access, but not by trying to group them artificially at
> the functional level.

I'd disagree with that: The clock controller is the device that owns the
registers and that should be one node in DT, as Paul's first version does.

The part I'm still struggling with is understanding how the fixed-rate
clocks are controlled through those registers. If they are indeed configured
through the registers, the name is probably wrong and should be changed
to whatever kind of non-fixed clock this is.

	Arnd
