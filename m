From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v4 02/10] ARM: dts: list the CPU nodes for Exynos5250
Date: Thu, 29 Aug 2013 13:51:47 +0200
Message-ID: <1440260.Z9PFmnVfM0@amdc1227>
References: <1371536962-13322-1-git-send-email-chander.kashyap@linaro.org>
 <1371536962-13322-3-git-send-email-chander.kashyap@linaro.org>
 <CAOh2x=nsQ5paiMHSH8z9drsqr7_+TvMtNefczf8QNQNbYo0y=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAOh2x=nsQ5paiMHSH8z9drsqr7_+TvMtNefczf8QNQNbYo0y=Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-serial@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, mark.rutland@arm.com, thomas.ab@samsung.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-serial@vger.kernel.org

Hi Viresh,

On Thursday 29 of August 2013 13:45:56 Viresh Kumar wrote:
> On Tue, Jun 18, 2013 at 11:59 AM, Chander Kashyap
> 
> <chander.kashyap@linaro.org> wrote:
> > Instead of having to specify the number for CPUs in Exynos5250 in
> > platsmp.c file, let the number of CPUs be determined by having this
> > information listed in Exynos5250 device tree file.
> > 
> > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > ---
> > 
> >  arch/arm/boot/dts/exynos5250.dtsi |   16 ++++++++++++++++
> >  arch/arm/mach-exynos/platsmp.c    |   10 +++++++---
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> > b/arch/arm/boot/dts/exynos5250.dtsi index 63ca03d..1aeef98 100644
> > --- a/arch/arm/boot/dts/exynos5250.dtsi
> > +++ b/arch/arm/boot/dts/exynos5250.dtsi
> > @@ -50,6 +50,22 @@
> > 
> >                 pinctrl3 = &pinctrl_3;
> >         
> >         };
> > 
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a15";
> > +                       reg = <0>;
> > +               };
> > +               cpu@1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a15";
> > +                       reg = <1>;
> > +               };
> > +       };
> > +
> > 
> >         pd_gsc: gsc-power-domain@0x10044000 {
> >         
> >                 compatible = "samsung,exynos4210-pd";
> >                 reg = <0x10044000 0x20>;
> > 
> > diff --git a/arch/arm/mach-exynos/platsmp.c
> > b/arch/arm/mach-exynos/platsmp.c index 1a4e4e5..85ea4ca 100644
> > --- a/arch/arm/mach-exynos/platsmp.c
> > +++ b/arch/arm/mach-exynos/platsmp.c
> > @@ -180,10 +180,14 @@ static void __init exynos_smp_init_cpus(void)
> > 
> >         void __iomem *scu_base = scu_base_addr();
> >         unsigned int i, ncores;
> > 
> > -       if (soc_is_exynos5250())
> > -               ncores = 2;
> > -       else
> > +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> > 
> >                 ncores = scu_base ? scu_get_core_count(scu_base) : 1;
> > 
> > +       else
> > +               /*
> > +                * CPU Nodes are passed thru DT and set_cpu_possible
> > +                * is set by "arm_dt_init_cpu_maps".
> > +                */
> > +               return;
> > 
> >         /* sanity check */
> >         if (ncores > nr_cpu_ids) {
> 
> After this patch only one cpu is coming up for me on my Arndale board..
> Revert of this one fixes the issue though (Tested over v3.11-rc7)

It is quite likely that 0 and 1 are not real MPIDR values for CPU cores on 
Exynos5250, because cluster ID might not be 0, as one could expect.

This is what I found out on Exynos4210 and 4x12, when trying to add CPU 
nodes in DT for them, leading in turn to a series of regressions, for which 
it was to late to do all the necessary code rework to fix them for 3.12, so 
I had to defer this work for next release.

Best regards,
Tomasz
