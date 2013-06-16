From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 05/11] pinctrl:stixxxx: Add pinctrl and pinconf support.
Date: Sun, 16 Jun 2013 14:17:15 +0200
Message-ID: <CACRpkdYN-6W8tvbWNVOdCKOWObm3PCtzXqZuUnvHddBtyw2pyQ@mail.gmail.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856161-6600-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370856161-6600-1-git-send-email-srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Srinivas KANDAGATLA <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Gallimore <stephen.gallimore-qxv4g6HH51o@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stuart Menefy <stuart.menefy-qxv4g6HH51o@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2013 at 11:22 AM, Srinivas KANDAGATLA
<srinivas.kandagatla-qxv4g6HH51o@public.gmane.org> wrote:

> About driver:
> This pinctrl driver manages both PIO and PIO-mux block using pinctrl,
> pinconf, pinmux, gpio subsystems. All the pinctrl related config
> information can only come from device trees.

OK that's a good approach!

> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-stixxxx.txt
> @@ -0,0 +1,116 @@
> +*ST pin controller.
> +
> +Each multi-function pin is controlled, driven and routed through the
> +PIO multiplexing block. Each pin supports GPIO functionality (ALT0)
> +and multiple alternate functions(ALT1 - ALTx) that directly connect
> +the pin to different hardware blocks.
> +
> +When a pin is in GPIO mode, Output Enable (OE), Open Drain(OD), and
> +Pull Up (PU) are driven by the related PIO block.
> +
> +ST pinctrl driver controls PIO multiplexing block and also interacts with
> +gpio driver to configure a pin.
> +
> +Required properties: (PIO multiplexing block)
> +- compatible   : should be "st,stixxxx-pinctrl"
> +                       each subnode should set "st,stixxxx-gpio"
> +                       as compatible for each gpio-controller bank.
> +- gpio-controller : Indicates this device is a GPIO controller
> +- #gpio-cells    : Should be one. The first cell is the pin number.
> +- st,retime-in-delay   : Should be array of delays in nsecs.
> +- st,retime-out-delay  : Should be array of delays in nsecs.

Please explain more verbosely what is meant by these
delays. in-delay of what? out-delay of what?

> +- st,retime-pin-mask   : Should be mask to specify which pins can be retimed.

Explain what this "retimed" means.

> +- st,bank-name         : Should be a name string for this bank.

Usually we only use an identifier, like a number for this, but
maybe you need this, so won't judge on it.

> +- st,syscfg            : phandle of the syscfg node.

This is pretty clever.

> +- st,syscfg-offsets    : Should be a 5 cell entry which represent offset of altfunc,
> +       output-enable, pull-up , open drain and retime registers in the syscfg bank

No please. Use the compatible string to determine which version of the
hardware this is and encode a register offset table into the driver instead.
We do not store register offsets in the device tree, it is not a datasheet
XML container you know...

(...)
> +Contents of function subnode node:
(...)
> +- st,pins      : Child node with list of pins with configuration.
(...)
> +Every PIO is represented with 4-7 parameters depending on retime configuration.
> +Each parameter is explained as below.
> +
> +-bank          : Should be bank phandle to which this PIO belongs.
> +-offset                : Offset in the PIO bank.
> +-mode          :pin configuration is selected from one of the below values.
> +               IN
> +               IN_PU
> +               OUT
> +               BIDIR
> +               BIDIR_PU

This looks like it could use our new generic pinconfig API.
Please follow the discussions on the mailing list and read the
latest commits to the pinctrl devel branch on this subject.

Please explain what "bidir(ectional)" actually means here:
does this mean the same as HighZ/tristate or something
else?

> +-rt_type       Retiming Configuration for the pin.
> +               Possible retime configuration are:
> +
> +               -------         -------------
> +               value           args
> +               -------         -------------
> +               NICLK           <delay> <clk>
> +               ICLK_IO         <delay> <clk>
> +               BYPASS          <delay>
> +               DE_IO           <delay> <clk>
> +               SE_ICLK_IO      <delay> <clk>
> +               SE_NICLK_IO     <delay> <clk>
> +
> +- delay        is retime delay in pico seconds.
> +               Possible values are: refer to retime-in/out-delays

Earlier it was given in nanoseconds.

And I still have no clue what "retiming" means.

I'm suspecting you cannot actually use generic pinconfig
due to all this retiming esoterica but atleast give it a thought.

> +- rt_clk       :clk to be use for retime.
> +               Possible values are:
> +               CLK_A
> +               CLK_B
> +               CLK_C
> +               CLK_D

So this is selecting one of four available clock lines?

Should this not interact with some clk bindings for your
clock tree?

> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 8f66924..0c040a3 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -169,6 +169,17 @@ config PINCTRL_SUNXI
>         select PINMUX
>         select GENERIC_PINCONF
>
> +config PINCTRL_STIXXXX

As mentioned elsewhere STIXXXX is a bit too much X:es in.
Please come up with some better naming if possible.

> +       bool "ST Microelectronics pin controller driver for STixxxx SoCs"

Add:
depends on OF

> +       select PINMUX
> +       select PINCONF
> +       help
> +         Say yes here to support pinctrl interface on STixxxx SOCs.
> +         This driver is used to control both PIO block and PIO-mux
> +         block to configure a pin.
> +
> +         If unsure, say N.

(...)
> +++ b/drivers/pinctrl/pinctrl-stixxxx.c

Same naming problem. Repeat again for all identifiers in the code.
Won't mention it again.

(...)
> +#define to_stixxxx_gpio_port(chip) \
> +               container_of(chip, struct stixxxx_gpio_port, gpio_chip)
> +
> +struct stixxxx_gpio_port {
> +       struct gpio_chip        gpio_chip;
> +       struct pinctrl_gpio_range range;
> +       void __iomem            *base;
> +       struct device_node      *of_node;

Why do you need this? The struct gpio_chip above can contain
the of_node can it not?

> +       const char              *bank_name;
> +};

> +static struct stixxxx_gpio_port *gpio_ports[STIXXXX_MAX_GPIO_BANKS];

This is complicating things. Can't you just store the array of GPIO ports
*inside* the struct stixxxx_pinctrl container or something?

(...)
> +/* Low level functions.. */
> +static void stixxxx_pinconf_set_direction(struct stixxxx_pio_control *pc,
> +                               int pin_id, unsigned long config)

Why is this function called "*_set_direction" when it is also
messing with PU and OD?

_set_config would be more appropriate.

(The code looks fine.)

(...)
> +static void stixxxx_pinconf_set_retime_packed(
> +               struct stixxxx_pio_control *pc,
> +               unsigned long config, int pin)
> +{
> +       const struct stixxxx_retime_params *rt_params = pc->rt_params;
> +       const struct stixxxx_retime_offset *offset = rt_params->retime_offset;
> +       struct regmap_field **regs;
> +       unsigned int values[2];
> +       unsigned long mask;
> +       int i, j;
> +       int clk = STIXXXX_PINCONF_UNPACK_RT_CLK(config);
> +       int clknotdata = STIXXXX_PINCONF_UNPACK_RT_CLKNOTDATA(config);
> +       int double_edge = STIXXXX_PINCONF_UNPACK_RT_DOUBLE_EDGE(config);
> +       int invertclk = STIXXXX_PINCONF_UNPACK_RT_INVERTCLK(config);
> +       int retime = STIXXXX_PINCONF_UNPACK_RT(config);
> +       unsigned long delay = stixxxx_pinconf_delay_to_bit(
> +                       STIXXXX_PINCONF_UNPACK_RT_DELAY(config),
> +                       pc->rt_params, config);

As you can see it's a bit excess of "X" above. Hard to read.

Then it seems like some of these should be bool, because:

> +       unsigned long rt_cfg =
> +               ((clk           & 1) << offset->clk1notclk0_offset) |
> +               ((clknotdata    & 1) << offset->clknotdata_offset) |
> +               ((delay         & 1) << offset->delay_lsb_offset) |
> +               (((delay >> 1)  & 1) << offset->delay_msb_offset) |
> +               ((double_edge   & 1) << offset->double_edge_offset) |
> +               ((invertclk     & 1) << offset->invertclk_offset) |
> +               ((retime        & 1) << offset->retime_offset);

This is looking strange. Just strange.
Comments are needed I think. For example why
arey >> 1 on delay all of a sudden?

I would try to make clk, clknotdata, delay etc into bools.

Then it could be more readable like this:

#include <linux/bitops.h>

unsigned long rt_cfg = 0;

if (clk)
    rt_cfg |= BIT(offset->clk1notclk0_offset);
if (clknotdata)
    rt_cfg |= BIT(offset->clknotdata_offset);

etc.

> +       regs = pc->retiming;
> +       regmap_field_read(regs[0], &values[0]);
> +       regmap_field_read(regs[1], &values[1]);
> +
> +       for (i = 0; i < 2; i++) {
> +               mask = BIT(pin);
> +               for (j = 0; j < 4; j++) {
> +                       if (rt_cfg & 1)
> +                               values[i] |= mask;
> +                       else
> +                               values[i] &= ~mask;
> +                       mask <<= 8;
> +                       rt_cfg >>= 1;
> +               }
> +       }

2? 4? 8? Not quite readable with so many magic constants.
Is this "8" identical to STIXXXX_GPIO_PINS_PER_PORT?

> +       regmap_field_write(regs[0], values[0]);
> +       regmap_field_write(regs[1], values[1]);
> +}

