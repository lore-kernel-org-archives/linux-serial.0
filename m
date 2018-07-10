From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/3] serial: 8250_dw: add fractional divisor support
Date: Tue, 10 Jul 2018 19:19:21 +0300
Message-ID: <8c5b6bbbde12b0836e1f833c86b805a817596654.camel@linux.intel.com>
References: <20180710110942.5b0a016e@xhacker.debian>
         <20180710111516.13b8c570@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710111516.13b8c570@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2018-07-10 at 11:15 +0800, Jisheng Zhang wrote:
> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 
> Now the preparation is done, it's easy to add the feature support.
> This patch firstly tries to get the fractional divisor width during
> probe, then setups dw specific get_divisor() and set_divisor() hook.

Thanks for an update, my comments below.

> +/*
> + * divisor = div(I) + div(F)
> + * "I" means integer, "F" means fractional
> + * quot = div(I) = clk / (16 * baud)
> + * frac = div(F) * 2^dlf_size
> + *
> + * let rem = clk % (16 * baud)
> + * we have: div(F) * (16 * baud) = rem
> + * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16
> * baud)
> + */
> +static unsigned int dw8250_get_divisor(struct uart_port *p,
> +				       unsigned int baud,
> +				       unsigned int *frac)
> +{

unsigned int base_baud = baud * 16;

> +	unsigned int quot, rem;
> +	struct dw8250_data *d = p->private_data;
> +
> +	quot = p->uartclk / (16 * baud);
> +	rem = p->uartclk % (16 * baud);
> +	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, 16 * baud);
> +

While it looks indeed better, I would rather like to have a confirmation
it's working as designed.

For example, when I did some calculus, I cooked a preliminary check in
Python (easy and fast to prototype), for example:
https://gist.github.com/andy-shev/06b084488b3629898121 in Python, or
commit 9df461eca18f ("spi: pxa2xx: replace ugly table by approximation")
in the kernel.

Or another one here https://gist.github.com/andy-shev/8b2a73aeca2874f4cc
89 and commits c1a67b48f6a5 ("serial: 8250_pci: replace switch-case by
formula for Intel MID"), 21947ba654a6 ("serial: 8250_pci: replace
switch-case by formula")

P.S. The code itself looks good to me, thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
