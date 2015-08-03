From: Greg KH <greg@kroah.com>
Subject: Re: [v2 1/3] serial: 8250_dw: Add support for big-endian MMIO
 accesses
Date: Mon, 3 Aug 2015 16:43:26 -0700
Message-ID: <20150803234326.GB5257@kroah.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-2-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437886478-29273-2-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 26, 2015 at 07:54:36AM +0300, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> Add support for UPIO_MEM32BE in addition to UPIO_MEM32.
> dw8250_serial_out32() main functionality was moved to new
> function called dw8250_check_LCR().
> 
> We use new 2 accessors similar to little endian, called
> dw8250_serial_out32be() and dw8250_serial_in32be().
> 
> Both little and big endian accessors use dw8250_check_LCR()
> for their dw8250_serial_out32{,be}().
> 
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c |   42 ++++++++++++++++++++++++++++++------
>  1 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index d48b506..5c60ec8 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -173,15 +173,13 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
>  }
>  #endif /* CONFIG_64BIT */
>  
> -static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
> +static void dw8250_check_LCR(struct uart_port *p, int offset, int value)
>  {
>  	struct dw8250_data *d = p->private_data;
>  
>  	if (offset == UART_MCR)
>  		d->last_mcr = value;
>  
> -	writel(value, p->membase + (offset << p->regshift));

Why drop this write?

> -
>  	/* Make sure LCR write wasn't ignored */
>  	if (offset == UART_LCR) {
>  		int tries = 1000;
> @@ -190,7 +188,12 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
>  			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
>  				return;
>  			dw8250_force_idle(p);
> -			writel(value, p->membase + (UART_LCR << p->regshift));
> +			if (p->iotype == UPIO_MEM32BE)
> +				iowrite32be(value,
> +					p->membase + (UART_LCR << p->regshift));
> +			else
> +				writel(value,
> +					p->membase + (UART_LCR << p->regshift));

Shouldn't this be hidden behind some other type of accessor?  Why is
this one writel() "special"?

thanks,

greg k-h
