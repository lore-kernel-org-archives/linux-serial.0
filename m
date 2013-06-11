From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 01/13] ARM: Exynos: initialize l2x0 cache controller only
 for cortex-a9 based SoCs
Date: Tue, 11 Jun 2013 16:58:06 -0700
Message-ID: <20130611235806.GI23774@quad.lixom.net>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <5595095.zmTGjttZIk@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5595095.zmTGjttZIk@flatron>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, swarren@wwwdotorg.org, arnd@arndb.de
List-Id: linux-serial@vger.kernel.org

On Sat, Jun 08, 2013 at 12:57:41PM +0200, Tomasz Figa wrote:
> Hi Chander,
> 
> On Thursday 06 of June 2013 16:31:15 Chander Kashyap wrote:
> > Only cortex-a9 based Exynos SoCs have l2x0 cache controller. Hence
> > instead of checking for every SoC with soc_is_xxx, just check for cpu
> > part number and initialize the cache controller for cortex-a9 based
> > SoCs.
> > 
> > Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > ---
> >  arch/arm/mach-exynos/common.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-exynos/common.c
> > b/arch/arm/mach-exynos/common.c index 8ce2db4..bad000e 100644
> > --- a/arch/arm/mach-exynos/common.c
> > +++ b/arch/arm/mach-exynos/common.c
> > @@ -35,6 +35,7 @@
> >  #include <asm/mach/map.h>
> >  #include <asm/mach/irq.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/cputype.h>
> > 
> >  #include <mach/regs-irq.h>
> >  #include <mach/regs-pmu.h>
> > @@ -520,7 +521,7 @@ static int __init exynos4_l2x0_cache_init(void)
> 
> I wonder if it shouldn't be done the other way around, i.e. this function 
> being called only when running on SoCs for which it's appropriate, instead 
> of checking for supported SoC in this function.
> 
> Keep in mind that we are going towards multiplatform support, so you would 
> end up running this code on any non-Exynos SoC with Cortex A9 as well. 
> IMHO we should drop most (if not all) of the initcalls around mach-
> exynos/.
> 
> CCing people that might have some opinion on this topic as well.

Looks like all other platforms instantiate the pl310 device node in the
device tree. Since Exynos is going DT-only, there's no need to support
non-DT boot any more, and that would be a much cleaner way forward.

That also moves the l2 init to be driven by device-tree data, this removing the
need for the exynos-specific init alltogether. Code removal FTW!


-Olof
