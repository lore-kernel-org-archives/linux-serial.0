From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 18/25] serial: sh-sci: Prepare for multiple clocks and baud rate generators
Date: Thu, 19 Nov 2015 23:04:02 +0200
Message-ID: <3383903.1R72kZGx62@avalon>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be> <1447958344-836-19-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447958344-836-19-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 19 November 2015 19:38:57 Geert Uytterhoeven wrote:
> Refactor the clock and baud rate parameter code to ease adding support
> for multiple clocks and baud rate generators later.
> sci_scbrr_calc() now returns the bit rate error, so it can be compared
> to the bit rate error for other baud rate generators.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 176 +++++++++++++++++++++++++++--------------
>  1 file changed, 120 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 726c96d5a511c222..12800e52f41953dc 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2,6 +2,7 @@
>   * SuperH on-chip serial module support.  (SCI with no FIFO / with FIFO)
>   *
>   *  Copyright (C) 2002 - 2011  Paul Mundt
> + *  Copyright (C) 2015 Glider bvba
>   *  Modified to support SH7720 SCIF. Markus Brunner, Mark Jonas (Jul 2007).
> *
>   * based off of the old drivers/char/sh-sci.c by:
> @@ -76,6 +77,11 @@ enum {
>  	((port)->irqs[SCIx_ERI_IRQ] &&	\
>  	 ((port)->irqs[SCIx_RXI_IRQ] < 0))
> 
> +enum SCI_CLKS {
> +	SCI_FCK,		/* Functional Clock */
> +	SCI_NUM_CLKS
> +};
> +
>  struct sci_port {
>  	struct uart_port	port;
> 
> @@ -92,8 +98,9 @@ struct sci_port {
>  	struct timer_list	break_timer;
>  	int			break_flag;
> 
> -	/* Function clock */
> -	struct clk		*fclk;
> +	/* Clocks */
> +	struct clk		*clks[SCI_NUM_CLKS];
> +	unsigned long		clk_rates[SCI_NUM_CLKS];
> 
>  	int			irqs[SCIx_NR_IRQS];
>  	char			*irqstr[SCIx_NR_IRQS];
> @@ -496,17 +503,24 @@ static int sci_probe_regmap(struct plat_sci_port *cfg)
> 
>  static void sci_port_enable(struct sci_port *sci_port)
>  {
> +	unsigned int i;
> +
>  	if (!sci_port->port.dev)
>  		return;
> 
>  	pm_runtime_get_sync(sci_port->port.dev);
> 
> -	clk_prepare_enable(sci_port->fclk);
> -	sci_port->port.uartclk = clk_get_rate(sci_port->fclk);
> +	for (i = 0; i < SCI_NUM_CLKS; i++) {
> +		clk_prepare_enable(sci_port->clks[i]);
> +		sci_port->clk_rates[i] = clk_get_rate(sci_port->clks[i]);
> +	}
> +	sci_port->port.uartclk = sci_port->clk_rates[SCI_FCK];
>  }
> 
>  static void sci_port_disable(struct sci_port *sci_port)
>  {
> +	unsigned int i;
> +
>  	if (!sci_port->port.dev)
>  		return;
> 
> @@ -518,7 +532,8 @@ static void sci_port_disable(struct sci_port *sci_port)
>  	del_timer_sync(&sci_port->break_timer);
>  	sci_port->break_flag = 0;
> 
> -	clk_disable_unprepare(sci_port->fclk);
> +	for (i = SCI_NUM_CLKS; i-- > 0; )
> +		clk_disable_unprepare(sci_port->clks[i]);
> 
>  	pm_runtime_put_sync(sci_port->port.dev);
>  }
> @@ -1657,6 +1672,7 @@ static int sci_notifier(struct notifier_block *self,
>  {
>  	struct sci_port *sci_port;
>  	unsigned long flags;
> +	unsigned int i;
> 
>  	sci_port = container_of(self, struct sci_port, freq_transition);
> 
> @@ -1664,7 +1680,9 @@ static int sci_notifier(struct notifier_block *self,
>  		struct uart_port *port = &sci_port->port;
> 
>  		spin_lock_irqsave(&port->lock, flags);
> -		port->uartclk = clk_get_rate(sci_port->fclk);
> +		for (i = 0; i < SCI_NUM_CLKS; i++)
> +			sci_port->clk_rates[i] =
> +				clk_get_rate(sci_port->clks[i]);
>  		spin_unlock_irqrestore(&port->lock, flags);
>  	}
> 
> @@ -1907,11 +1925,12 @@ static void sci_shutdown(struct uart_port *port)
>  }
> 
>  /* calculate sample rate, BRR, and clock select */
> -static void sci_scbrr_calc(struct sci_port *s, unsigned int bps,
> -			   unsigned long freq, int *brr, unsigned int *srr,
> -			   unsigned int *cks)
> +static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
> +			  unsigned int *brr, unsigned int *srr,
> +			  unsigned int *cks)
>  {
>  	unsigned int min_sr, max_sr, shift, sr, br, a, b, c;
> +	unsigned long freq = s->clk_rates[SCI_FCK];
>  	int err, min_err = INT_MAX;
> 
>  	if (s->sampling_rate) {
> @@ -1963,6 +1982,7 @@ static void sci_scbrr_calc(struct sci_port *s,
> unsigned int bps,
> 
>  	dev_dbg(s->port.dev, "BRR: %u%+d bps using N %u SR %u cks %u\n", bps,
>  		min_err, *brr, *srr + 1, *cks);
> +	return min_err;
>  }
> 
>  static void sci_reset(struct uart_port *port)
> @@ -1984,11 +2004,14 @@ static void sci_reset(struct uart_port *port)
>  static void sci_set_termios(struct uart_port *port, struct ktermios
> *termios, struct ktermios *old)
>  {
> +	unsigned int baud, smr_val = 0, scr_val = 0, i;
> +	unsigned int brr = 255, cks = 0, srr = 15;
> +	unsigned int brr1 = 255, cks1 = 0, srr1 = 15;
>  	struct sci_port *s = to_sci_port(port);
>  	const struct plat_sci_reg *reg;
> -	unsigned int baud, smr_val = 0, max_baud, cks = 0;
> -	int t = -1;
> -	unsigned int srr = 15;
> +	int min_err = INT_MAX, err;
> +	unsigned long max_freq = 0;
> +	int best_clk = -1;
> 
>  	if ((termios->c_cflag & CSIZE) == CS7)
>  		smr_val |= SCSMR_CHR;
> @@ -2007,35 +2030,59 @@ static void sci_set_termios(struct uart_port *port,
> struct ktermios *termios, * that the previous boot loader has enabled
> required clocks and * setup the baud rate generator hardware for us
> already.
>  	 */
> -	if (port->uartclk)
> -		max_baud = port->uartclk / max(s->sampling_rate, 8U);
> -	else
> -		max_baud = 115200;
> +	if (!port->uartclk) {
> +		baud = uart_get_baud_rate(port, termios, old, 0, 115200);
> +		goto done;
> +	}
> 
> -	baud = uart_get_baud_rate(port, termios, old, 0, max_baud);
> -	if (likely(baud && port->uartclk))
> -		sci_scbrr_calc(s, baud, port->uartclk, &t, &srr, &cks);
> +	for (i = 0; i < SCI_NUM_CLKS; i++)
> +		max_freq = max(max_freq, s->clk_rates[i]);
> +
> +	baud = uart_get_baud_rate(port, termios, old, 0,
> +				  max_freq / max(s->sampling_rate, 8U));
> +	if (!baud)
> +		goto done;
> +
> +	/* Functional Clock and standard Bit Rate Register */
> +	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
> +	if (abs(err) < abs(min_err)) {
> +		best_clk = SCI_FCK;
> +		min_err = err;
> +		brr = brr1;
> +		srr = srr1;
> +		cks = cks1;
> +	}
> +
> +done:
> +	if (best_clk >= 0)
> +		dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
> +			s->clks[best_clk], baud, min_err);
> 
>  	sci_port_enable(s);
> 
>  	sci_reset(port);
> 
> -	smr_val |= serial_port_in(port, SCSMR) & SCSMR_CKS;
> -
>  	uart_update_timeout(port, termios->c_cflag, baud);
> 
> -	dev_dbg(port->dev, "%s: SMR %x, cks %x, t %x, SCSCR %x\n",
> -		__func__, smr_val, cks, t, s->cfg->scscr);
> -
> -	if (t >= 0) {
> -		serial_port_out(port, SCSMR, (smr_val & ~SCSMR_CKS) | cks);
> -		serial_port_out(port, SCBRR, t);
> -		reg = sci_getreg(port, HSSRR);
> -		if (reg->size)
> +	if (best_clk >= 0) {
> +		smr_val |= cks;
> +		dev_dbg(port->dev, "SMR 0x%x BRR %u SRR %u\n", smr_val, brr,
> +			srr);
> +		serial_port_out(port, SCSMR, smr_val);
> +		serial_port_out(port, SCBRR, brr);
> +		if (sci_getreg(port, HSSRR)->size)
>  			serial_port_out(port, HSSRR, srr | HSCIF_SRE);
> -		udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
> -	} else
> +
> +		/* Wait one bit interval */
> +		udelay((1000000 + (baud - 1)) / baud);
> +	} else {
> +		/* Don't touch the bit rate configuration */
> +		scr_val = s->cfg->scscr & (SCSCR_CKE1 | SCSCR_CKE0);
> +		smr_val |= serial_port_in(port, SCSMR) & SCSMR_CKS;
> +		dev_dbg(port->dev, "SCR 0x%x SMR 0x%x\n", scr_val, smr_val);
> +		serial_port_out(port, SCSCR, scr_val);
>  		serial_port_out(port, SCSMR, smr_val);
> +	}
> 
>  	sci_init_pins(port, termios->c_cflag);
> 
> @@ -2060,7 +2107,9 @@ static void sci_set_termios(struct uart_port *port,
> struct ktermios *termios, serial_port_out(port, SCFCR, ctrl);
>  	}
> 
> -	serial_port_out(port, SCSCR, s->cfg->scscr);
> +	scr_val |= s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0);
> +	dev_dbg(port->dev, "SCSCR 0x%x\n", scr_val);
> +	serial_port_out(port, SCSCR, scr_val);
> 
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
>  	/*
> @@ -2252,33 +2301,48 @@ static struct uart_ops sci_uart_ops = {
> 
>  static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
>  {
> -	/* Get the SCI functional clock. It's called "fck" on ARM. */
> -	sci_port->fclk = devm_clk_get(dev, "fck");
> -	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
> -		return -EPROBE_DEFER;
> -	if (!IS_ERR(sci_port->fclk))
> -		return 0;
> +	const char *clk_names[] = {
> +		[SCI_FCK] = "fck",
> +	};
> +	struct clk *clk;
> +	unsigned int i;
> 
> -	/*
> -	 * But it used to be called "sci_ick", and we need to maintain DT
> -	 * backward compatibility.
> -	 */
> -	sci_port->fclk = devm_clk_get(dev, "sci_ick");
> -	if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
> -		return -EPROBE_DEFER;
> -	if (!IS_ERR(sci_port->fclk))
> -		return 0;
> +	for (i = 0; i < SCI_NUM_CLKS; i++) {
> +		clk = devm_clk_get(dev, clk_names[i]);
> +		if (PTR_ERR(clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> 
> -	/*
> -	 * Not all SH platforms declare a clock lookup entry for SCI devices,
> -	 * in which case we need to get the global "peripheral_clk" clock.
> -	 */
> -	sci_port->fclk = devm_clk_get(dev, "peripheral_clk");
> -	if (!IS_ERR(sci_port->fclk))
> -		return 0;
> +		if (IS_ERR(clk) && i == SCI_FCK) {
> +			/*
> +			 * "fck" used to be called "sci_ick", and we need to
> +			 * maintain DT backward compatibility.
> +			 */
> +			clk = devm_clk_get(dev, "sci_ick");
> +			if (PTR_ERR(clk) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +
> +			if (!IS_ERR(clk))
> +				goto found;
> +
> +			/*
> +			 * Not all SH platforms declare a clock lookup entry
> +			 * for SCI devices, in which case we need to get the
> +			 * global "peripheral_clk" clock.
> +			 */
> +			clk = devm_clk_get(dev, "peripheral_clk");
> +			if (!IS_ERR(clk))
> +				goto found;
> +
> +			dev_err(dev, "failed to get functional clock\n");
> +			return PTR_ERR(clk);
> +		}
> 
> -	dev_err(dev, "failed to get functional clock\n");
> -	return PTR_ERR(sci_port->fclk);
> +found:
> +		if (!IS_ERR(clk))
> +			dev_dbg(dev, "clk %u is %pC rate %pCr\n", i, clk, clk);
> +		sci_port->clks[i] = IS_ERR(clk) ? NULL : clk;

Isn't it an issue that we can't tell apart the case where there is no clock 
specified in DT and the case where we can't get the clock due to another error 
?

> +	}
> +	return 0;
>  }
> 
>  static int sci_init_single(struct platform_device *dev,

-- 
Regards,

Laurent Pinchart
