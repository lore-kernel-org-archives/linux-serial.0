From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial: samsung: Remove NULL checking for baud clock
Date: Wed, 20 Jun 2012 16:50:17 -0700
Message-ID: <20120620235017.GA8293@kroah.com>
References: <002d01cd3988$c0d914c0$428b3e40$%kim@samsung.com>
 <028e01cd4e9d$28cbcf90$7a636eb0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57958 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab2FTXuX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Jun 2012 19:50:23 -0400
Received: by dady13 with SMTP id y13so49676dad.19
        for <linux-serial@vger.kernel.org>; Wed, 20 Jun 2012 16:50:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <028e01cd4e9d$28cbcf90$7a636eb0$%kim@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Kyoungil Kim' <ki0351.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, 'Alan Cox' <alan@linux.intel.com>, 'Russell King' <rmk+kernel@arm.linux.org.uk>

On Wed, Jun 20, 2012 at 01:28:36PM +0900, Kukjin Kim wrote:
> Kukjin Kim wrote:
> > 
> > Kyoungil Kim wrote:
> > >
> > > Kyoungil Kim wrote:
> > >
> > > I missed following.
> > >
> > > Russell King suggested:
> > >
> > > As I said, drivers have no business interpreting anything but
> IS_ERR(clk)
> > > as being an error.  They should not make any other
> > > assumptions.
> > >
> > > Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > >
> > > > Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> > > > ---
> > > >  drivers/tty/serial/samsung.c |   21 ++++++++++++---------
> > > >  1 files changed, 12 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/samsung.c
> > b/drivers/tty/serial/samsung.c
> > > > index d8b0aee..5668538 100644
> > > > --- a/drivers/tty/serial/samsung.c
> > > > +++ b/drivers/tty/serial/samsung.c
> > > > @@ -529,7 +529,7 @@ static void s3c24xx_serial_pm(struct uart_port
> > *port,
> > > unsigned int level,
> > > >
> > > >  	switch (level) {
> > > >  	case 3:
> > > > -		if (!IS_ERR(ourport->baudclk) && ourport->baudclk != NULL)
> > > > +		if (!IS_ERR(ourport->baudclk))
> > > >  			clk_disable(ourport->baudclk);
> > > >
> > > >  		clk_disable(ourport->clk);
> > > > @@ -538,7 +538,7 @@ static void s3c24xx_serial_pm(struct uart_port
> > *port,
> > > unsigned int level,
> > > >  	case 0:
> > > >  		clk_enable(ourport->clk);
> > > >
> > > > -		if (!IS_ERR(ourport->baudclk) && ourport->baudclk != NULL)
> > > > +		if (!IS_ERR(ourport->baudclk))
> > > >  			clk_enable(ourport->baudclk);
> > > >
> > > >  		break;
> > > > @@ -604,7 +604,6 @@ static unsigned int s3c24xx_serial_getclk(struct
> > > s3c24xx_uart_port *ourport,
> > > >  	char clkname[MAX_CLK_NAME_LENGTH];
> > > >  	int calc_deviation, deviation = (1 << 30) - 1;
> > > >
> > > > -	*best_clk = NULL;
> > > >  	clk_sel = (ourport->cfg->clk_sel) ? ourport->cfg->clk_sel :
> > > >  			ourport->info->def_clk_sel;
> > > >  	for (cnt = 0; cnt < info->num_clks; cnt++) {
> > > > @@ -613,7 +612,7 @@ static unsigned int s3c24xx_serial_getclk(struct
> > > s3c24xx_uart_port *ourport,
> > > >
> > > >  		sprintf(clkname, "clk_uart_baud%d", cnt);
> > > >  		clk = clk_get(ourport->port.dev, clkname);
> > > > -		if (IS_ERR_OR_NULL(clk))
> > > > +		if (IS_ERR(clk))
> > > >  			continue;
> > > >
> > > >  		rate = clk_get_rate(clk);
> > > > @@ -684,7 +683,7 @@ static void s3c24xx_serial_set_termios(struct
> > > uart_port *port,
> > > >  {
> > > >  	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
> > > >  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> > > > -	struct clk *clk = NULL;
> > > > +	struct clk *clk = ERR_PTR(-EINVAL);
> > > >  	unsigned long flags;
> > > >  	unsigned int baud, quot, clk_sel = 0;
> > > >  	unsigned int ulcon;
> > > > @@ -705,7 +704,7 @@ static void s3c24xx_serial_set_termios(struct
> > > uart_port *port,
> > > >  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
> > > >  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
> > > >  		quot = port->custom_divisor;
> > > > -	if (!clk)
> > > > +	if (IS_ERR(clk))
> > > >  		return;
> > > >
> > > >  	/* check to see if we need  to change clock source */
> > > > @@ -713,9 +712,9 @@ static void s3c24xx_serial_set_termios(struct
> > > uart_port *port,
> > > >  	if (ourport->baudclk != clk) {
> > > >  		s3c24xx_serial_setsource(port, clk_sel);
> > > >
> > > > -		if (ourport->baudclk != NULL && !IS_ERR(ourport->baudclk)) {
> > > > +		if (!IS_ERR(ourport->baudclk)) {
> > > >  			clk_disable(ourport->baudclk);
> > > > -			ourport->baudclk  = NULL;
> > > > +			ourport->baudclk = ERR_PTR(-EINVAL);
> > > >  		}
> > > >
> > > >  		clk_enable(clk);
> > > > @@ -1160,6 +1159,9 @@ static ssize_t s3c24xx_serial_show_clksrc(struct
> > > device *dev,
> > > >  	struct uart_port *port = s3c24xx_dev_to_port(dev);
> > > >  	struct s3c24xx_uart_port *ourport = to_ourport(port);
> > > >
> > > > +	if (IS_ERR(ourport->baudclk))
> > > > +		return -EINVAL;
> > > > +
> > > >  	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
> > > >  }
> > > >
> > > > @@ -1200,6 +1202,7 @@ static int s3c24xx_serial_probe(struct
> > > platform_device *pdev)
> > > >  		return -ENODEV;
> > > >  	}
> > > >
> > > > +	ourport->baudclk = ERR_PTR(-EINVAL);
> > > >  	ourport->info = ourport->drv_data->info;
> > > >  	ourport->cfg = (pdev->dev.platform_data) ?
> > > >  			(struct s3c2410_uartcfg *)pdev->dev.platform_data :
> > > > @@ -1387,7 +1390,7 @@ s3c24xx_serial_get_options(struct uart_port
> > *port,
> > > int *baud,
> > > >  		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
> > > >
> > > >  		clk = clk_get(port->dev, clk_name);
> > > > -		if (!IS_ERR(clk) && clk != NULL)
> > > > +		if (!IS_ERR(clk))
> > > >  			rate = clk_get_rate(clk);
> > > >  		else
> > > >  			rate = 1;
> > > > --
> > > > 1.7.1
> > 
> > Looks ok to me, will apply.
> > Thanks.
> > 
> (Cc'ed Greg)
> 
> I think, would be better if Greg could pick this up in his tree.
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

It's already there :)

