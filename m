From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] 8250_dw: Support all baudrates on baytrail
Date: Thu, 17 Apr 2014 14:19:54 +0300
Message-ID: <20140417111953.GB17611@xps8300>
References: <1397136684-11515-1-git-send-email-loic.poulain@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22784 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbaDQLT5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2014 07:19:57 -0400
Content-Disposition: inline
In-Reply-To: <1397136684-11515-1-git-send-email-loic.poulain@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Loic Poulain <loic.poulain@intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

Hi Loic,

On Thu, Apr 10, 2014 at 03:31:24PM +0200, Loic Poulain wrote:
> In the same manner as 8250_pci, 8250_dw needs
> some baytrail specific quirks to be used.
> The reference clock needs to be adjusted before
> divided in order to have the minimum error rate
> on the baudrate.
> 
> The specific byt setup function is stored in the
> driver_data field of the acpi device id via the
> dw8250_acpi_desc structure.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c | 91 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 87 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index ed31135..7d3e4d9 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -62,6 +62,77 @@ struct dw8250_data {
>  	struct uart_8250_dma	dma;
>  };
>  
> +struct dw8250_acpi_desc {
> +	unsigned int uartclk;

This one we could actually drop while at it. The uartclk was
originally delivered as driver data in case of ACPI, but we now get a
clk for ACPI enumerated boards.

> +	void (*setup)(struct uart_8250_port *up);

Why not just have the set_termios hook here?

> +};
> +
> +#define BYT_PRV_CLK			0x800
> +#define BYT_PRV_CLK_EN			(1 << 0)
> +#define BYT_PRV_CLK_M_VAL_SHIFT		1
> +#define BYT_PRV_CLK_N_VAL_SHIFT		16
> +#define BYT_PRV_CLK_UPDATE		(1 << 31)
> +
> +static void byt_set_termios(struct uart_port *p, struct ktermios *termios,
> +			    struct ktermios *old)
> +{
> +	unsigned int baud = tty_termios_baud_rate(termios);
> +	unsigned int m, n;
> +	u32 reg;
> +
> +	/*
> +	* For baud rates 0.5M, 1M, 1.5M, 2M, 2.5M, 3M, 3.5M and 4M the
> +	* dividers must be adjusted.
> +	*
> +	* uartclk = (m / n) * 100 MHz, where m <= n
> +	*/
> +	switch (baud) {
> +	case 500000:
> +	case 1000000:
> +	case 2000000:
> +	case 4000000:
> +		m = 64;
> +		n = 100;
> +		p->uartclk = 64000000;
> +		break;
> +	case 3500000:
> +		m = 56;
> +		n = 100;
> +		p->uartclk = 56000000;
> +		break;
> +	case 1500000:
> +	case 3000000:
> +		m = 48;
> +		n = 100;
> +		p->uartclk = 48000000;
> +		break;
> +	case 2500000:
> +		m = 40;
> +		n = 100;
> +		p->uartclk = 40000000;
> +		break;
> +	default:
> +		m = 2304;
> +		n = 3125;
> +		p->uartclk = 73728000;
> +	}
> +
> +	/* Reset the clock */
> +	reg = (m << BYT_PRV_CLK_M_VAL_SHIFT) | (n << BYT_PRV_CLK_N_VAL_SHIFT);
> +	writel(reg, p->membase + BYT_PRV_CLK);
> +	reg |= BYT_PRV_CLK_EN | BYT_PRV_CLK_UPDATE;
> +	writel(reg, p->membase + BYT_PRV_CLK);
> +
> +	serial8250_do_set_termios(p, termios, old);
> +}

Well, we are already handling this same refclk in the clk that is
provided to this driver in case of BYT, so we should probable handle
this in that as well. Then we could have a more generic set_termios
where we do something like this..

static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
                               struct ktermios *old)
{
        unsigned int baud = tty_termios_baud_rate(termios);
        struct dw8250_data *d = p->private_data;
        unsigned int rate;
        int ret;

        rate = clk_round_rate(d->clk, baud*16);
        ret = clk_set_rate(d->clk, rate);
        if (!ret)
                p->uartclk = rate;
        serial8250_do_set_termios(p, termios, old);
}

But I don't have a problem if we go ahead with this first. We can
always change it later. In any case, I'll prepare the clock driver in
drivers/acpi/acpi_lpss.c for this. Let's see what Rafael and Mika
think about it.


Thanks,

-- 
heikki