(...)
> +static void stixxxx_pinconf_set_retime_dedicated(
> +       struct stixxxx_pio_control *pc,
> +       unsigned long config, int pin)
> +{
> +       struct regmap_field *reg;
> +       int input = STIXXXX_PINCONF_UNPACK_OE(config) ? 0 : 1;
> +       int clk = STIXXXX_PINCONF_UNPACK_RT_CLK(config);
> +       int clknotdata = STIXXXX_PINCONF_UNPACK_RT_CLKNOTDATA(config);
> +       int double_edge = STIXXXX_PINCONF_UNPACK_RT_DOUBLE_EDGE(config);
> +       int invertclk = STIXXXX_PINCONF_UNPACK_RT_INVERTCLK(config);
> +       int retime = STIXXXX_PINCONF_UNPACK_RT(config);
> +       unsigned long delay = stixxxx_pinconf_delay_to_bit(
> +                       STIXXXX_PINCONF_UNPACK_RT_DELAY(config),
> +                       pc->rt_params, config);
> +
> +       unsigned long retime_config =
> +               ((clk           & 0x3) << 0) |
> +               ((clknotdata    & 0x1) << 2) |
> +               ((delay         & 0xf) << 3) |
> +               ((input         & 0x1) << 7) |
> +               ((double_edge   & 0x1) << 8) |
> +               ((invertclk     & 0x1) << 9) |
> +               ((retime        & 0x1) << 10);

Same comments as above.

(...)
> +static void stixxxx_pinconf_get_direction(struct stixxxx_pio_control *pc,
> +       int pin_id, unsigned long *config)
> +{
> +       unsigned int oe_value, pu_value, od_value;
> +       int pin = stixxxx_gpio_pin(pin_id);
> +
> +       regmap_field_read(pc->oe, &oe_value);
> +       regmap_field_read(pc->pu, &pu_value);
> +       regmap_field_read(pc->od, &od_value);
> +
> +       oe_value = (oe_value >> pin) & 1;
> +       pu_value = (pu_value >> pin) & 1;
> +       od_value = (od_value >> pin) & 1;
> +
> +       STIXXXX_PINCONF_PACK_OE(*config, oe_value);
> +       STIXXXX_PINCONF_PACK_PU(*config, pu_value);
> +       STIXXXX_PINCONF_PACK_OD(*config, od_value);
> +}

However that's quite readable actually, this part I
understand.

> +static int stixxxx_pinconf_get_retime_packed(
> +               struct stixxxx_pio_control *pc,
> +               int pin, unsigned long *config)
> +{
> +       const struct stixxxx_retime_params *rt_params = pc->rt_params;
> +       const struct stixxxx_retime_offset *offset = rt_params->retime_offset;
> +       unsigned long delay_bits, delay, rt_reduced;
> +       unsigned int rt_value[2];
> +       int i, j;
> +       int output = STIXXXX_PINCONF_UNPACK_OE(*config);
> +
> +       regmap_field_read(pc->retiming[0], &rt_value[0]);
> +       regmap_field_read(pc->retiming[1], &rt_value[1]);
> +
> +       rt_reduced = 0;
> +       for (i = 0; i < 2; i++) {
> +               for (j = 0; j < 4; j++) {
> +                       if (rt_value[i] & (1<<((8*j)+pin)))
> +                               rt_reduced |= 1 << ((i*4)+j);
> +               }
> +       }

Urgh 2, 4, 8??

What is happening here ... atleast a big comment
explaining the logic would be helpful. Some kind of
matrix traversal seem to be involved.

> +       STIXXXX_PINCONF_PACK_RT(*config,
> +                       (rt_reduced >> offset->retime_offset) & 1);
> +       STIXXXX_PINCONF_PACK_RT_CLK(*config,
> +                       (rt_reduced >> offset->clk1notclk0_offset) & 1);
> +       STIXXXX_PINCONF_PACK_RT_CLKNOTDATA(*config,
> +                       (rt_reduced >> offset->clknotdata_offset) & 1);
> +       STIXXXX_PINCONF_PACK_RT_DOUBLE_EDGE(*config,
> +                       (rt_reduced >> offset->double_edge_offset) & 1);
> +       STIXXXX_PINCONF_PACK_RT_INVERTCLK(*config,
> +                       (rt_reduced >> offset->invertclk_offset) & 1);

I would rewrite this like

if ((rt_reduced >> offset->retime_offset) & 1)
   STIXXXX_PINCONF_PACK_RT(*config, 1);

See further comments on these macros below.

I prefer if they are only used to set bits to 1, then it just becomes:

if ((rt_reduced >> offset->retime_offset) & 1)
   STIXXXX_PINCONF_PACK_RT(*config);

Simpler.

> +       delay_bits =  (((rt_reduced >> offset->delay_msb_offset) & 1)<<1) |
> +                       ((rt_reduced >> offset->delay_lsb_offset) & 1);
> +       delay =  stixxxx_pinconf_bit_to_delay(delay_bits, rt_params, output);
> +       STIXXXX_PINCONF_PACK_RT_DELAY(*config, delay);

This looks OK though.

(...)
> +static int stixxxx_pinconf_get_retime_dedicated(
> +               struct stixxxx_pio_control *pc,
> +               int pin, unsigned long *config)
> +{
> +       unsigned int value;
> +       unsigned long delay_bits, delay;
> +       const struct stixxxx_retime_params *rt_params = pc->rt_params;
> +       int output = STIXXXX_PINCONF_UNPACK_OE(*config);
> +
> +       regmap_field_read(pc->retiming[pin], &value);
> +       STIXXXX_PINCONF_PACK_RT_CLK(*config, ((value >> 0) & 0x3));
> +       STIXXXX_PINCONF_PACK_RT_CLKNOTDATA(*config, ((value >> 2) & 0x1));
> +       delay_bits = ((value >> 3) & 0xf);

0x03? 2? 3? lots of magic constants here, can they be defined?

> +       delay =  stixxxx_pinconf_bit_to_delay(delay_bits, rt_params, output);
> +       STIXXXX_PINCONF_PACK_RT_DELAY(*config, delay);
> +       STIXXXX_PINCONF_PACK_RT_DOUBLE_EDGE(*config, ((value >> 8) & 0x1));

8?

> +       STIXXXX_PINCONF_PACK_RT_INVERTCLK(*config, ((value >> 9) & 0x1));

9?

> +       STIXXXX_PINCONF_PACK_RT(*config, ((value >> 10) & 0x1));

10?

Can these be #defines?

(...)
> +static void stixxxx_gpio_direction(unsigned int gpio, unsigned int direction)
> +{
> +       int port_num = stixxxx_gpio_port(gpio);
> +       int offset = stixxxx_gpio_pin(gpio);
> +       struct stixxxx_gpio_port *port  = gpio_ports[port_num];
> +       int i = 0;
> +
> +       for (i = 0; i <= 2; i++) {
> +               if (direction & BIT(i))
> +                       writel(BIT(offset), port->base + REG_PIO_SET_PC(i));
> +               else
> +                       writel(BIT(offset), port->base + REG_PIO_CLR_PC(i));
> +       }

Can you explain here in a comment why the loop has to hit
bits 0, 1 and 2 in this register?

(...)
> +static int stixxxx_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct stixxxx_gpio_port *port = to_stixxxx_gpio_port(chip);
> +
> +       return (readl(port->base + REG_PIO_PIN) >> offset) & 1;

Usually we do this with the double-bang idiom:

return !!(readl(port->base + REG_PIO_PIN) & BIT(offset));

> +static void stixxxx_pctl_dt_free_map(struct pinctrl_dev *pctldev,
> +                               struct pinctrl_map *map, unsigned num_maps)
> +{
> +}

Isn't this optional? And don't you need to free this?

(...)
> +static void stixxxx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> +                                  struct seq_file *s, unsigned pin_id)
> +{
> +       unsigned long config;
> +       stixxxx_pinconf_get(pctldev, pin_id, &config);
> +
> +       seq_printf(s, "[OE:%ld,PU:%ld,OD:%ld]\n"
> +               "\t\t[retime:%ld,invclk:%ld,clknotdat:%ld,"
> +               "de:%ld,rt-clk:%ld,rt-delay:%ld]",
> +               STIXXXX_PINCONF_UNPACK_OE(config),
> +               STIXXXX_PINCONF_UNPACK_PU(config),
> +               STIXXXX_PINCONF_UNPACK_OD(config),
> +               STIXXXX_PINCONF_UNPACK_RT(config),
> +               STIXXXX_PINCONF_UNPACK_RT_INVERTCLK(config),
> +               STIXXXX_PINCONF_UNPACK_RT_CLKNOTDATA(config),
> +               STIXXXX_PINCONF_UNPACK_RT_DOUBLE_EDGE(config),
> +               STIXXXX_PINCONF_UNPACK_RT_CLK(config),
> +               STIXXXX_PINCONF_UNPACK_RT_DELAY(config));
> +}

This looks real nice, but is the output human-friendly?
Well maybe the format needs to be compact like this...

> +       if (of_device_is_compatible(np, "st,stih415-pinctrl")) {
> +               rt_offset = devm_kzalloc(info->dev,
> +                       sizeof(*rt_offset), GFP_KERNEL);
> +
> +               if (!rt_offset)
> +                       return -ENOMEM;
> +
> +               rt_offset->clk1notclk0_offset = 0;
> +               rt_offset->delay_lsb_offset = 2;
> +               rt_offset->delay_msb_offset = 3;
> +               rt_offset->invertclk_offset = 4;
> +               rt_offset->retime_offset = 5;
> +               rt_offset->clknotdata_offset = 6;
> +               rt_offset->double_edge_offset = 7;

This looks awkward and complicated.

Why not just #define these offsets and use them
directly in the code?

> +static int stixxxx_pctl_dt_init(struct stixxxx_pinctrl *info,
> +                       struct device_node *np)
> +{
> +       struct stixxxx_pio_control *pc;
> +       struct stixxxx_retime_params *rt_params;
> +       struct device *dev = info->dev;
> +       struct regmap *regmap;
> +       unsigned int i = 0;
> +       struct device_node *child = NULL;
> +       u32 alt_syscfg, oe_syscfg, pu_syscfg, od_syscfg, rt_syscfg;
> +       u32 syscfg_offsets[5];
> +       u32 msb, lsb;
> +
> +       pc = devm_kzalloc(dev, sizeof(*pc) * info->nbanks, GFP_KERNEL);
> +       rt_params = devm_kzalloc(dev, sizeof(*rt_params), GFP_KERNEL);
> +
> +       if (!pc || !rt_params)
> +               return -ENOMEM;
> +
> +       regmap = syscfg_regmap_lookup_by_phandle(np, "st,syscfg");
> +       if (!regmap) {
> +               dev_err(dev, "No syscfg phandle specified\n");
> +               return -ENOMEM;
> +       }
> +       info->regmap = regmap;
> +       info->pio_controls = pc;
> +       if (stixxxx_pinconf_dt_parse_rt_params(info, np, rt_params))
> +               return -ENOMEM;
> +
> +       if (of_property_read_u32_array(np, "st,syscfg-offsets",
> +                               syscfg_offsets, 5)) {
> +               dev_err(dev, "Syscfg offsets not found\n");
> +               return -EINVAL;
> +       }
> +       alt_syscfg = syscfg_offsets[0];
> +       oe_syscfg = syscfg_offsets[1];
> +       pu_syscfg = syscfg_offsets[2];
> +       od_syscfg = syscfg_offsets[3];
> +       rt_syscfg = syscfg_offsets[4];

This isn't looking any fun either.

#defining the offsets avoid all this strange boilerplate.

> +       lsb = 0;
> +       msb = 7;

And this.

> +       for_each_child_of_node(np, child) {
> +               if (of_device_is_compatible(child, gpio_compat)) {
> +                       struct reg_field alt_reg =
> +                                       REG_FIELD(4 * alt_syscfg++, 0, 31);
> +                       struct reg_field oe_reg =
> +                                       REG_FIELD(4 * oe_syscfg, lsb, msb);
> +                       struct reg_field pu_reg =
> +                                       REG_FIELD(4 * pu_syscfg, lsb, msb);
> +                       struct reg_field od_reg =
> +                                       REG_FIELD(4 * od_syscfg, lsb, msb);
> +                       pc[i].rt_params = rt_params;
> +
> +                       pc[i].alt = devm_regmap_field_alloc(dev,
> +                                                       regmap, alt_reg);
> +                       pc[i].oe = devm_regmap_field_alloc(dev,
> +                                                       regmap, oe_reg);
> +                       pc[i].pu = devm_regmap_field_alloc(dev,
> +                                                       regmap, pu_reg);
> +                       pc[i].od = devm_regmap_field_alloc(dev,
> +                                                       regmap, od_reg);
> +
> +                       if (IS_ERR(pc[i].alt) || IS_ERR(pc[i].oe)
> +                               || IS_ERR(pc[i].pu) || IS_ERR(pc[i].od))
> +                               goto failed;
> +
> +                       of_property_read_u32(child, "st,retime-pin-mask",
> +                                               &pc[i].rt_pin_mask);
> +
> +                       stixxxx_pctl_dt_get_retime_conf(info, &pc[i],
> +                                                       &rt_syscfg);
> +                       i++;
> +                       if (msb  == 31) {
> +                               oe_syscfg++;
> +                               pu_syscfg++;
> +                               od_syscfg++;
> +                               lsb = 0;
> +                               msb = 7;
> +                       } else {
> +                               lsb += 8;
> +                               msb += 8;
> +                       }

Can you explain with a comment what is happening here.

> +static struct pinctrl_gpio_range *find_gpio_range(struct device_node *np)
> +{
> +       int i;
> +       for (i = 0; i < STIXXXX_MAX_GPIO_BANKS; i++)
> +               if (gpio_ports[i]->of_node == np)
> +                       return &gpio_ports[i]->range;
> +
> +       return NULL;
> +}

This looks a bit like it's duplicating pinctrl_find_gpio_range_from_pin()
or similar already available from the pinctrl core. But it seems you
may need it here in this case.

> +static int stixxxx_pctl_probe(struct platform_device *pdev)
(...)
> +static int stixxxx_gpio_probe(struct platform_device *pdev)
(...)
> +static struct of_device_id stixxxx_gpio_of_match[] = {
> +       { .compatible = "st,stixxxx-gpio", },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver stixxxx_gpio_driver = {
> +       .driver = {
> +               .name = "st-gpio",
> +               .owner = THIS_MODULE,
> +               .of_match_table = of_match_ptr(stixxxx_gpio_of_match),
> +       },
> +       .probe = stixxxx_gpio_probe,
> +};
> +
> +static struct of_device_id stixxxx_pctl_of_match[] = {
> +       { .compatible = "st,stixxxx-pinctrl",},
> +       { .compatible = "st,stih415-pinctrl",},
> +       { .compatible = "st,stih416-pinctrl",},
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver stixxxx_pctl_driver = {
> +       .driver = {
> +               .name = "st-pinctrl",
> +               .owner = THIS_MODULE,
> +               .of_match_table = of_match_ptr(stixxxx_pctl_of_match),
> +       },
> +       .probe = stixxxx_pctl_probe,
> +};


Why do you need separate nodes and probe functions for the
pinctrl and GPIO? Can't you just have a single pinctrl node?

> +static int __init stixxxx_pctl_init(void)
> +{
> +       int ret = platform_driver_register(&stixxxx_gpio_driver);
> +       if (ret)
> +               return ret;
> +       return platform_driver_register(&stixxxx_pctl_driver);
> +}

Especially since you're just registering them after each other.

Maybe you could have the GPIO nodes as children inside  the
pinctrl node and iterate over with for_each_child_of_node()?

I'm not requiring you rewrite this, just that you give it a thought.

(...)
> +++ b/drivers/pinctrl/pinctrl-stixxxx.h
> @@ -0,0 +1,197 @@
> +
> +/*
> + * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
> + * Authors:
> + *     Srinivas Kandagatla <srinivas.kandagatla-qxv4g6HH51o@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __LINUX_DRIVERS_PINCTRL_STIXXXX_H
> +#define __LINUX_DRIVERS_PINCTRL_STIXXXX_H
> +
> +enum stixxxx_retime_style {
> +       stixxxx_retime_style_none,
> +       stixxxx_retime_style_packed,
> +       stixxxx_retime_style_dedicated,
> +};
> +
> +/* Byte positions in 2 syscon words, starts from 0 */
> +struct stixxxx_retime_offset {
> +       int retime_offset;
> +       int clk1notclk0_offset;
> +       int clknotdata_offset;
> +       int double_edge_offset;
> +       int invertclk_offset;
> +       int delay_lsb_offset;
> +       int delay_msb_offset;
> +};
> +
> +struct stixxxx_retime_params {
> +       const struct stixxxx_retime_offset *retime_offset;
> +       unsigned int *delay_times_in;
> +       int num_delay_times_in;
> +       unsigned int *delay_times_out;
> +       int num_delay_times_out;
> +};
> +
> +struct stixxxx_pio_control {
> +       enum stixxxx_retime_style rt_style;
> +       u32 rt_pin_mask;
> +       const struct stixxxx_retime_params *rt_params;
> +       struct regmap_field *alt;
> +       struct regmap_field *oe, *pu, *od;
> +       struct regmap_field *retiming[8];
> +};

Are these used outside of the driver? If not, move it into the
driver .c file.


> +/* PIO Block registers */
> +/* PIO output */
> +#define REG_PIO_POUT                   0x00
> +/* Set bits of POUT */
> +#define REG_PIO_SET_POUT               0x04
> +/* Clear bits of POUT */
> +#define REG_PIO_CLR_POUT               0x08
> +/* PIO input */
> +#define REG_PIO_PIN                    0x10
> +/* PIO configuration */
> +#define REG_PIO_PC(n)                  (0x20 + (n) * 0x10)
> +/* Set bits of PC[2:0] */
> +#define REG_PIO_SET_PC(n)              (0x24 + (n) * 0x10)
> +/* Clear bits of PC[2:0] */
> +#define REG_PIO_CLR_PC(n)              (0x28 + (n) * 0x10)
> +/* PIO input comparison */
> +#define REG_PIO_PCOMP                  0x50
> +/* Set bits of PCOMP */
> +#define REG_PIO_SET_PCOMP              0x54
> +/* Clear bits of PCOMP */
> +#define REG_PIO_CLR_PCOMP              0x58
> +/* PIO input comparison mask */
> +#define REG_PIO_PMASK                  0x60
> +/* Set bits of PMASK */
> +#define REG_PIO_SET_PMASK              0x64
> +/* Clear bits of PMASK */
> +#define REG_PIO_CLR_PMASK              0x68
> +
> +#define STIXXXX_MAX_GPIO_BANKS         32
> +
> +#define STIXXXX_GPIO_DIRECTION_BIDIR   0x1
> +#define STIXXXX_GPIO_DIRECTION_OUT     0x2
> +#define STIXXXX_GPIO_DIRECTION_IN      0x4

> +#define STIXXXX_GPIO_PINS_PER_PORT     8


Does *any* of this have to be in the header file? If not, move it
into the driver instead, so the reader don't have to shift between several
files when reading the driver code.

> +#define stixxxx_gpio_port(gpio) ((gpio) / STIXXXX_GPIO_PINS_PER_PORT)
> +#define stixxxx_gpio_pin(gpio) ((gpio) % STIXXXX_GPIO_PINS_PER_PORT)

Move these three #defines into the driver and convert the
two last ones to static inlines instead. Easier to maintain.

> +
> +/* pinconf */
> +/*
> + * Pinconf is represented in an opaque unsigned long variable.
> + * Below is the bit allocation details for each possible configuration.
> + * All the bit fields can be encapsulated into four variables
> + * (direction, retime-type, retime-clk, retime-delay)
> + *
> + *      +----------------+
> + *[31:28]| reserved-3     |
> + *      +----------------+-------------
> + *[27]   |     oe        |             |
> + *      +----------------+             v
> + *[26]   |     pu        |     [Direction      ]
> + *      +----------------+             ^
> + *[25]   |     od        |             |
> + *      +----------------+-------------
> + *[24]   | reserved-2     |
> + *      +----------------+-------------
> + *[23]   |    retime      |            |
> + *      +----------------+             |
> + *[22]   | retime-invclk  |            |
> + *      +----------------+             v
> + *[21]   |retime-clknotdat|    [Retime-type    ]
> + *      +----------------+             ^
> + *[20]   | retime-de      |            |
> + *      +----------------+-------------
> + *[19:18]| retime-clk     |------>[Retime-Clk  ]
> + *      +----------------+
> + *[17:16]|  reserved-1    |
> + *      +----------------+
> + *[15..0]| retime-delay   |------>[Retime Delay]
> + *      +----------------+
> + */
> +
> +#define STIXXXX_PINCONF_UNPACK(conf, param)\
> +                               ((conf >> STIXXXX_PINCONF_ ##param ##_SHIFT) \
> +                               & STIXXXX_PINCONF_ ##param ##_MASK)
> +
> +#define STIXXXX_PINCONF_PACK(conf, val, param) (conf |=\
> +                               ((val & STIXXXX_PINCONF_ ##param ##_MASK) << \
> +                                       STIXXXX_PINCONF_ ##param ##_SHIFT))
> +
> +/* Output enable */
> +#define STIXXXX_PINCONF_OE_MASK                0x1
> +#define STIXXXX_PINCONF_OE_SHIFT       27
> +#define STIXXXX_PINCONF_OE             BIT(27)
> +#define STIXXXX_PINCONF_UNPACK_OE(conf)        STIXXXX_PINCONF_UNPACK(conf, OE)
> +#define STIXXXX_PINCONF_PACK_OE(conf, val)  STIXXXX_PINCONF_PACK(conf, val, OE)

For all of these macros: why are you suppying an argument that can only
be 0 or 1?

Just alter PACK like this:

#define STIXXXX_PINCONF_PACK_OE(conf)  STIXXXX_PINCONF_PACK(conf, 1, OE)

And only call it if you want to enable the feature, else avoid calling it.
There is no point of setting bits to zero with so much adoo.


> +/* Pull Up */
> +#define STIXXXX_PINCONF_PU_MASK                0x1
> +#define STIXXXX_PINCONF_PU_SHIFT       26
> +#define STIXXXX_PINCONF_PU             BIT(26)
> +#define STIXXXX_PINCONF_UNPACK_PU(conf)        STIXXXX_PINCONF_UNPACK(conf, PU)
> +#define STIXXXX_PINCONF_PACK_PU(conf, val) STIXXXX_PINCONF_PACK(conf, val, PU)

Dito.

> +/* Open Drain */
> +#define STIXXXX_PINCONF_OD_MASK                0x1
> +#define STIXXXX_PINCONF_OD_SHIFT       25
> +#define STIXXXX_PINCONF_OD             BIT(25)
> +#define STIXXXX_PINCONF_UNPACK_OD(conf)        STIXXXX_PINCONF_UNPACK(conf, OD)
> +#define STIXXXX_PINCONF_PACK_OD(conf, val) STIXXXX_PINCONF_PACK(conf, val, OD)

Dito.

> +#define STIXXXX_PINCONF_RT_MASK                0x1
> +#define STIXXXX_PINCONF_RT_SHIFT       23
> +#define STIXXXX_PINCONF_RT             BIT(23)
> +#define STIXXXX_PINCONF_UNPACK_RT(conf)        STIXXXX_PINCONF_UNPACK(conf, RT)
> +#define STIXXXX_PINCONF_PACK_RT(conf, val) STIXXXX_PINCONF_PACK(conf, val, RT)

Dito.

> +#define STIXXXX_PINCONF_RT_INVERTCLK_MASK      0x1
> +#define STIXXXX_PINCONF_RT_INVERTCLK_SHIFT     22
> +#define STIXXXX_PINCONF_RT_INVERTCLK           BIT(22)
> +#define STIXXXX_PINCONF_UNPACK_RT_INVERTCLK(conf) \
> +                       STIXXXX_PINCONF_UNPACK(conf, RT_INVERTCLK)
> +#define STIXXXX_PINCONF_PACK_RT_INVERTCLK(conf, val) \
> +                       STIXXXX_PINCONF_PACK(conf, val, RT_INVERTCLK)

Dito.

> +#define STIXXXX_PINCONF_RT_CLKNOTDATA_MASK     0x1
> +#define STIXXXX_PINCONF_RT_CLKNOTDATA_SHIFT    21
> +#define STIXXXX_PINCONF_RT_CLKNOTDATA          BIT(21)
> +#define STIXXXX_PINCONF_UNPACK_RT_CLKNOTDATA(conf)     \
> +                               STIXXXX_PINCONF_UNPACK(conf, RT_CLKNOTDATA)
> +#define STIXXXX_PINCONF_PACK_RT_CLKNOTDATA(conf, val) \
> +                               STIXXXX_PINCONF_PACK(conf, val, RT_CLKNOTDATA)

Dito.

> +#define STIXXXX_PINCONF_RT_DOUBLE_EDGE_MASK    0x1
> +#define STIXXXX_PINCONF_RT_DOUBLE_EDGE_SHIFT   20
> +#define STIXXXX_PINCONF_RT_DOUBLE_EDGE         BIT(20)
> +#define STIXXXX_PINCONF_UNPACK_RT_DOUBLE_EDGE(conf) \
> +                               STIXXXX_PINCONF_UNPACK(conf, RT_DOUBLE_EDGE)
> +#define STIXXXX_PINCONF_PACK_RT_DOUBLE_EDGE(conf, val) \
> +                               STIXXXX_PINCONF_PACK(conf, val, RT_DOUBLE_EDGE)

Dito.

> +#define STIXXXX_PINCONF_RT_CLK_MASK            0x3
> +#define STIXXXX_PINCONF_RT_CLK_SHIFT           18
> +#define STIXXXX_PINCONF_RT_CLK                 BIT(18)
> +#define STIXXXX_PINCONF_UNPACK_RT_CLK(conf)    \
> +                       STIXXXX_PINCONF_UNPACK(conf, RT_CLK)
> +#define STIXXXX_PINCONF_PACK_RT_CLK(conf, val) \
> +                       STIXXXX_PINCONF_PACK(conf, val, RT_CLK)

Dito.

> +/* RETIME_DELAY in Pico Secs */
> +#define STIXXXX_PINCONF_RT_DELAY_MASK          0xffff
> +#define STIXXXX_PINCONF_RT_DELAY_SHIFT         0
> +#define STIXXXX_PINCONF_UNPACK_RT_DELAY(conf) \
> +                               STIXXXX_PINCONF_UNPACK(conf, RT_DELAY)
> +#define STIXXXX_PINCONF_PACK_RT_DELAY(conf, val) \
> +                               STIXXXX_PINCONF_PACK(conf, val, RT_DELAY)

But here you need the special packed val to be passed,
so this looks good.

> +#endif /* __LINUX_DRIVERS_PINCTRL_STIXXXX_H */

Move the entire header into the drivers main .c file. Why complicate things?

Yours,
Linus Walleij
