From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Fwd: [PATCH v2 0/4] TTY: port hangup and close fixes]
Date: Thu, 7 Mar 2013 10:43:20 +0100
Message-ID: <20130307094320.GB23635@localhost>
References: <1362085054.3337.20.camel@thor.lan>
 <51361724.4050107@suse.cz>
 <20130306165211.GA23635@localhost>
 <1362597296.18799.198.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1362597296.18799.198.camel-AsKIXgLx6sE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 06, 2013 at 02:14:56PM -0500, Peter Hurley wrote:
> On Wed, 2013-03-06 at 17:52 +0100, Johan Hovold wrote:
> 
> > > > @@ -225,15 +232,13 @@ void tty_port_hangup(struct tty_port *port)
> > >         spin_lock_irqsave(&port->lock, flags);
> > >         port->count = 0;
> > >         port->flags &= ~ASYNC_NORMAL_ACTIVE;
> > > -       if (port->tty) {
> > > +       if (port->tty)
> > >                 set_bit(TTY_IO_ERROR, &port->tty->flags);
> > > -               tty_kref_put(port->tty);
> > > -       }
> > > -       port->tty = NULL;
> > >         spin_unlock_irqrestore(&port->lock, flags);
> > > > +       tty_port_shutdown(port, port->tty);
> > > 
> > > What prevents port->tty to be NULL here already?
> > 
> > Nothing, I'll get a new reference within the port lock section as you
> > just suggested elsewhere in this thread.
> 
> Don't do that. Steal the tty and put the kref after like this:
 
Allright.

> > Yes, I did. First, the order should not matter for blocked opens as they
> > will exit their wait loops based on tty_hung_up_p(filp) either way.
> 
> Only if the open() was ever successful, otherwise the filp won't be in
> the tty->tty_files list. That's why the blocking opens also check
> ASYNC_INITIALIZED (or ASYNCB_INITIALIZED depending on which they use).
> Which is why I said it was actually better to shutdown() first, then
> wake up the blocked opens.

ASYNC_INITIALIZED have also been cleared when the blocked opens are
being woken up from tty_port_close_end.

And the filp is added to tty_files before open() is called:

===>    tty_add_file(tty, filp);

	check_tty_count(tty, __func__);
	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
	    tty->driver->subtype == PTY_TYPE_MASTER)
		noctty = 1;
#ifdef TTY_DEBUG_HANGUP
	printk(KERN_DEBUG "%s: opening %s...\n", __func__, tty->name);
#endif
	if (tty->ops->open)
===>		retval = tty->ops->open(tty, filp);

so a blocked open must have hung_up_tty_fops when woken up from hangup,
right?

Either way, postponing wake-up somewhat in tty_port_hangup should be
fine.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
