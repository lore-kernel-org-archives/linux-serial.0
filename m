From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/8] ARM: zynq: add COMMON_CLK support
Date: Fri, 02 Nov 2012 10:33:44 +0100
Message-ID: <50939378.2050500@metafoo.de>
References: <cover.1351721190.git.josh.cartwright@ni.com> <94af5ee92c2d68f245eb902de74909aadf159be1.1351721190.git.josh.cartwright@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out-184.synserver.de ([212.40.185.184]:1205 "EHLO
	smtp-out-184.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637Ab2KBJeC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Nov 2012 05:34:02 -0400
In-Reply-To: <94af5ee92c2d68f245eb902de74909aadf159be1.1351721190.git.josh.cartwright@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Josh Cartwright <josh.cartwright@ni.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Linn <John.Linn@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On 10/31/2012 07:58 PM, Josh Cartwright wrote:
> [...]
> +#define PERIPH_CLK_CTRL_SRC(x)	(periph_clk_parent_map[((x)&3)>>4])
> +#define PERIPH_CLK_CTRL_DIV(x)	(((x)&0x3F00)>>8)

A few more spaces wouldn't hurt ;)

> [...]
> +static void __init zynq_periph_clk_setup(struct device_node *np)
> +{
> +	struct zynq_periph_clk *periph;
> +	const char *parent_names[3];
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	int err;
> +	u32 reg;
> +	int i;
> +
> +	err = of_property_read_u32(np, "reg", &reg);
> +	WARN_ON(err);

Shouldn't the function abort if a error happens somewhere? Continuing here
will lead to undefined behavior. Same is probably true for the other WARN_ONs.

> +
> +	periph = kzalloc(sizeof(*periph), GFP_KERNEL);
> +	WARN_ON(!periph);
> +
> +	periph->clk_ctrl = slcr_base + reg;
> +	spin_lock_init(&periph->clkact_lock);
> +
> +	init.name = np->name;
> +	init.ops = &zynq_periph_clk_ops;
> +	for (i = 0; i < ARRAY_SIZE(parent_names); i++)
> +		parent_names[i] = of_clk_get_parent_name(np, i);
> +	init.parent_names = parent_names;
> +	init.num_parents = ARRAY_SIZE(parent_names);
> +
> +	periph->hw.init = &init;
> +
> +	clk = clk_register(NULL, &periph->hw);
> +	WARN_ON(IS_ERR(clk));
> +
> +	err = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +	WARN_ON(err);
> +
> +	for (i = 0; i < 2; i++) {

Not all of the peripheral clock generators have two output clocks. I think
it makes sense to use the number entries in clock-output-names here.

> +		const char *name;
> +
> +		err = of_property_read_string_index(np, "clock-output-names", i,
> +						    &name);
> +		WARN_ON(err);
> +
> +		periph->gates[i] = clk_register_gate(NULL, name, np->name, 0,
> +						     periph->clk_ctrl, i, 0,
> +						     &periph->clkact_lock);
> +		WARN_ON(IS_ERR(periph->gates[i]));
> +	}
> +
> +	periph->onecell_data.clks = periph->gates;
> +	periph->onecell_data.clk_num = i;
> +
> +	err = of_clk_add_provider(np, of_clk_src_onecell_get,
> +				  &periph->onecell_data);
> +	WARN_ON(err);
> +}
> [...]

