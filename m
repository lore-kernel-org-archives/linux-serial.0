From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v2 05/11] pinctrl:stixxxx: Add pinctrl and pinconf support.
Date: Mon, 17 Jun 2013 14:31:46 +0100
Message-ID: <51BF0FC2.4000601@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856161-6600-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdYN-6W8tvbWNVOdCKOWObm3PCtzXqZuUnvHddBtyw2pyQ@mail.gmail.com>
Reply-To: srinivas.kandagatla@st.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYN-6W8tvbWNVOdCKOWObm3PCtzXqZuUnvHddBtyw2pyQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Stephen Gallimore <stephen.gallimore@st.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Stuart Menefy <stuart.menefy@st.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Olof Johansson <olof@lixom.>
List-Id: linux-serial@vger.kernel.org

Thankyou very much for the comments.

On 16/06/13 13:17, Linus Walleij wrote:
> On Mon, Jun 10, 2013 at 11:22 AM, Srinivas KANDAGATLA
> <srinivas.kandagatla@st.com> wrote:
> 
>> About driver:
>> This pinctrl driver manages both PIO and PIO-mux block using pinctrl,
>> pinconf, pinmux, gpio subsystems. All the pinctrl related config
>> information can only come from device trees.
> 
> OK that's a good approach!
Thankyou
>> +- #gpio-cells    : Should be one. The first cell is the pin number.
>> +- st,retime-in-delay   : Should be array of delays in nsecs.
>> +- st,retime-out-delay  : Should be array of delays in nsecs.
> 
> Please explain more verbosely what is meant by these
> delays. in-delay of what? out-delay of what?
> 

Am moving this to the driver too, as these tend to be constant per given
SOC.

>> +- st,retime-pin-mask   : Should be mask to specify which pins can be retimed.
> 
> Explain what this "retimed" means.
I will explain this bit in more detail.

> 
>> +- st,bank-name         : Should be a name string for this bank.
> 
> Usually we only use an identifier, like a number for this, but
> maybe you need this, so won't judge on it.

It's used for maintaining consistency with pin names from data sheet to
the pinctrl_pin_desc.

> 
>> +- st,syscfg            : phandle of the syscfg node.
> 
> This is pretty clever.
Thankyou.
> 
>> +- st,syscfg-offsets    : Should be a 5 cell entry which represent offset of altfunc,
>> +       output-enable, pull-up , open drain and retime registers in the syscfg bank
> 
> No please. Use the compatible string to determine which version of the
> hardware this is and encode a register offset table into the driver instead.
> We do not store register offsets in the device tree, it is not a datasheet
> XML container you know...

Got it, I already moved this to the driver now. And its looking good.

> 
>> +- delay        is retime delay in pico seconds.
>> +               Possible values are: refer to retime-in/out-delays
> 
> Earlier it was given in nanoseconds.
> 
 I will fix this.

> And I still have no clue what "retiming" means.
> 
> I'm suspecting you cannot actually use generic pinconfig
> due to all this retiming esoterica but atleast give it a thought.
> 
>> +- rt_clk       :clk to be use for retime.
>> +               Possible values are:
>> +               CLK_A
>> +               CLK_B
>> +               CLK_C
>> +               CLK_D
> 
> So this is selecting one of four available clock lines?
> 
No, It's not related to driver clocks.
It's to do with the retiming. This part configures which clock to retime
output/input data to. CLK_A means retime output data to clkout[0] and
input data on clkin[0].

Will add more documentation on re-timing in general.


> Should this not interact with some clk bindings for your
> clock tree?
> 
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>> index 8f66924..0c040a3 100644
>> --- a/drivers/pinctrl/Kconfig
>> +++ b/drivers/pinctrl/Kconfig
>> @@ -169,6 +169,17 @@ config PINCTRL_SUNXI
>>         select PINMUX
>>         select GENERIC_PINCONF
>>
>> +config PINCTRL_STIXXXX
> 
> As mentioned elsewhere STIXXXX is a bit too much X:es in.
> Please come up with some better naming if possible.

Are you OK if I use pinctrl-st.c?

> 
>> +       bool "ST Microelectronics pin controller driver for STixxxx SoCs"
> 
> Add:
> depends on OF

