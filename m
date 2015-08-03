From: Greg KH <greg@kroah.com>
Subject: Re: [v2 2/3] serial: 8250_dw: dw8250_setup_port() use endianness
 aware read.
Date: Mon, 3 Aug 2015 16:42:21 -0700
Message-ID: <20150803234221.GA5257@kroah.com>
References: <1437557699-25722-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-1-git-send-email-noamc@ezchip.com>
 <1437886478-29273-2-git-send-email-noamc@ezchip.com>
 <1437886478-29273-3-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437886478-29273-3-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Jul 26, 2015 at 07:54:37AM +0300, Noam Camus wrote:
> From: Noam Camus <noamc@ezchip.com>
> 
> readl() for UCV and CPR will not work for port type UPIO_MEM32BE.
> Instead we use ioread32be for uart port of type UPIO_MEM32BE.
> 
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> ---
>  drivers/tty/serial/8250/8250_dw.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 5c60ec8..9bc4cac 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -291,7 +291,9 @@ static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
>  static void dw8250_setup_port(struct uart_8250_port *up)
>  {
>  	struct uart_port	*p = &up->port;
> -	u32			reg = readl(p->membase + DW_UART_UCV);
> +	u32			reg = (p->iotype == UPIO_MEM32BE) ?
> +					ioread32be(p->membase + DW_UART_UCV) :
> +					readl(p->membase + DW_UART_UCV);

Ugh.  Just use a "real" if statement for this please.  Don't abuse ? :
lines for no reason.


>  
>  	/*
>  	 * If the Component Version Register returns zero, we know that
> @@ -303,7 +305,9 @@ static void dw8250_setup_port(struct uart_8250_port *up)
>  	dev_dbg_ratelimited(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> -	reg = readl(p->membase + DW_UART_CPR);
> +	reg = (p->iotype == UPIO_MEM32BE) ?
> +		ioread32be(p->membase + DW_UART_CPR) :
> +		readl(p->membase + DW_UART_CPR);

Same here.

And shouldn't all of this be "hidden" behind something else?  You should
not have to do this for each readl call...

thanks,

greg k-h
