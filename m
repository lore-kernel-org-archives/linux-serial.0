From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] tty: serial: mpc5xxx: add support for mark/space parity
Date: Wed, 29 Aug 2012 23:56:53 +0200
Message-ID: <20120829235653.7b96baf6@wker>
References: <1346076194-1830-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44922 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab2H2V5J (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Aug 2012 17:57:09 -0400
In-Reply-To: <1346076194-1830-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>

Hi Wolfram,

On Mon, 27 Aug 2012 16:03:14 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Tested on a custom MPC5200B-board using some fancy industrial protocol.
> Verified that MPC512x has identical bits, so should work there as well.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/mpc52xx_uart.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Looks good, so

Acked-by: Anatolij Gustschin <agust@denx.de>

> diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
> index bedac0d..f19d04e 100644
> --- a/drivers/tty/serial/mpc52xx_uart.c
> +++ b/drivers/tty/serial/mpc52xx_uart.c
> @@ -775,11 +775,15 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
>  	}
>  
>  	if (new->c_cflag & PARENB) {
> +		if (new->c_cflag & CMSPAR)
> +			mr1 |= MPC52xx_PSC_MODE_PARFORCE;
> +
> +		/* With CMSPAR, PARODD also means high parity (same as termios) */
>  		mr1 |= (new->c_cflag & PARODD) ?
>  			MPC52xx_PSC_MODE_PARODD : MPC52xx_PSC_MODE_PAREVEN;
> -	} else
> +	} else {
>  		mr1 |= MPC52xx_PSC_MODE_PARNONE;
> -
> +	}
>  
>  	mr2 = 0;
>  