Ok, Will add it.
> 
>> +       select PINMUX
>> +       select PINCONF
>> +       help
>> +         Say yes here to support pinctrl interface on STixxxx SOCs.
>> +         This driver is used to control both PIO block and PIO-mux
>> +         block to configure a pin.
>> +
>> +         If unsure, say N.
> 
> (...)
>> +++ b/drivers/pinctrl/pinctrl-stixxxx.c

>> +struct stixxxx_gpio_port {
>> +       struct gpio_chip        gpio_chip;
>> +       struct pinctrl_gpio_range range;
>> +       void __iomem            *base;
>> +       struct device_node      *of_node;
> 
> Why do you need this? The struct gpio_chip above can contain
> the of_node can it not?

I remove the of_node as part of "simple-bus" cleanup from the pinctrl node.

> 
>> +       const char              *bank_name;
>> +};
> 
>> +static struct stixxxx_gpio_port *gpio_ports[STIXXXX_MAX_GPIO_BANKS];
> 
> This is complicating things. Can't you just store the array of GPIO ports
> *inside* the struct stixxxx_pinctrl container or something?

Already taken care from previous comment.

> 
> (...)
>> +/* Low level functions.. */
>> +static void stixxxx_pinconf_set_direction(struct stixxxx_pio_control *pc,
>> +                               int pin_id, unsigned long config)
> 
> Why is this function called "*_set_direction" when it is also
> messing with PU and OD?
> 
> _set_config would be more appropriate.

