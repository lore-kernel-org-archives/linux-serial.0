From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 20/22] ARM: sun8i: Add SMP support for the Allwinner A23
Date: Mon, 26 May 2014 11:57:02 +0800
Message-ID: <CAGb2v653DqF38OfbhLRbjM-D=mzm-+HGJYcFoVZQVJBv-hoJ6w@mail.gmail.com>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-21-git-send-email-wens@csie.org> <20140525192652.GZ10768@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140525192652.GZ10768@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@linaro.org>, Emilio Lopez <emilio@elopez.com.ar>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Luc Verhaegen <libv@skynet.be>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-serial@vger.kernel.org

On Mon, May 26, 2014 at 3:26 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 23, 2014 at 03:51:23PM +0800, Chen-Yu Tsai wrote:
>> The A23 is a dual Cortex-A7. Add the logic to use the IPs used to
>> control the CPU configuration and the CPU power so that we can
>> bring up secondary CPUs at boot.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/mach-sunxi/platsmp.c | 69 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
>> index c53077b..688faaf 100644
>> --- a/arch/arm/mach-sunxi/platsmp.c
>> +++ b/arch/arm/mach-sunxi/platsmp.c
>> @@ -121,3 +121,72 @@ struct smp_operations sun6i_smp_ops __initdata = {
>>       .smp_boot_secondary     = sun6i_smp_boot_secondary,
>>  };
>>  CPU_METHOD_OF_DECLARE(sun6i_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
>> +
>> +static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +     struct device_node *node;
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "allwinner,sun8i-a23-prcm");
>> +     if (!node) {
>> +             pr_err("Missing A23 PRCM node in the device tree\n");
>> +             return;
>> +     }
>> +
>> +     prcm_membase = of_iomap(node, 0);
>> +     if (!prcm_membase) {
>> +             pr_err("Couldn't map A23 PRCM registers\n");
>> +             return;
>> +     }
>> +
>> +     node = of_find_compatible_node(NULL, NULL,
>> +                                    "allwinner,sun8i-a23-cpuconfig");
>> +     if (!node) {
>> +             pr_err("Missing A23 CPU config node in the device tree\n");
>> +             return;
>> +     }
>> +
>> +     cpucfg_membase = of_iomap(node, 0);
>> +     if (!cpucfg_membase)
>> +             pr_err("Couldn't map A23 CPU config registers\n");
>> +
>> +}
>> +
>> +static int sun8i_smp_boot_secondary(unsigned int cpu,
>> +                                 struct task_struct *idle)
>> +{
>> +     u32 reg;
>> +
>> +     if (!(prcm_membase && cpucfg_membase))
>> +             return -EFAULT;
>> +
>> +     spin_lock(&cpu_lock);
>> +
>> +     /* Set CPU boot address */
>> +     writel(virt_to_phys(secondary_startup),
>> +            cpucfg_membase + CPUCFG_PRIVATE0_REG);
>> +
>> +     /* Assert the CPU core in reset */
>> +     writel(0, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
>> +
>> +     /* Assert the L1 cache in reset */
>> +     reg = readl(cpucfg_membase + CPUCFG_GEN_CTRL_REG);
>> +     writel(reg & ~BIT(cpu), cpucfg_membase + CPUCFG_GEN_CTRL_REG);
>> +
>> +     /* Clear CPU power-off gating */
>> +     reg = readl(prcm_membase + PRCM_CPU_PWROFF_REG);
>> +     writel(reg & ~BIT(cpu), prcm_membase + PRCM_CPU_PWROFF_REG);
>> +     mdelay(1);
>> +
>> +     /* Deassert the CPU core reset */
>> +     writel(3, cpucfg_membase + CPUCFG_CPU_RST_CTRL_REG(cpu));
>> +
>> +     spin_unlock(&cpu_lock);
>> +
>> +     return 0;
>> +}
>> +
>> +struct smp_operations sun8i_smp_ops __initdata = {
>> +     .smp_prepare_cpus       = sun8i_smp_prepare_cpus,
>> +     .smp_boot_secondary     = sun8i_smp_boot_secondary,
>> +};
>> +CPU_METHOD_OF_DECLARE(sun8i_smp, "allwinner,sun8i-a23", &sun8i_smp_ops);
>
> You forgot to document the new enable-method.

I will add it.

> Also, is there any plan to hae a working u-boot? I'd much prefer to
> use PSCI if possible.

IIRC PSCI needs a secure SRAM block to store its program code.
Unfortunately the A23 doesn't have secure SRAM. I think it is
missing other security related features as well.

Or could it just live in generic SRAM, and the kernel marks it
as reserved or something.

Maybe Marc Zyngier (CCed) can shed some light on this?


Cheers,
ChenYu
