From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: fix parisc boot hang
Date: Fri, 2 Jan 2015 10:51:27 -0800
Message-ID: <20150102185127.GA8636@kroah.com>
References: <1420221913.2072.7.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420221913.2072.7.camel@HansenPartnership.com>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc <linux-parisc@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 02, 2015 at 10:05:13AM -0800, James Bottomley wrote:
> From: James Bottomley <JBottomley@Parallels.com>
> 
> This is a partial revert of 2f2dafe (serial: serial_core.c: printk
> replacement) which gets us booting again.  The real problem seems to be
> the _emit path in early boot.  However, until we can root cause it, we
> need at least to get boot working.
> 
> Fixes: 2f2dafe77df2c78e189a9fa6b1879dffd06ae5a1
> Cc: stable@vger.kernel.org
> Signed-off-by: James Bottomley <JBottomley@Parallels.com>
> 
> ---
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 57ca61b..984605b 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2164,7 +2164,9 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
>  		break;
>  	}
>  
> -	dev_info(port->dev, "%s%d at %s (irq = %d, base_baud = %d) is a %s\n",
> +	printk(KERN_INFO "%s%s%s%d at %s (irq = %d, base_baud = %d) is a %s\n",
> +	       port->dev ? dev_name(port->dev) : "",
> +	       port->dev ? ": " : "",
>  	       drv->dev_name,
>  	       drv->tty_driver->name_base + port->line,
>  	       address, port->irq, port->uartclk / 16, uart_type(port));

Very odd, but I'll go queue it up, thanks.

greg k-h
