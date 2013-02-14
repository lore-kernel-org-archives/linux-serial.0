From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 2/4] tty: fix DTR/RTS not being dropped on hang up
Date: Thu, 14 Feb 2013 10:04:21 +0100
Message-ID: <20130214090421.GA2130@localhost>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <1360776446-31371-3-git-send-email-jhovold@gmail.com>
 <1360783973.8499.48.camel@thor.lan>
 <1360804273.3385.23.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360804273.3385.23.camel-AsKIXgLx6sE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 13, 2013 at 08:11:13PM -0500, Peter Hurley wrote:
> On Wed, 2013-02-13 at 14:32 -0500, Peter Hurley wrote:
> > On Wed, 2013-02-13 at 18:27 +0100, Johan Hovold wrote:
> > > Move HUPCL handling to port shutdown so that DTR/RTS is dropped also on
> > > hang up.
> > > 
> > > Currently a hung up port will return immediately from
> > > tty_port_close_start leaving DTR/RTS unchanged.
> > > ---
> > >  drivers/tty/tty_port.c | 22 ++++++++++++----------
> > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > > index 57a061e..ffe3689 100644
> > > --- a/drivers/tty/tty_port.c
> > > +++ b/drivers/tty/tty_port.c
> > > @@ -198,11 +198,20 @@ EXPORT_SYMBOL(tty_port_tty_set);
> > >  
> > >  static void tty_port_shutdown(struct tty_port *port)
> > >  {
> > > +	struct tty_struct *tty = port->tty;
> > > +
> > >  	mutex_lock(&port->mutex);
> > >  	if (port->console)
> > >  		goto out;
> > >  
> > >  	if (test_and_clear_bit(ASYNCB_INITIALIZED, &port->flags)) {
> > > +		/*
> > > +		 * Drop DTR/RTS if HUPCL is set. This causes any attached
> > > +		 * modem to hang up the line.
> > > +		 */
> > > +		if (!tty || tty->termios.c_cflag & HUPCL)
> > > +			tty_port_lower_dtr_rts(port);
> > > +
> > 
> > port->ops->shutdown() requires the hardware to reset anyway, including
> > the DTR/RTS state.
> 
> Ok, after reviewing this further, I like this more.
> 
> For one, there is more flexibility for tty drivers that have a custom
> close() routine (ie, one that doesn't call tty_port_close()). At the
> same time, every call site of tty_port_close_start() needs to be checked
> to ensure it does not assume (or does not require) DTR to be dropped:
> 
> char/pcmcia/synclink_cs.c:	if (tty_port_close_start(port, tty, filp) == 0)
> tty/synclinkmp.c:	if (tty_port_close_start(&info->port, tty, filp) == 0)
> tty/rocket.c:	if (tty_port_close_start(port, tty, filp) == 0)
> tty/amiserial.c:	if (tty_port_close_start(port, tty, filp) == 0)
> tty/n_gsm.c:	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
> tty/mxser.c:	if (tty_port_close_start(port, tty, filp) == 0)
> tty/synclink_gt.c:	if (tty_port_close_start(&info->port, tty, filp) == 0)
> tty/serial/serial_core.c:	if (tty_port_close_start(port, tty, filp) == 0)
> tty/synclink.c:	if (tty_port_close_start(&info->port, tty, filp) == 0)			 
> 
> In the case of the serial core, this actually fixes the code excerpt
> below where tty_port_close_start() prematurely drops DTR before the uart
> can stop_rx() or wait_until_sent().

Yeah, I mentioned both of these points in the cover letter of the
series. From a quick browse it seemed that I would have to fix n_gsm.c
and mxser.c, but I'll have a closer look at this later.

Thanks,
Johan

> static void uart_close(struct tty_struct *tty, struct file *filp)
> {
> 	struct uart_state *state = tty->driver_data;
> 	struct tty_port *port;
> 	struct uart_port *uport;
> 	unsigned long flags;
> 
> 	if (!state)
> 		return;
> 
> 	uport = state->uart_port;
> 	port = &state->port;
> 
> 	pr_debug("uart_close(%d) called\n", uport->line);
> 
> 	if (tty_port_close_start(port, tty, filp) == 0)
> 		return;
> 
> 	/*
> 	 * At this point, we stop accepting input.  To do this, we
> 	 * disable the receive line status interrupts.
> 	 */
> 	if (port->flags & ASYNC_INITIALIZED) {
> 		unsigned long flags;
> 		spin_lock_irqsave(&uport->lock, flags);
> 		uport->ops->stop_rx(uport);
> 		spin_unlock_irqrestore(&uport->lock, flags);
> 		/*
> 		 * Before we drop DTR, make sure the UART transmitter
> 		 * has completely drained; this is especially
> 		 * important if there is a transmit FIFO!
> 		 */
> 		uart_wait_until_sent(tty, uport->timeout);
> 	}
> 
> 	mutex_lock(&port->mutex);
> 	uart_shutdown(tty, state);
> 	uart_flush_buffer(tty);
> 
> 
> Regards,
> Peter Hurley
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
