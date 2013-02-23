From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/4] TTY: fix DTR not being dropped on hang up
Date: Sat, 23 Feb 2013 09:18:02 -0500
Message-ID: <1361629082.3407.7.camel@thor.lan>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
	 <1361376172-31860-1-git-send-email-jhovold@gmail.com>
	 <1361376172-31860-3-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:45610 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab3BWOSJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 23 Feb 2013 09:18:09 -0500
In-Reply-To: <1361376172-31860-3-git-send-email-jhovold@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, 2013-02-20 at 17:02 +0100, Johan Hovold wrote:
> Move HUPCL handling to port shutdown so that DTR is dropped also on hang
> up (tty_port_close is a noop for hung-up ports).
> 
> Also do not try to drop DTR for uninitialised ports where it has never
> been raised (e.g. after a failed open).
> 
> Nine drivers currently call tty_port_close_start directly (rather than
> through tty_port_close) and seven of them lower DTR as part of their
> close (if the port has been initialised). Fixup the remaining two
> drivers so that it continues to be lowered also on normal (non-HUP)
> close. [ Note that most of those other seven drivers did not expect DTR
> to have been dropped by tty_port_close_start in the first place. ]
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  drivers/tty/mxser.c    |  4 ++++
>  drivers/tty/n_gsm.c    |  4 ++++
>  drivers/tty/tty_port.c | 23 +++++++++++++----------
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> index 484b6a3..c547887 100644
> --- a/drivers/tty/mxser.c
> +++ b/drivers/tty/mxser.c
> @@ -1084,6 +1084,10 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
>  	mutex_lock(&port->mutex);
>  	mxser_close_port(port);
>  	mxser_flush_buffer(tty);
> +	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
> +		if (tty->termios.c_cflag & HUPCL)
> +			tty_port_lower_dtr_rts(port);
> +	}
>  	mxser_shutdown_port(port);
>  	clear_bit(ASYNCB_INITIALIZED, &port->flags);
>  	mutex_unlock(&port->mutex);
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 4a43ef5d7..049013e 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2968,6 +2968,10 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
>  	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
>  		goto out;
>  	gsm_dlci_begin_close(dlci);
> +	if (test_bit(ASYNCB_INITIALIZED, &dlci->port.flags)) {
> +		if (tty->termios.c_cflag & HUPCL)
> +			tty_port_lower_dtr_rts(&dlci->port);
> +	}
>  	tty_port_close_end(&dlci->port, tty);
>  	tty_port_tty_set(&dlci->port, NULL);
>  out:
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 57a061e..506f579 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -198,15 +198,25 @@ EXPORT_SYMBOL(tty_port_tty_set);
>  
>  static void tty_port_shutdown(struct tty_port *port)
>  {
> +	struct tty_struct *tty = tty_port_tty_get(port);
> +

I know I said this was done, but if this hasn't been pushed into
tty-next yet, I'd rather this was:

static void tty_port_shutdown(struct tty_port *port,
			      struct tty_struct *tty)

and not get the port reference. Both call sites already ensure that
there is a kref on the tty or tty is NULL.

(I ended up re-looking at this patch to double-check that it won't drop
DTR for the console, which it doesn't so that is good).

>  	mutex_lock(&port->mutex);
>  	if (port->console)
>  		goto out;
>  
>  	if (test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags)) {
> +		/*
> +		 * Drop DTR/RTS if HUPCL is set. This causes any attached
> +		 * modem to hang up the line.
> +		 */
> +		if (!tty || tty->termios.c_cflag & HUPCL)
> +			tty_port_lower_dtr_rts(port);
> +
>  		if (port->ops->shutdown)
>  			port->ops->shutdown(port);
>  	}
>  out:
> +	tty_kref_put(tty);
>  	mutex_unlock(&port->mutex);
>  }
>  
> @@ -225,15 +235,13 @@ void tty_port_hangup(struct tty_port *port)
>  	spin_lock_irqsave(&port->lock, flags);
>  	port->count = 0;
>  	port->flags &= ~ASYNC_NORMAL_ACTIVE;
> -	if (port->tty) {
> +	if (port->tty)
>  		set_bit(TTY_IO_ERROR, &port->tty->flags);
> -		tty_kref_put(port->tty);
> -	}
> -	port->tty = NULL;
>  	spin_unlock_irqrestore(&port->lock, flags);
> +	tty_port_shutdown(port);
> +	tty_port_tty_set(port, NULL);
>  	wake_up_interruptible(&port->open_wait);
>  	wake_up_interruptible(&port->delta_msr_wait);
> -	tty_port_shutdown(port);
>  }
>  EXPORT_SYMBOL(tty_port_hangup);
>  
> @@ -452,11 +460,6 @@ int tty_port_close_start(struct tty_port *port,
>  	/* Flush the ldisc buffering */
>  	tty_ldisc_flush(tty);
>  
> -	/* Drop DTR/RTS if HUPCL is set. This causes any attached modem to
> -	   hang up the line */
> -	if (tty->termios.c_cflag & HUPCL)
> -		tty_port_lower_dtr_rts(port);
> -
>  	/* Don't call port->drop for the last reference. Callers will want
>  	   to drop the last active reference in ->shutdown() or the tty
>  	   shutdown path */


