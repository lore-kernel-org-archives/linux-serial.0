From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pch_uart: Add uart device to irq name
Date: Tue, 25 Mar 2014 05:52:49 -0700
Message-ID: <20140325125249.GA6360@kroah.com>
References: <1395739880-8318-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44596 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581AbaCYMvM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Mar 2014 08:51:12 -0400
Content-Disposition: inline
In-Reply-To: <1395739880-8318-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Tue, Mar 25, 2014 at 10:31:20AM +0100, Alexander Stein wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  drivers/tty/serial/pch_uart.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Why?

You need to be a whole lot more descriptive in your patch in order to
get it accepted...

> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 8fa1134..f14630b 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -257,6 +257,8 @@ struct eg20t_port {
>  	dma_addr_t			rx_buf_dma;
>  
>  	struct dentry	*debugfs;
> +#define IRQ_NAME_SIZE 17
> +	char				irq_name[IRQ_NAME_SIZE];
>  
>  	/* protect the eg20t_port private structure and io access to membase */
>  	spinlock_t lock;
> @@ -1343,7 +1345,7 @@ static int pch_uart_startup(struct uart_port *port)
>  		return ret;
>  
>  	ret = request_irq(priv->port.irq, pch_uart_interrupt, IRQF_SHARED,
> -			KBUILD_MODNAME, priv);
> +			priv->irq_name, priv);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1816,6 +1818,8 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
>  	priv->port.line = board->line_no;
>  	priv->trigger = PCH_UART_HAL_TRIGGER_M;
>  
> +	snprintf(priv->irq_name, IRQ_NAME_SIZE, KBUILD_MODNAME ":" PCH_UART_DRIVER_DEVICE "%d", priv->port.line);
> +

And always run your patches through checkpatch.pl, so we don't have to
point out the obvious problems it finds.

thanks,

greg k-h
