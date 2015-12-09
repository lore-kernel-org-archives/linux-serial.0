From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH-v8] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Wed, 9 Dec 2015 15:19:39 +0200
Message-ID: <20151209131939.GA14285@kuha.fi.intel.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
 <1445158908-9610-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445158908-9610-1-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com
List-Id: linux-serial@vger.kernel.org

Hi Noam,

On Sun, Oct 18, 2015 at 12:01:48PM +0300, Noam Camus wrote:
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index a0cdbf3..880f712 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -63,6 +63,9 @@ struct dw8250_data {
>  	struct clk		*pclk;
>  	struct reset_control	*rst;
>  	struct uart_8250_dma	dma;
> +	unsigned int		(*serial_in)(void __iomem *addr);
> +	void			(*serial_out)(unsigned int value,
> +					      void __iomem *addr);

This is really ideal ..

>  	unsigned int		skip_autocfg:1;
>  	unsigned int		uart_16550_compatible:1;
> @@ -159,9 +162,9 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>  }
>  #endif /* CONFIG_64BIT */
>  
> -static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
> +static void dw8250_check_LCR(struct uart_port *p, int offset, int value)
>  {
> -	writel(value, p->membase + (offset << p->regshift));
> +	struct dw8250_data *d = p->private_data;
>  
>  	/* Make sure LCR write wasn't ignored */
>  	if (offset == UART_LCR) {
> @@ -171,7 +174,8 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>  			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
>  				return;
>  			dw8250_force_idle(p);
> -			writel(value, p->membase + (UART_LCR << p->regshift));
> +			d->serial_out(value,
> +				      p->membase + (UART_LCR << p->regshift));
>  		}

.. The way I see it, this is the only place where you would really
need the new private serial_in/out hooks, so why not just check the
iotype here and based on that use writeb/writel/iowrite32be or what
ever ..

<snip>

>  static void dw8250_setup_port(struct uart_port *p)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(p);
> +	struct dw8250_data *d = p->private_data;
>  	u32 reg;
>  
>  	/*
>  	 * If the Component Version Register returns zero, we know that
>  	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
>  	 */
> -	reg = readl(p->membase + DW_UART_UCV);
> +	reg = d->serial_in(p->membase + DW_UART_UCV);
>  	if (!reg)
>  		return;
>  
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> -	reg = readl(p->membase + DW_UART_CPR);
> +	reg = d->serial_in(p->membase + DW_UART_CPR);
>  	if (!reg)
>  		return;

.. Here you could as well replace the direct readl calls with
serial_port_in calls.

> @@ -390,9 +434,19 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	err = device_property_read_u32(p->dev, "reg-io-width", &val);
>  	if (!err && val == 4) {
> -		p->iotype = UPIO_MEM32;
> -		p->serial_in = dw8250_serial_in32;
> -		p->serial_out = dw8250_serial_out32;
> +		p->iotype = of_device_is_big_endian(p->dev->of_node) ?
> +			    UPIO_MEM32BE : UPIO_MEM32;

If this has to be tied to DT, do this check in dw8250_quirks.

> +		if (p->iotype == UPIO_MEM32) {
> +			p->serial_in = dw8250_serial_in32;
> +			p->serial_out = dw8250_serial_out32;
> +			data->serial_in = _dw8250_serial_in32;
> +			data->serial_out = _dw8250_serial_out32;
> +		} else {
> +			p->serial_in = dw8250_serial_in32be;
> +			p->serial_out = dw8250_serial_out32be;
> +			data->serial_in = _dw8250_serial_in32be;
> +			data->serial_out = _dw8250_serial_out32be;
> +		}
>  	}
>  
>  	if (device_property_read_bool(p->dev, "dcd-override")) {
> @@ -466,6 +520,9 @@ static int dw8250_probe(struct platform_device *pdev)
>  
>  	dw8250_quirks(p, data);
>  
> +	data->serial_in = _dw8250_serial_in32;
> +	data->serial_out = _dw8250_serial_out32;

I don't think I understand what is going on here? You would never
actually even use _dw8250_serial_in32be/out32be, no?

Maybe I'm misunderstanding something.


Thanks,

-- 
heikki
