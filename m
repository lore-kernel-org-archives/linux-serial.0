From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/4] tty/serial: at91: prevent null dereference in
 tasklet function
Date: Tue, 7 Jan 2014 17:11:37 -0800
Message-ID: <20140108011137.GA13590@kroah.com>
References: <cover.1389090437.git.nicolas.ferre@atmel.com>
 <69b33ebdc9427b5c036b4ba09151ae88c14a30f4.1389090437.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:32822 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaAHBLI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Jan 2014 20:11:08 -0500
Content-Disposition: inline
In-Reply-To: <69b33ebdc9427b5c036b4ba09151ae88c14a30f4.1389090437.git.nicolas.ferre@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Leilei Zhao <leilei.zhao@atmel.com>, mark.roszko@gmail.com, mdeneen@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, stable@vger.kernel.org

On Tue, Jan 07, 2014 at 11:45:08AM +0100, Nicolas Ferre wrote:
> From: Marek Roszko <mark.roszko@gmail.com>
> 
> Something asks a tasklet to be scheduled when the uart port is closed.

What is that something?  Shouldn't you track that down and find the real
problem here?

> Need to supress the kernel panic for now by checking if the port is NULL or
> not.
> 
> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
> Acked-by: Leilei Zhao <leilei.zhao@atmel.com>
> Cc: <stable@vger.kernel.org> # v3.12
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index c421d11b3d4c..6e68486c83cb 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1360,6 +1360,10 @@ static void atmel_tasklet_func(unsigned long data)
>  	unsigned int status;
>  	unsigned int status_change;
>  
> +	if(!port->state || !port->state->port.tty)
> +		/* uart has been closed */
> +		return;

Did you really test this?

How about running it through checkpatch?

thanks,

greg k-h
