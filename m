From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial/imx: enable the clock when we really use the uart
 port
Date: Wed, 2 May 2012 10:19:02 +0200
Message-ID: <20120502081902.GT4141@pengutronix.de>
References: <1335946770-17120-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33525 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab2EBITL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 May 2012 04:19:11 -0400
Content-Disposition: inline
In-Reply-To: <1335946770-17120-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org

On Wed, May 02, 2012 at 04:19:30PM +0800, Huang Shijie wrote:
> The current code keeps the clock enabled even when we do not really
> use the uart port. But keep the clock enabled will consume some power.
> 
> In order to save more power, disable the clock when we do not use
> the uart, and enable the clock when we really use the uart port.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

This conflicts with my series converting i.MX to the common clock
framework. Please lets delay this until this has been merged.

Sascha

> ---
>  drivers/tty/serial/imx.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index e7fecee..f5dcdf6 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -694,6 +694,8 @@ static int imx_startup(struct uart_port *port)
>  	int retval;
>  	unsigned long flags, temp;
>  
> +	clk_prepare_enable(sport->clk);
> +
>  	imx_setup_ufcr(sport, 0);
>  
>  	/* disable the DREN bit (Data Ready interrupt enable) before
> @@ -877,6 +879,8 @@ static void imx_shutdown(struct uart_port *port)
>  		temp &= ~(UCR1_IREN);
>  
>  	writel(temp, sport->port.membase + UCR1);
> +
> +	clk_disable_unprepare(sport->clk);
>  }
>  
>  static void
> @@ -1526,6 +1530,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  		goto deinit;
>  	platform_set_drvdata(pdev, &sport->port);
>  
> +	clk_disable_unprepare(sport->clk);
>  	return 0;
>  deinit:
>  	if (pdata && pdata->exit)
> @@ -1552,7 +1557,6 @@ static int serial_imx_remove(struct platform_device *pdev)
>  
>  	if (sport) {
>  		uart_remove_one_port(&imx_reg, &sport->port);
> -		clk_disable_unprepare(sport->clk);
>  		clk_put(sport->clk);
>  	}
>  
> -- 
> 1.7.3.2
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
