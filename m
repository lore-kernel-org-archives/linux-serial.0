From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/6] TTY: fix DTR being raised on hang up
Date: Fri, 15 Mar 2013 07:03:08 -0400
Message-ID: <1363345388.3194.148.camel@thor.lan>
References: <51361724.4050107@suse.cz>
	 <1362668153-10972-1-git-send-email-jhovold@gmail.com>
	 <1362668153-10972-4-git-send-email-jhovold@gmail.com>
	 <1363203823.25976.102.camel@thor.lan> <20130315092401.GB28843@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130315092401.GB28843@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2013-03-15 at 10:24 +0100, Johan Hovold wrote:
> On Wed, Mar 13, 2013 at 03:43:43PM -0400, Peter Hurley wrote:
> > On Thu, 2013-03-07 at 15:55 +0100, Johan Hovold wrote:
> > > Make sure to check ASYNC_INITIALISED before raising DTR when waking up
> > > from blocked open in tty_port_block_til_ready.
> > > 
> > > Currently DTR could get raised at hang up as a blocked process would
> > > raise DTR unconditionally before checking for hang up and returning.
> > > 
> > > Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > >  drivers/tty/tty_port.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > > index 3de5918..52f1066 100644
> > > --- a/drivers/tty/tty_port.c
> > > +++ b/drivers/tty/tty_port.c
> > > @@ -355,7 +355,7 @@ int tty_port_block_til_ready(struct tty_port *port,
> > >  
> > >  	while (1) {
> > >  		/* Indicate we are open */
> > > -		if (tty->termios.c_cflag & CBAUD)
> > > +		if (C_BAUD(tty) && test_bit(ASYNCB_INITIALIZED, &port->flags))
> > >  			tty_port_raise_dtr_rts(port);
> > >  
> > >  		prepare_to_wait(&port->open_wait, &wait, TASK_INTERRUPTIBLE);
> > 
> > This is ok, but there are 6 other *_block_til_ready() functions:
     ^^^^^^
Comment on patch

> Yes, but that's not really a comment on this patch, is it?
> 
> The purpose of this series is to fix the tty-port implementation, and
> I've only touched individual drivers when I had to in order not to break
> anything due to changed assumptions.
> 
> There's a ton of buggy and odd behaviour to be found once you start
> turning the stones. Drivers like the ones below really ought to be
> using tty ports and it's helpers.

Sure, I understand.

OTOH, tty_port and these drivers stem from the same ancestor and it's
partly because of localized bug fixes like these that the drivers have
buggy and odd behavior (because tty_port gets fixed and these do not).

As you can verify from the changelogs of these drivers, it's traditional
to continue to maintain the common aspects, despite the desire to
abandon them.

That said, I'm not the maintainer so feel free to disagree with my
point-of-view.

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
