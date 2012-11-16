From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: bfin_uart: Don't switch baud rate untill the
 transfer buffer is empty.
Date: Thu, 15 Nov 2012 16:59:46 -0800
Message-ID: <20121116005946.GA1727@kroah.com>
References: <1352264142-30771-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:45997 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab2KPA7u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 19:59:50 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so904607dak.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 16:59:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352264142-30771-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-serial@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Wed, Nov 07, 2012 at 12:55:42PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> set_termios may be invoked before the former data transfer is completed. Block until the
> tranfer is done.
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/tty/serial/bfin_uart.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
> index 9242d56..71c0c09 100644
> --- a/drivers/tty/serial/bfin_uart.c
> +++ b/drivers/tty/serial/bfin_uart.c
> @@ -869,6 +869,10 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
>  
>  	UART_SET_ANOMALY_THRESHOLD(uart, USEC_PER_SEC / baud * 15);
>  
> +	/* Wait till the transfer buffer is empty */
> +	while (UART_GET_GCTL(uart) & UCEN && !(UART_GET_LSR(uart) & TEMT))
> +		barrier();

Where is the "the hardware is hung" break out of this loop?

And why "barrier()"?

thanks,

greg k-h
