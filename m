From: Josh Cartwright <josh.cartwright@ni.com>
Subject: Re: [PATCH 5/8] ARM: zynq: add COMMON_CLK support
Date: Fri, 2 Nov 2012 07:38:50 -0600
Message-ID: <20121102133850.GO5190@beefymiracle.amer.corp.natinst.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
 <94af5ee92c2d68f245eb902de74909aadf159be1.1351721190.git.josh.cartwright@ni.com>
 <50939378.2050500@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <50939378.2050500@metafoo.de>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michal Simek <monstr@monstr.eu>, Russell King <linux@arm.linux.org.uk>, John Stultz <johnstul@us.ibm.com>, devicetree-discuss@lists.ozlabs.org, Michal Simek <michal.simek@xilinx.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, John Linn <John.Linn@xilinx.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>
List-Id: linux-serial@vger.kernel.org

Thanks for the review.

On Fri, Nov 02, 2012 at 10:33:44AM +0100, Lars-Peter Clausen wrote:
> On 10/31/2012 07:58 PM, Josh Cartwright wrote:
> > [...]
> > +#define PERIPH_CLK_CTRL_SRC(x)	(periph_clk_parent_map[((x)&3)>>4])
> > +#define PERIPH_CLK_CTRL_DIV(x)	(((x)&0x3F00)>>8)
> 
> A few more spaces wouldn't hurt ;)

Okay, sure.

> > [...]
> > +static void __init zynq_periph_clk_setup(struct device_node *np)
> > +{
> > +	struct zynq_periph_clk *periph;
> > +	const char *parent_names[3];
> > +	struct clk_init_data init;
> > +	struct clk *clk;
> > +	int err;
> > +	u32 reg;
> > +	int i;
> > +
> > +	err = of_property_read_u32(np, "reg", &reg);
> > +	WARN_ON(err);
>
> Shouldn't the function abort if a error happens somewhere? Continuing here
> will lead to undefined behavior. Same is probably true for the other WARN_ONs.

The way I see it is: the kernel is will be left in a bad state in the
case of any failure, regardless of if we bail out or continue.  AFAICT,
there is no clean way to recover from a failure this early.

Given that, it seems simpler (albeit marginally so) just to continue; so
that's what I chose to do.  I'm not opposed to bailing out, just not
convinced it does anything for us.

> > +
> > +	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
> > +	WARN_ON(!periph);
> > +
> > +	periph->clk_ctrl = slcr_base + reg;
> > +	spin_lock_init(&periph->clkact_lock);
> > +
> > +	init.name = np->name;
> > +	init.ops = &zynq_periph_clk_ops;
> > +	for (i = 0; i < ARRAY_SIZE(parent_names); i++)
> > +		parent_names[i] = of_clk_get_parent_name(np, i);
> > +	init.parent_names = parent_names;
> > +	init.num_parents = ARRAY_SIZE(parent_names);
> > +
> > +	periph->hw.init = &init;
> > +
> > +	clk = clk_register(NULL, &periph->hw);
> > +	WARN_ON(IS_ERR(clk));
> > +
> > +	err = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> > +	WARN_ON(err);
> > +
> > +	for (i = 0; i < 2; i++) {
> 
> Not all of the peripheral clock generators have two output clocks. I think
> it makes sense to use the number entries in clock-output-names here.

Yes, I agree.  I'll also update the bindings documentation.

Thanks again,
  Josh