Yes, I will rename it.
> 
> (The code looks fine.)
> 
> (...)
>> +static void stixxxx_pinconf_set_retime_packed(
>> +               struct stixxxx_pio_control *pc,
>> +               unsigned long config, int pin)
>> +{
>> +       const struct stixxxx_retime_params *rt_params = pc->rt_params;
>> +       const struct stixxxx_retime_offset *offset = rt_params->retime_offset;
>> +       struct regmap_field **regs;
>> +       unsigned int values[2];
>> +       unsigned long mask;
>> +       int i, j;
>> +       int clk = STIXXXX_PINCONF_UNPACK_RT_CLK(config);
>> +       int clknotdata = STIXXXX_PINCONF_UNPACK_RT_CLKNOTDATA(config);
>> +       int double_edge = STIXXXX_PINCONF_UNPACK_RT_DOUBLE_EDGE(config);
>> +       int invertclk = STIXXXX_PINCONF_UNPACK_RT_INVERTCLK(config);
>> +       int retime = STIXXXX_PINCONF_UNPACK_RT(config);
>> +       unsigned long delay = stixxxx_pinconf_delay_to_bit(
>> +                       STIXXXX_PINCONF_UNPACK_RT_DELAY(config),
>> +                       pc->rt_params, config);
> 
> As you can see it's a bit excess of "X" above. Hard to read.
> 
> Then it seems like some of these should be bool, because:

Ok, Will make it bool.

> 
>> +       unsigned long rt_cfg =
>> +               ((clk           & 1) << offset->clk1notclk0_offset) |
>> +               ((clknotdata    & 1) << offset->clknotdata_offset) |
>> +               ((delay         & 1) << offset->delay_lsb_offset) |
>> +               (((delay >> 1)  & 1) << offset->delay_msb_offset) |
>> +               ((double_edge   & 1) << offset->double_edge_offset) |
>> +               ((invertclk     & 1) << offset->invertclk_offset) |
>> +               ((retime        & 1) << offset->retime_offset);
> 
> This is looking strange. Just strange.
> Comments are needed I think. For example why
> arey >> 1 on delay all of a sudden?
> 
> I would try to make clk, clknotdata, delay etc into bools.
> 
> Then it could be more readable like this:
> 
> #include <linux/bitops.h>
> 
> unsigned long rt_cfg = 0;
> 
> if (clk)
>     rt_cfg |= BIT(offset->clk1notclk0_offset);
> if (clknotdata)
>     rt_cfg |= BIT(offset->clknotdata_offset);
> 
> etc.

Yes, Looks sensible, I will try these changes and see how it turns up.

> 
>> +       regs = pc->retiming;
>> +       regmap_field_read(regs[0], &values[0]);
>> +       regmap_field_read(regs[1], &values[1]);
>> +
>> +       for (i = 0; i < 2; i++) {
>> +               mask = BIT(pin);
>> +               for (j = 0; j < 4; j++) {
>> +                       if (rt_cfg & 1)
>> +                               values[i] |= mask;
>> +                       else
>> +                               values[i] &= ~mask;
>> +                       mask <<= 8;
>> +                       rt_cfg >>= 1;
>> +               }
>> +       }
> 
> 2? 4? 8? Not quite readable with so many magic constants.
> Is this "8" identical to STIXXXX_GPIO_PINS_PER_PORT?
> 
I agree, all these constants should be #defined in a readable way, and I
will do it. (for all the comments related to constants ...)

> 
>> +static int stixxxx_pinconf_get_retime_packed(
>> +               struct stixxxx_pio_control *pc,
>> +               int pin, unsigned long *config)
>> +{
>> +       const struct stixxxx_retime_params *rt_params = pc->rt_params;
>> +       const struct stixxxx_retime_offset *offset = rt_params->retime_offset;
>> +       unsigned long delay_bits, delay, rt_reduced;
>> +       unsigned int rt_value[2];
>> +       int i, j;
>> +       int output = STIXXXX_PINCONF_UNPACK_OE(*config);
>> +
>> +       regmap_field_read(pc->retiming[0], &rt_value[0]);
>> +       regmap_field_read(pc->retiming[1], &rt_value[1]);
>> +
>> +       rt_reduced = 0;
>> +       for (i = 0; i < 2; i++) {
>> +               for (j = 0; j < 4; j++) {
>> +                       if (rt_value[i] & (1<<((8*j)+pin)))
>> +                               rt_reduced |= 1 << ((i*4)+j);
>> +               }
>> +       }
> 
> Urgh 2, 4, 8??
> 
> What is happening here ... atleast a big comment
> explaining the logic would be helpful. Some kind of
> matrix traversal seem to be involved.

Yes, I will add a decent comment here.

> 
>> +       STIXXXX_PINCONF_PACK_RT(*config,
>> +                       (rt_reduced >> offset->retime_offset) & 1);
>> +       STIXXXX_PINCONF_PACK_RT_CLK(*config,
>> +                       (rt_reduced >> offset->clk1notclk0_offset) & 1);
>> +       STIXXXX_PINCONF_PACK_RT_CLKNOTDATA(*config,
>> +                       (rt_reduced >> offset->clknotdata_offset) & 1);
>> +       STIXXXX_PINCONF_PACK_RT_DOUBLE_EDGE(*config,
>> +                       (rt_reduced >> offset->double_edge_offset) & 1);
>> +       STIXXXX_PINCONF_PACK_RT_INVERTCLK(*config,
>> +                       (rt_reduced >> offset->invertclk_offset) & 1);
> 
> I would rewrite this like
> 
> if ((rt_reduced >> offset->retime_offset) & 1)
>    STIXXXX_PINCONF_PACK_RT(*config, 1);
> 
> See further comments on these macros below.
> 
> I prefer if they are only used to set bits to 1, then it just becomes:
> 
> if ((rt_reduced >> offset->retime_offset) & 1)
>    STIXXXX_PINCONF_PACK_RT(*config);
> 
> Simpler.

I will do it.
> 
> 
> (...)
>> +static void stixxxx_gpio_direction(unsigned int gpio, unsigned int direction)
>> +{
>> +       int port_num = stixxxx_gpio_port(gpio);
>> +       int offset = stixxxx_gpio_pin(gpio);
>> +       struct stixxxx_gpio_port *port  = gpio_ports[port_num];
>> +       int i = 0;
>> +
>> +       for (i = 0; i <= 2; i++) {
>> +               if (direction & BIT(i))
>> +                       writel(BIT(offset), port->base + REG_PIO_SET_PC(i));
>> +               else
>> +                       writel(BIT(offset), port->base + REG_PIO_CLR_PC(i));
>> +       }
> 
> Can you explain here in a comment why the loop has to hit
> bits 0, 1 and 2 in this register?

Yes, I will add the comments behind the logic of this.

> 
> (...)
>> +static int stixxxx_gpio_get(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       struct stixxxx_gpio_port *port = to_stixxxx_gpio_port(chip);
>> +
>> +       return (readl(port->base + REG_PIO_PIN) >> offset) & 1;
> 
> Usually we do this with the double-bang idiom:
> 
> return !!(readl(port->base + REG_PIO_PIN) & BIT(offset));

Interesting and very neat.

> 
>> +static void stixxxx_pctl_dt_free_map(struct pinctrl_dev *pctldev,
>> +                               struct pinctrl_map *map, unsigned num_maps)
>> +{
>> +}
> 
> Isn't this optional? And don't you need to free this?
> 
Its not optional because pinctrl_check_ops returns -EINVAL if set to NULL.

I don't need to free it because its a devm_kzalloc.

> (...)
>> +static void stixxxx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
>> +                                  struct seq_file *s, unsigned pin_id)
>> +{
>> +       unsigned long config;
>> +       stixxxx_pinconf_get(pctldev, pin_id, &config);
>> +
>> +       seq_printf(s, "[OE:%ld,PU:%ld,OD:%ld]\n"
>> +               "\t\t[retime:%ld,invclk:%ld,clknotdat:%ld,"
>> +               "de:%ld,rt-clk:%ld,rt-delay:%ld]",
>> +               STIXXXX_PINCONF_UNPACK_OE(config),
>> +               STIXXXX_PINCONF_UNPACK_PU(config),
>> +               STIXXXX_PINCONF_UNPACK_OD(config),
>> +               STIXXXX_PINCONF_UNPACK_RT(config),
>> +               STIXXXX_PINCONF_UNPACK_RT_INVERTCLK(config),
>> +               STIXXXX_PINCONF_UNPACK_RT_CLKNOTDATA(config),
>> +               STIXXXX_PINCONF_UNPACK_RT_DOUBLE_EDGE(config),
>> +               STIXXXX_PINCONF_UNPACK_RT_CLK(config),
>> +               STIXXXX_PINCONF_UNPACK_RT_DELAY(config));
>> +}
> 
> This looks real nice, but is the output human-friendly?

I will see, If I can come up with a better format.

> Well maybe the format needs to be compact like this...
> 
>> +       if (of_device_is_compatible(np, "st,stih415-pinctrl")) {
>> +               rt_offset = devm_kzalloc(info->dev,
>> +                       sizeof(*rt_offset), GFP_KERNEL);
>> +
>> +               if (!rt_offset)
>> +                       return -ENOMEM;
>> +
>> +               rt_offset->clk1notclk0_offset = 0;
>> +               rt_offset->delay_lsb_offset = 2;
>> +               rt_offset->delay_msb_offset = 3;
>> +               rt_offset->invertclk_offset = 4;
>> +               rt_offset->retime_offset = 5;
>> +               rt_offset->clknotdata_offset = 6;
>> +               rt_offset->double_edge_offset = 7;
> 
> This looks awkward and complicated.
> 
> Why not just #define these offsets and use them
> directly in the code?

This is more specific to a SOC.
This information now comes as part of the SOC specific compatible node data.

Like this:

const struct stixxxx_retime_offset stih415_retime_offset = {
	.clk1notclk0_offset	= 0,
	.delay_lsb_offset	= 2,
	.delay_msb_offset	= 3,
	.invertclk_offset	= 4,
	.retime_offset		= 5,
	.clknotdata_offset	= 6,
	.double_edge_offset	= 7,
};

unsigned int stih415_input_delays[] = {0, 500, 1000, 1500};
unsigned int stih415_output_delays[] = {0, 1000, 2000, 3000};

static const struct stixxxx_pctl_data  stih415_sbc_data = {
	.rt_style 	= stixxxx_retime_style_packed,
	.rt_offset 	= &stih415_retime_offset,
	.input_delays 	= stih415_input_delays,
	.ninput_delays	= 4,
	.output_delays = stih415_output_delays,
	.noutput_delays = 4,
	.alt = 0, .oe = 5, .pu = 7, .od = 9, .rt = 16,
};
static struct of_device_id stixxxx_pctl_of_match[] = {
	{ .compatible = "st,stih415-sbc-pinctrl", .data = &stih415_sbc_data },
	};

> 
>> +static int stixxxx_pctl_dt_init(struct stixxxx_pinctrl *info,
>> +                       struct device_node *np)
>> +{
>> +       struct stixxxx_pio_control *pc;
>> +       struct stixxxx_retime_params *rt_params;
>> +       struct device *dev = info->dev;
>> +       struct regmap *regmap;
>> +       unsigned int i = 0;
>> +       struct device_node *child = NULL;
>> +       u32 alt_syscfg, oe_syscfg, pu_syscfg, od_syscfg, rt_syscfg;
>> +       u32 syscfg_offsets[5];
>> +       u32 msb, lsb;
>> +
>> +       pc = devm_kzalloc(dev, sizeof(*pc) * info->nbanks, GFP_KERNEL);
>> +       rt_params = devm_kzalloc(dev, sizeof(*rt_params), GFP_KERNEL);
>> +
>> +       if (!pc || !rt_params)
>> +               return -ENOMEM;
>> +
>> +       regmap = syscfg_regmap_lookup_by_phandle(np, "st,syscfg");
>> +       if (!regmap) {
>> +               dev_err(dev, "No syscfg phandle specified\n");
>> +               return -ENOMEM;
>> +       }
>> +       info->regmap = regmap;
>> +       info->pio_controls = pc;
>> +       if (stixxxx_pinconf_dt_parse_rt_params(info, np, rt_params))
>> +               return -ENOMEM;
>> +
>> +       if (of_property_read_u32_array(np, "st,syscfg-offsets",
>> +                               syscfg_offsets, 5)) {
>> +               dev_err(dev, "Syscfg offsets not found\n");
>> +               return -EINVAL;
>> +       }
>> +       alt_syscfg = syscfg_offsets[0];
>> +       oe_syscfg = syscfg_offsets[1];
>> +       pu_syscfg = syscfg_offsets[2];
>> +       od_syscfg = syscfg_offsets[3];
>> +       rt_syscfg = syscfg_offsets[4];
> 
> This isn't looking any fun either.
> 
> #defining the offsets avoid all this strange boilerplate.
> 
>> +       lsb = 0;
>> +       msb = 7;
> 
> And this.
> 
>> +       for_each_child_of_node(np, child) {
>> +               if (of_device_is_compatible(child, gpio_compat)) {
>> +                       struct reg_field alt_reg =
>> +                                       REG_FIELD(4 * alt_syscfg++, 0, 31);
>> +                       struct reg_field oe_reg =
>> +                                       REG_FIELD(4 * oe_syscfg, lsb, msb);
>> +                       struct reg_field pu_reg =
>> +                                       REG_FIELD(4 * pu_syscfg, lsb, msb);
>> +                       struct reg_field od_reg =
>> +                                       REG_FIELD(4 * od_syscfg, lsb, msb);
>> +                       pc[i].rt_params = rt_params;
>> +
>> +                       pc[i].alt = devm_regmap_field_alloc(dev,
>> +                                                       regmap, alt_reg);
>> +                       pc[i].oe = devm_regmap_field_alloc(dev,
>> +                                                       regmap, oe_reg);
>> +                       pc[i].pu = devm_regmap_field_alloc(dev,
>> +                                                       regmap, pu_reg);
>> +                       pc[i].od = devm_regmap_field_alloc(dev,
>> +                                                       regmap, od_reg);
>> +
>> +                       if (IS_ERR(pc[i].alt) || IS_ERR(pc[i].oe)
>> +                               || IS_ERR(pc[i].pu) || IS_ERR(pc[i].od))
>> +                               goto failed;
>> +
>> +                       of_property_read_u32(child, "st,retime-pin-mask",
>> +                                               &pc[i].rt_pin_mask);
>> +
>> +                       stixxxx_pctl_dt_get_retime_conf(info, &pc[i],
>> +                                                       &rt_syscfg);
>> +                       i++;
>> +                       if (msb  == 31) {
>> +                               oe_syscfg++;
>> +                               pu_syscfg++;
>> +                               od_syscfg++;
>> +                               lsb = 0;
>> +                               msb = 7;
>> +                       } else {
>> +                               lsb += 8;
>> +                               msb += 8;
>> +                       }
> 
> Can you explain with a comment what is happening here.

Most of this code disappeared as part of merging gpio and pinctrl
platformdriver in to one.
However I will make sure I add more comments in this area.

> 
>> +static struct pinctrl_gpio_range *find_gpio_range(struct device_node *np)
>> +{
>> +       int i;
>> +       for (i = 0; i < STIXXXX_MAX_GPIO_BANKS; i++)
>> +               if (gpio_ports[i]->of_node == np)
>> +                       return &gpio_ports[i]->range;
>> +
>> +       return NULL;
>> +}
> 
> This looks a bit like it's duplicating pinctrl_find_gpio_range_from_pin()
> or similar already available from the pinctrl core. But it seems you
> may need it here in this case.
You are right, I should have used pinctrl_find_gpio_range_from_pin.

This code disappeared too as part of  merging gpio and pinctrl platform
driver in to one.


> 
>> +static int stixxxx_pctl_probe(struct platform_device *pdev)
> (...)
>> +static int stixxxx_gpio_probe(struct platform_device *pdev)
> (...)
>> +static struct of_device_id stixxxx_gpio_of_match[] = {
>> +       { .compatible = "st,stixxxx-gpio", },
>> +       { /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver stixxxx_gpio_driver = {
>> +       .driver = {
>> +               .name = "st-gpio",
>> +               .owner = THIS_MODULE,
>> +               .of_match_table = of_match_ptr(stixxxx_gpio_of_match),
>> +       },
>> +       .probe = stixxxx_gpio_probe,
>> +};
>> +
>> +static struct of_device_id stixxxx_pctl_of_match[] = {
>> +       { .compatible = "st,stixxxx-pinctrl",},
>> +       { .compatible = "st,stih415-pinctrl",},
>> +       { .compatible = "st,stih416-pinctrl",},
>> +       { /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver stixxxx_pctl_driver = {
>> +       .driver = {
>> +               .name = "st-pinctrl",
>> +               .owner = THIS_MODULE,
>> +               .of_match_table = of_match_ptr(stixxxx_pctl_of_match),
>> +       },
>> +       .probe = stixxxx_pctl_probe,
>> +};
> 
> 
> Why do you need separate nodes and probe functions for the
> pinctrl and GPIO? Can't you just have a single pinctrl node?
> 
>> +static int __init stixxxx_pctl_init(void)
>> +{
>> +       int ret = platform_driver_register(&stixxxx_gpio_driver);
>> +       if (ret)
>> +               return ret;
>> +       return platform_driver_register(&stixxxx_pctl_driver);
>> +}
> 
> Especially since you're just registering them after each other.
> 
> Maybe you could have the GPIO nodes as children inside  the
> pinctrl node and iterate over with for_each_child_of_node()?
> 
> I'm not requiring you rewrite this, just that you give it a thought.

Arnd suggested the same thing, and I have already done this change and
it did clean up lot of code and device tree too.
Now the device tree for pinctrl looks much simple.

	pin-controller-sbc {
			#address-cells	= <1>;
			#size-cells	= <1>;
			compatible	= "st,stih415-sbc-pinctrl";
			st,syscfg	= <&syscfg_sbc>;
			ranges 		= <0 0xfe610000 0x5000>;

			PIO0: gpio@fe610000 {
				gpio-controller;
				#gpio-cells	= <1>;
				reg		= <0 0x100>;
				st,bank-name	= "PIO0";
			};

			...
	};


> 
> (...)
>> +++ b/drivers/pinctrl/pinctrl-stixxxx.h
>> @@ -0,0 +1,197 @@
>> +
>> +/*
>> + * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
>> + * Authors:
>> + *     Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + */
>> +
>> +#ifndef __LINUX_DRIVERS_PINCTRL_STIXXXX_H
>> +#define __LINUX_DRIVERS_PINCTRL_STIXXXX_H
>> +
>> +enum stixxxx_retime_style {
>> +       stixxxx_retime_style_none,
>> +       stixxxx_retime_style_packed,
>> +       stixxxx_retime_style_dedicated,
>> +};
>> +
>> +/* Byte positions in 2 syscon words, starts from 0 */
>> +struct stixxxx_retime_offset {
>> +       int retime_offset;
>> +       int clk1notclk0_offset;
>> +       int clknotdata_offset;
>> +       int double_edge_offset;
>> +       int invertclk_offset;
>> +       int delay_lsb_offset;
>> +       int delay_msb_offset;
>> +};
>> +
>> +struct stixxxx_retime_params {
>> +       const struct stixxxx_retime_offset *retime_offset;
>> +       unsigned int *delay_times_in;
>> +       int num_delay_times_in;
>> +       unsigned int *delay_times_out;
>> +       int num_delay_times_out;
>> +};
>> +
>> +struct stixxxx_pio_control {
>> +       enum stixxxx_retime_style rt_style;
>> +       u32 rt_pin_mask;
>> +       const struct stixxxx_retime_params *rt_params;
>> +       struct regmap_field *alt;
>> +       struct regmap_field *oe, *pu, *od;
>> +       struct regmap_field *retiming[8];
>> +};
> 
> Are these used outside of the driver? If not, move it into the
> driver .c file.

Yes, I will move this to driver.
> 
>
> 
>> +#define STIXXXX_GPIO_PINS_PER_PORT     8
> 
> 
> Does *any* of this have to be in the header file? If not, move it
> into the driver instead, so the reader don't have to shift between several
> files when reading the driver code.
> 
>> +#define stixxxx_gpio_port(gpio) ((gpio) / STIXXXX_GPIO_PINS_PER_PORT)
>> +#define stixxxx_gpio_pin(gpio) ((gpio) % STIXXXX_GPIO_PINS_PER_PORT)
> 
> Move these three #defines into the driver and convert the
> two last ones to static inlines instead. Easier to maintain.

Ok, I will do it.

>> +#define STIXXXX_PINCONF_UNPACK(conf, param)\
>> +                               ((conf >> STIXXXX_PINCONF_ ##param ##_SHIFT) \
>> +                               & STIXXXX_PINCONF_ ##param ##_MASK)
>> +
>> +#define STIXXXX_PINCONF_PACK(conf, val, param) (conf |=\
>> +                               ((val & STIXXXX_PINCONF_ ##param ##_MASK) << \
>> +                                       STIXXXX_PINCONF_ ##param ##_SHIFT))
>> +
>> +/* Output enable */
>> +#define STIXXXX_PINCONF_OE_MASK                0x1
>> +#define STIXXXX_PINCONF_OE_SHIFT       27
>> +#define STIXXXX_PINCONF_OE             BIT(27)
>> +#define STIXXXX_PINCONF_UNPACK_OE(conf)        STIXXXX_PINCONF_UNPACK(conf, OE)
>> +#define STIXXXX_PINCONF_PACK_OE(conf, val)  STIXXXX_PINCONF_PACK(conf, val, OE)
> 
> For all of these macros: why are you suppying an argument that can only
> be 0 or 1?
> 
> Just alter PACK like this:
> 
> #define STIXXXX_PINCONF_PACK_OE(conf)  STIXXXX_PINCONF_PACK(conf, 1, OE)
> 
> And only call it if you want to enable the feature, else avoid calling it.
> There is no point of setting bits to zero with so much adoo.
> 
> 
Yes, I will try this and see how it will look like.

>> +/* RETIME_DELAY in Pico Secs */
>> +#define STIXXXX_PINCONF_RT_DELAY_MASK          0xffff
>> +#define STIXXXX_PINCONF_RT_DELAY_SHIFT         0
>> +#define STIXXXX_PINCONF_UNPACK_RT_DELAY(conf) \
>> +                               STIXXXX_PINCONF_UNPACK(conf, RT_DELAY)
>> +#define STIXXXX_PINCONF_PACK_RT_DELAY(conf, val) \
>> +                               STIXXXX_PINCONF_PACK(conf, val, RT_DELAY)
> 
> But here you need the special packed val to be passed,
> so this looks good.
> 
>> +#endif /* __LINUX_DRIVERS_PINCTRL_STIXXXX_H */
> 
> Move the entire header into the drivers main .c file. Why complicate things?
yes, I will move the full header contents to c file.

Thanks,
srini
> 
> Yours,
> Linus Walleij
> 
> 
