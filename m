From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 6/6] ARM: shmobile: kzm9d-reference: Use common clock
 framework
Date: Tue, 24 Sep 2013 13:55:36 +0900
Message-ID: <20130924045536.GF3619@verge.net.au>
References: <52410F86.4040301@renesas.com>
 <20130924131703.4834a055892285858338003c@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130924131703.4834a055892285858338003c@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
To: takasi-y@ops.dti.ne.jp
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Sep 24, 2013 at 01:17:03PM +0900, takasi-y@ops.dti.ne.jp wrote:
> Use common clock framework version of clock
>  drivers/clk/shmobile/clk-emev2.c
> instead of sh-clkfwk version
>  arch/arm/mach-shmobile/clock-emev2.c
> 
> kzm9d(without -reference) still uses sh-clkfwk version.
> 
> Because two of that framework can not live in one kernel binary,
> there will be SoCs and Boards that can not be in one binary as
> multiplatform binary or so.
> For example, kzm9d and kzm9d-reference is now exclusive.
> 
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>

Magnus, could you confirm whether or not you would like
common clocks to be mandatory for -reference in the near-term?

> ---
>  arch/arm/mach-shmobile/Kconfig                 | 1 +
>  arch/arm/mach-shmobile/board-kzm9d-reference.c | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 50bab8d..d20d4ce 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -237,6 +237,7 @@ config MACH_KZM9D_REFERENCE
>  	depends on ARCH_EMEV2
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select USE_OF
> +	select COMMON_CLK
>  	---help---
>  	   Use reference implementation of KZM9D board support
>  	   which makes a greater use of device tree at the expense
> diff --git a/arch/arm/mach-shmobile/board-kzm9d-reference.c b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> index 8f8bb2f..e0b8317 100644
> --- a/arch/arm/mach-shmobile/board-kzm9d-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9d-reference.c
> @@ -20,15 +20,14 @@
>  
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
> +#include <linux/clk-provider.h>
>  #include <mach/emev2.h>
>  #include <mach/common.h>
>  #include <asm/mach/arch.h>
>  
>  static void __init kzm9d_add_standard_devices(void)
>  {
> -	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> -		emev2_clock_init();
> -
> +	of_clk_init(NULL);
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> -- 
> 1.8.1.5
> 
