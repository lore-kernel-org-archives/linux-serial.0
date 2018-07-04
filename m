From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
Date: Wed, 04 Jul 2018 19:08:22 +0300
Message-ID: <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
References: <20180704165908.4bb8b090@xhacker.debian>
 <20180704170310.56772d77@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180704170310.56772d77@xhacker.debian>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-07-04 at 17:03 +0800, Jisheng Zhang wrote:

Thanks for an update, my comments below.

> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.

I have read 4.00a spec a bit and didn't find this limitation.
The fractional divider can fit up to 32 bits.

> Now the preparation is done, it's easy to add the feature support.
> This patch firstly checks the component version during probe, if
> version >= 4.00a, then calculates the fractional divisor width, then
> setups dw specific get_divisor() and set_divisor() hook.
 
> +#define DW_FRAC_MIN_VERS		0x3430302A

Do we really need this? 

My intuition (I, unfortunately, didn't find any evidence in Synopsys
specs for UART) tells me that when it's unimplemented we would read back
0's, which is fine.

I would test this a bit later.

> 

> +	unsigned int		dlf_size:3;

These bit fields (besides the fact you need 5) more or less for software
quirk flags. In your case I would rather keep a u32 value of DFL mask as
done for msr slightly above in this structure.

>  };
>  
> +/*
> + * For version >= 4.00a, the dw uarts have a valid divisor latch
> fraction
> + * register. Calculate divisor with extra 4bits ~ 6bits fractional
> portion.
> + */

This comment kinda noise. Better to put actual formula from datasheet
how this fractional divider is involved into calculus.

> +static unsigned int dw8250_get_divisor(struct uart_port *p,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	unsigned int quot;
> +	struct dw8250_data *d = p->private_data;
> +

> +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4),
> baud);

If we have clock rate like 100MHz and 10 bits of fractional divider it
would give an integer overflow.

4 here is a magic. Needs to be commented / described better.

> +	*frac = quot & (~0U >> (32 - d->dlf_size));
> +

Operating on dfl_mask is simple as

u64 quot = p->uartclk * (p->dfl_mask + 1);

*frac = div64_u64(quot, baud * 16 * (p->dfl_mask + 1);
return quot;

(Perhaps some magic with types is needed, but you get the idea)

> +	return quot >> d->dlf_size;
> +}
> +
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int
> baud,
> +			       unsigned int quot, unsigned int
> quot_frac)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(p);
> +
> +	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac);

It should use the helper, not playing tricks with serial_port_out().

> +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> +	serial_dl_write(up, quot);

At some point it would be a helper, I think. We can call
serial8250_do_set_divisor() here. So, perhaps we might export it.

> +}
> +
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data
> *data)
>  {
>  	if (p->dev->of_node) {
> @@ -414,6 +445,28 @@ static void dw8250_setup_port(struct uart_port
> *p)
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) &
> 0xff);
>  
> +	/*
> +	 * For version >= 4.00a, the dw uarts have a valid divisor
> latch
> +	 * fraction register. Calculate the fractional divisor width.
> +	 */
> +	if (reg >= DW_FRAC_MIN_VERS) {
> +		struct dw8250_data *d = p->private_data;
> +

> +		if (p->iotype == UPIO_MEM32BE) {
> +			iowrite32be(~0U, p->membase + DW_UART_DLF);
> +			reg = ioread32be(p->membase + DW_UART_DLF);
> +		} else {
> +			writel(~0U, p->membase + DW_UART_DLF);
> +			reg = readl(p->membase + DW_UART_DLF);
> +		}

This should use some helpers. I'll prepare a patch soon and send it
here, you may include it in your series.

I think you need to clean up back them. So the flow like

1. Write all 1:s
2. Read back the value
3. Write all 0:s

> +		d->dlf_size = fls(reg);

Just save value itself as dfl_mask.

> +
> +		if (d->dlf_size) {
> +			p->get_divisor = dw8250_get_divisor;
> +			p->set_divisor = dw8250_set_divisor;
> +		}
> +	}
> +
>  	if (p->iotype == UPIO_MEM32BE)
>  		reg = ioread32be(p->membase + DW_UART_CPR);
>  	else

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
