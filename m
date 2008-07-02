From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm_uart: Support uart_wait_until_sent()
Date: Wed, 2 Jul 2008 02:46:54 -0500
Message-ID: <4768A00D-3C8B-4AF2-A2E1-DE9C9BD055E4@kernel.crashing.org>
References: <200806261355.09334.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49933 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750700AbYGBHrC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jul 2008 03:47:02 -0400
In-Reply-To: <200806261355.09334.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org


On Jun 26, 2008, at 6:55 AM, Laurent Pinchart wrote:

> Set port->fifosize to the software FIFO size, and update the port  
> timeout
> when the baud rate is modified. SCC ports have an optional 32 byte  
> hardware
> FIFO which is currently not taken into account, as there is no  
> documented way
> to check when the FIFO becomes empty.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

I spoke to soon about being able to apply this.  Can you respin this  
against my powerpc-next tree.  Also, I had troubles applying this due  
to mailer formatting issues.

- k

> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/ 
> serial/cpm_uart/cpm_uart_core.c
> index a19dc7e..151cad2 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -547,6 +547,11 @@ static void cpm_uart_set_termios(struct  
> uart_port *port,
> 	}
>
> 	/*
> +	 * Update the timeout
> +	 */
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	/*
> 	 * Set up parity check flag
> 	 */
> #define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK| 
> INPCK))
> @@ -1154,6 +1159,7 @@ int cpm_uart_drv_get_platform_data(struct  
> platform_device *pdev, int is_con)
> 	pinfo->port.uartclk = pdata->uart_clk;
> 	pinfo->port.mapbase = (unsigned long)mem;
> 	pinfo->port.irq = platform_get_irq(pdev, 0);
> +	pinfo->port.fifosize = pinfo->tx_nrfifos * pinfo->tx_fifosize;
>
> 	return 0;
> }
> -- 
> 1.5.0
>
> -- 
> Laurent Pinchart
> CSE Semaphore Belgium
>
> Chaussee de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
>
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75

