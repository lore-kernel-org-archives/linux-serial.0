From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: RE: [PATCH 1/2] serial: samsung: Remove NULL checking for baud clock
Date: Thu, 24 May 2012 17:39:37 +0900
Message-ID: <002d01cd3988$c0d914c0$428b3e40$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32309 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370Ab2EXIjj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 May 2012 04:39:39 -0400
References: 
In-reply-to: 
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Kyoungil Kim' <ki0351.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Alan Cox' <alan@linux.intel.com>, 'Russell King' <rmk+kernel@arm.linux.org.uk>

Kyoungil Kim wrote:

I missed following.

Russell King suggested:

As I said, drivers have no business interpreting anything but IS_ERR(clk) as being an error.  They should not make any other
assumptions.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>

> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> ---
>  drivers/tty/serial/samsung.c |   21 ++++++++++++---------
>  1 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index d8b0aee..5668538 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -529,7 +529,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
> 
>  	switch (level) {
>  	case 3:
> -		if (!IS_ERR(ourport->baudclk) && ourport->baudclk != NULL)
> +		if (!IS_ERR(ourport->baudclk))
>  			clk_disable(ourport->baudclk);
> 
>  		clk_disable(ourport->clk);
> @@ -538,7 +538,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
>  	case 0:
>  		clk_enable(ourport->clk);
> 
> -		if (!IS_ERR(ourport->baudclk) && ourport->baudclk != NULL)
> +		if (!IS_ERR(ourport->baudclk))
>  			clk_enable(ourport->baudclk);
> 
>  		break;
> @@ -604,7 +604,6 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>  	char clkname[MAX_CLK_NAME_LENGTH];
>  	int calc_deviation, deviation = (1 << 30) - 1;
> 
> -	*best_clk = NULL;
>  	clk_sel = (ourport->cfg->clk_sel) ? ourport->cfg->clk_sel :
>  			ourport->info->def_clk_sel;
>  	for (cnt = 0; cnt < info->num_clks; cnt++) {
> @@ -613,7 +612,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
> 
>  		sprintf(clkname, "clk_uart_baud%d", cnt);
>  		clk = clk_get(ourport->port.dev, clkname);
> -		if (IS_ERR_OR_NULL(clk))
> +		if (IS_ERR(clk))
>  			continue;
> 
>  		rate = clk_get_rate(clk);
> @@ -684,7 +683,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>  {
>  	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> -	struct clk *clk = NULL;
> +	struct clk *clk = ERR_PTR(-EINVAL);
>  	unsigned long flags;
>  	unsigned int baud, quot, clk_sel = 0;
>  	unsigned int ulcon;
> @@ -705,7 +704,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
>  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
>  		quot = port->custom_divisor;
> -	if (!clk)
> +	if (IS_ERR(clk))
>  		return;
> 
>  	/* check to see if we need  to change clock source */
> @@ -713,9 +712,9 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>  	if (ourport->baudclk != clk) {
>  		s3c24xx_serial_setsource(port, clk_sel);
> 
> -		if (ourport->baudclk != NULL && !IS_ERR(ourport->baudclk)) {
> +		if (!IS_ERR(ourport->baudclk)) {
>  			clk_disable(ourport->baudclk);
> -			ourport->baudclk  = NULL;
> +			ourport->baudclk = ERR_PTR(-EINVAL);
>  		}
> 
>  		clk_enable(clk);
> @@ -1160,6 +1159,9 @@ static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
>  	struct uart_port *port = s3c24xx_dev_to_port(dev);
>  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> 
> +	if (IS_ERR(ourport->baudclk))
> +		return -EINVAL;
> +
>  	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
>  }
> 
> @@ -1200,6 +1202,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> +	ourport->baudclk = ERR_PTR(-EINVAL);
>  	ourport->info = ourport->drv_data->info;
>  	ourport->cfg = (pdev->dev.platform_data) ?
>  			(struct s3c2410_uartcfg *)pdev->dev.platform_data :
> @@ -1387,7 +1390,7 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
>  		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
> 
>  		clk = clk_get(port->dev, clk_name);
> -		if (!IS_ERR(clk) && clk != NULL)
> +		if (!IS_ERR(clk))
>  			rate = clk_get_rate(clk);
>  		else
>  			rate = 1;
> --
> 1.7.1


