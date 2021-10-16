Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255D0C433F5
	for <linux-serial@archiver.kernel.org>; Sat, 16 Oct 2021 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013F660E97
	for <linux-serial@archiver.kernel.org>; Sat, 16 Oct 2021 15:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhJPPm1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 16 Oct 2021 11:42:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:40030 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbhJPPm0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 16 Oct 2021 11:42:26 -0400
Date:   Sat, 16 Oct 2021 18:40:16 +0300
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru EF10680307C7
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Johan Hovold <johan@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] serial: 8250: rename unlock labels
Message-ID: <20211016154016.6ki2myrj6koglkqq@mobilestation>
References: <20211015111422.1027-1-johan@kernel.org>
 <20211015111422.1027-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211015111422.1027-3-johan@kernel.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 15, 2021 at 01:14:21PM +0200, Johan Hovold wrote:
> Rename a couple of oddly named labels that are used to unlock before
> returning after what they do (rather than after the context they are
> used in) to improve readability.

Initially I had the same thought in mind when was adding the update
clock method because normally I add the GOTO-target-related suffix for
the cleanup path. But in this case I decided to stick with the locally
selected naming scheme, since it also made sense in the meaning: "goto
Out_of_the_Lock". So in case of the autoconfig() method leaving the
"out_lock" label name was reasonable because the code program counter
jumps out of the locked section of the function while the "goto out"
jumps to out of the method itself.

-Serge

> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/tty/serial/8250/8250_port.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index e4dd82fd7c2a..5775cbff8f6e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1338,7 +1338,7 @@ static void autoconfig(struct uart_8250_port *up)
>  	up->tx_loadsz = uart_config[port->type].tx_loadsz;
>  
>  	if (port->type == PORT_UNKNOWN)
> -		goto out_lock;
> +		goto out_unlock;
>  
>  	/*
>  	 * Reset the UART.
> @@ -1355,7 +1355,7 @@ static void autoconfig(struct uart_8250_port *up)
>  	else
>  		serial_out(up, UART_IER, 0);
>  
> -out_lock:
> +out_unlock:
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
>  	/*
> @@ -2714,12 +2714,12 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
>  	mutex_lock(&tport->mutex);
>  
>  	if (port->uartclk == uartclk)
> -		goto out_lock;
> +		goto out_unlock;
>  
>  	port->uartclk = uartclk;
>  
>  	if (!tty_port_initialized(tport))
> -		goto out_lock;
> +		goto out_unlock;
>  
>  	termios = &tty->termios;
>  
> @@ -2737,7 +2737,7 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
>  	spin_unlock_irqrestore(&port->lock, flags);
>  	serial8250_rpm_put(up);
>  
> -out_lock:
> +out_unlock:
>  	mutex_unlock(&tport->mutex);
>  	up_write(&tty->termios_rwsem);
>  	tty_kref_put(tty);
> -- 
> 2.32.0
> 
