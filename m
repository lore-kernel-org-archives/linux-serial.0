From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC 2/4] tty: fix DTR/RTS not being dropped on hang up
Date: Wed, 13 Feb 2013 14:32:53 -0500
Message-ID: <1360783973.8499.48.camel@thor.lan>
References: <20130213142513.GA21078@localhost>
	 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
	 <1360776446-31371-3-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360776446-31371-3-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2013-02-13 at 18:27 +0100, Johan Hovold wrote:
> Move HUPCL handling to port shutdown so that DTR/RTS is dropped also on
> hang up.
> 
> Currently a hung up port will return immediately from
> tty_port_close_start leaving DTR/RTS unchanged.
> ---
>  drivers/tty/tty_port.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 57a061e..ffe3689 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -198,11 +198,20 @@ EXPORT_SYMBOL(tty_port_tty_set);
>  
>  static void tty_port_shutdown(struct tty_port *port)
>  {
> +	struct tty_struct *tty = port->tty;
> +
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

port->ops->shutdown() requires the hardware to reset anyway, including
the DTR/RTS state.



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
