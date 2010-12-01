From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2)
Date: Tue, 30 Nov 2010 17:17:58 -0800
Message-ID: <20101201011758.GA21009@kroah.com>
References: <1290436007-683-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:51179 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425Ab0LAB2e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Nov 2010 20:28:34 -0500
Content-Disposition: inline
In-Reply-To: <1290436007-683-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org

On Mon, Nov 22, 2010 at 02:26:47PM +0000, Jamie Iles wrote:
> Some platforms contain a Synopsys DesignWare APB UART that is attached
> to a 32-bit APB bus where sub-word accesses are not allowed. Add a new
> IO type (UPIO_DWAPB32) that performs 32 bit acccesses to the UART.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  drivers/serial/8250.c        |   18 ++++++++++++++++--
>  drivers/serial/serial_core.c |    2 ++
>  include/linux/serial_core.h  |    1 +
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 09a5508..244a982 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -464,7 +464,12 @@ static void dwapb_serial_out(struct uart_port *p, int offset, int value)
>  		struct uart_8250_port *up = (struct uart_8250_port *)p;
>  		up->lcr = value;
>  	}
> -	writeb(value, p->membase + offset);
> +
> +	if (UPIO_DWAPB == p->iotype)

I understand why people feel they have to write code like this, but
please, don't, put the variable test the other way around.  The complier
will complain if you accidentally use '=' instead of '=='


> +		writeb(value, p->membase + offset);
> +	else
> +		writel(value, p->membase + offset);
> +

As this is on the "fast path" for writing data out, isn't it going to
slow down the UPIO_DWAPB users as well?

thanks,

greg k-h
