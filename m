From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
Date: Tue, 24 Sep 2013 13:42:36 +0900
Message-ID: <20130924044236.GC3619@verge.net.au>
References: <52410F86.4040301@renesas.com>
 <20130924130924.61d4ecedf3d4fca5952d55fc@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130924130924.61d4ecedf3d4fca5952d55fc@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
To: takasi-y@ops.dti.ne.jp
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, ben.dooks@codethink.co.uk, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

[ CCed Daniel Lezcano and Thomas Gleixner, the clocksource maintainers ]

On Tue, Sep 24, 2013 at 01:09:24PM +0900, takasi-y@ops.dti.ne.jp wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> migrate to the common clock framework.
> 
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> ---
>  drivers/clocksource/em_sti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
> index 3a5909c..9d17083 100644
> --- a/drivers/clocksource/em_sti.c
> +++ b/drivers/clocksource/em_sti.c
> @@ -78,7 +78,7 @@ static int em_sti_enable(struct em_sti_priv *p)
>  	int ret;
>  
>  	/* enable clock */
> -	ret = clk_enable(p->clk);
> +	ret = clk_prepare_enable(p->clk);
>  	if (ret) {
>  		dev_err(&p->pdev->dev, "cannot enable clock\n");
>  		return ret;
> @@ -107,7 +107,7 @@ static void em_sti_disable(struct em_sti_priv *p)
>  	em_sti_write(p, STI_INTENCLR, 3);
>  
>  	/* stop clock */
> -	clk_disable(p->clk);
> +	clk_disable_unprepare(p->clk);
>  }
>  
>  static cycle_t em_sti_count(struct em_sti_priv *p)
> -- 
> 1.8.1.5
> 
