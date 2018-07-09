From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v3 3/3] serial: 8250_dw: add fractional divisor support
Date: Mon, 9 Jul 2018 16:32:41 +0800
Message-ID: <20180709163241.4d4ee343@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
        <20180709162315.7f53eb9a@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709162315.7f53eb9a@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Mon, 9 Jul 2018 16:23:15 +0800 Jisheng Zhang wrote:

> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 
> Now the preparation is done, it's easy to add the feature support.
> This patch firstly tries to get the fractional divisor width during
> probe, then setups dw specific get_divisor() and set_divisor() hook.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index fa8a00e8c9c6..e90c3d229f00 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -31,6 +31,7 @@
>  
>  /* Offsets for the DesignWare specific registers */
>  #define DW_UART_USR	0x1f /* UART Status Register */
> +#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
>  #define DW_UART_CPR	0xf4 /* Component Parameter Register */
>  #define DW_UART_UCV	0xf8 /* UART Component Version */
>  
> @@ -55,6 +56,7 @@
>  
>  struct dw8250_data {
>  	u8			usr_reg;
> +	u8			dlf_size;
>  	int			line;
>  	int			msr_mask_on;
>  	int			msr_mask_off;
> @@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
>  	return param == chan->device->dev->parent;
>  }
>  
> +/*
> + * divisor = clk / (16 * baud) = div(I) + div(F)
> + * "I" means integer, "F" means fractional
> + *
> + * 2^dlf_size * clk / (16 * baud) = 2^dlf_size * (div(I) + div(F))
> + * so, (clk << (dlf_siz - 4)) / baud = (div(I) + div(F)) << dlf_size
> + *
> + * let quot = DIV_ROUND_CLOSEST(clk << (dlf_size - 4), baud), we get
> + * div(I) = quot >> dlf_size
> + * div(F) = quot & dlf_mask, where dlf_mask = GENMASK(dlf_size - 1, 0)
> + */
> +static unsigned int dw8250_get_divisor(struct uart_port *p,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{
> +	unsigned int quot;
> +	struct dw8250_data *d = p->private_data;
> +
> +	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
> +	*frac = quot & GENMASK(d->dlf_size - 1, 0);
> +
> +	return quot >> d->dlf_size;

After more consideration, I sent out this version for the following two
points:

1. the max frac divisor width is 6bits now, but we dunno whether future IP
extends it or not. This patch version can still support > 6bits width except
the overflow concern. But fixing overflow(if there is) is as simple as using\
the DIV_ROUND_CLOSEST_ULL macro.

2. this version makes use of well implemented GENMASK to get the dlf_mask,
the micro is well understood, I think. so the code is simplified as well.

3. the magic "4" is explained in the comments, I hope it could help the
code.

what do you think?

Thanks in advance,
Jisheng

> +}
> +
> +static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
> +			       unsigned int quot, unsigned int quot_frac)
> +{
> +	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
> +	serial8250_do_set_divisor(p, baud, quot, quot_frac);
> +}
> +
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  {
>  	if (p->dev->of_node) {
> @@ -426,6 +459,18 @@ static void dw8250_setup_port(struct uart_port *p)
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> +	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
> +	reg = dw8250_readl_ext(p, DW_UART_DLF);
> +	dw8250_writel_ext(p, DW_UART_DLF, 0);
> +
> +	if (reg) {
> +		struct dw8250_data *d = p->private_data;
> +
> +		d->dlf_size = fls(reg);
> +		p->get_divisor = dw8250_get_divisor;
> +		p->set_divisor = dw8250_set_divisor;
> +	}
> +
>  	reg = dw8250_readl_ext(p, DW_UART_CPR);
>  	if (!reg)
>  		return;
