From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 2/3] ARM: mach-shmobile: r8a7740: Add DT names to
 clock list
Date: Fri, 1 Mar 2013 18:42:00 +0900
Message-ID: <20130301094200.GF27938@verge.net.au>
References: <1361898208-6683-1-git-send-email-hechtb+renesas@gmail.com>
 <1361898208-6683-2-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43701 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab3CAJmD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Mar 2013 04:42:03 -0500
Content-Disposition: inline
In-Reply-To: <1361898208-6683-2-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

On Tue, Feb 26, 2013 at 11:03:27AM -0600, Bastian Hecht wrote:
> This adds temporarily the alternative device names to the clock list
> that are used when booting via Device Tree setup.

Thanks, applied to the soc5 branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v3:
> no changes
> 
>  arch/arm/mach-shmobile/clock-r8a7740.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 71fc400..0f77823 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -593,18 +593,27 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_mobile_ceu.1",	&mstp_clks[MSTP128]),
>  
>  	CLKDEV_DEV_ID("sh-sci.4",		&mstp_clks[MSTP200]),
> +	CLKDEV_DEV_ID("e6c80000.sci",		&mstp_clks[MSTP200]),
>  	CLKDEV_DEV_ID("sh-sci.3",		&mstp_clks[MSTP201]),
> +	CLKDEV_DEV_ID("e6c70000.sci",		&mstp_clks[MSTP201]),
>  	CLKDEV_DEV_ID("sh-sci.2",		&mstp_clks[MSTP202]),
> +	CLKDEV_DEV_ID("e6c60000.sci",		&mstp_clks[MSTP202]),
>  	CLKDEV_DEV_ID("sh-sci.1",		&mstp_clks[MSTP203]),
> +	CLKDEV_DEV_ID("e6c50000.sci",		&mstp_clks[MSTP203]),
>  	CLKDEV_DEV_ID("sh-sci.0",		&mstp_clks[MSTP204]),
> +	CLKDEV_DEV_ID("e6c40000.sci",		&mstp_clks[MSTP204]),
>  	CLKDEV_DEV_ID("sh-sci.8",		&mstp_clks[MSTP206]),
> +	CLKDEV_DEV_ID("e6c30000.sci",		&mstp_clks[MSTP206]),
>  	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
> +	CLKDEV_DEV_ID("e6cb0000.sci",		&mstp_clks[MSTP207]),
>  	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
>  	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
>  	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
>  	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
>  	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
> +	CLKDEV_DEV_ID("e6cd0000.sci",		&mstp_clks[MSTP222]),
>  	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
> +	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
>  
>  	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
>  	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
