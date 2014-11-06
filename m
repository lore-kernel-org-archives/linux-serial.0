From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_dma: call serial8250_tx_dma unconditionally
Date: Wed, 5 Nov 2014 19:26:01 -0800
Message-ID: <20141106032601.GA10724@kroah.com>
References: <1412772129-22816-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39760 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaKFD0C (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Nov 2014 22:26:02 -0500
Content-Disposition: inline
In-Reply-To: <1412772129-22816-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org

On Wed, Oct 08, 2014 at 03:42:09PM +0300, Andy Shevchenko wrote:
> Since we have the same check inside the function we may drop it away in
> __dma_tx_complete().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 148ffe4..189ae3c 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -36,8 +36,7 @@ static void __dma_tx_complete(void *param)
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);
>  
> -	if (!uart_circ_empty(xmit) && !uart_tx_stopped(&p->port))
> -		serial8250_tx_dma(p);
> +	serial8250_tx_dma(p);
>  
>  	spin_unlock_irqrestore(&p->port.lock, flags);
>  }

The code in this area has changed a lot now due to some dma work added
to this driver.  Can you look at my tty-testing branch of tty.git on
git.kernel.org and see if this is still relevant now?  If so, please
refresh this patch and resend.

thanks,

greg k-h
