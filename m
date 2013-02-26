From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 2/4] TTY: fix DTR not being dropped on hang up
Date: Tue, 26 Feb 2013 11:59:34 +0100
Message-ID: <20130226105934.GI30855@localhost>
References: <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <1361376172-31860-1-git-send-email-jhovold@gmail.com>
 <1361376172-31860-3-git-send-email-jhovold@gmail.com>
 <1361629082.3407.7.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62485 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab3BZLAY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2013 06:00:24 -0500
Content-Disposition: inline
In-Reply-To: <1361629082.3407.7.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johan Hovold <jhovold@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

On Sat, Feb 23, 2013 at 09:18:02AM -0500, Peter Hurley wrote:
> On Wed, 2013-02-20 at 17:02 +0100, Johan Hovold wrote:
> > Move HUPCL handling to port shutdown so that DTR is dropped also on hang
> > up (tty_port_close is a noop for hung-up ports).
> > 
> > Also do not try to drop DTR for uninitialised ports where it has never
> > been raised (e.g. after a failed open).
> > 
> > Nine drivers currently call tty_port_close_start directly (rather than
> > through tty_port_close) and seven of them lower DTR as part of their
> > close (if the port has been initialised). Fixup the remaining two
> > drivers so that it continues to be lowered also on normal (non-HUP)
> > close. [ Note that most of those other seven drivers did not expect DTR
> > to have been dropped by tty_port_close_start in the first place. ]
> > 
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  drivers/tty/mxser.c    |  4 ++++
> >  drivers/tty/n_gsm.c    |  4 ++++
> >  drivers/tty/tty_port.c | 23 +++++++++++++----------
> >  3 files changed, 21 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
> > index 484b6a3..c547887 100644
> > --- a/drivers/tty/mxser.c
> > +++ b/drivers/tty/mxser.c
> > @@ -1084,6 +1084,10 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
> >  	mutex_lock(&port->mutex);
> >  	mxser_close_port(port);
> >  	mxser_flush_buffer(tty);
> > +	if (test_bit(ASYNCB_INITIALIZED, &port->flags)) {
> > +		if (tty->termios.c_cflag & HUPCL)
> > +			tty_port_lower_dtr_rts(port);
> > +	}
> >  	mxser_shutdown_port(port);
> >  	clear_bit(ASYNCB_INITIALIZED, &port->flags);
> >  	mutex_unlock(&port->mutex);
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 4a43ef5d7..049013e 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -2968,6 +2968,10 @@ static void gsmtty_close(struct tty_struct *tty, struct file *filp)
> >  	if (tty_port_close_start(&dlci->port, tty, filp) == 0)
> >  		goto out;
> >  	gsm_dlci_begin_close(dlci);
> > +	if (test_bit(ASYNCB_INITIALIZED, &dlci->port.flags)) {
> > +		if (tty->termios.c_cflag & HUPCL)
> > +			tty_port_lower_dtr_rts(&dlci->port);
> > +	}
> >  	tty_port_close_end(&dlci->port, tty);
> >  	tty_port_tty_set(&dlci->port, NULL);
> >  out:
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index 57a061e..506f579 100644
> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -198,15 +198,25 @@ EXPORT_SYMBOL(tty_port_tty_set);
> >  
> >  static void tty_port_shutdown(struct tty_port *port)
> >  {
> > +	struct tty_struct *tty = tty_port_tty_get(port);
> > +
> 
> I know I said this was done, but if this hasn't been pushed into
> tty-next yet, I'd rather this was:
> 
> static void tty_port_shutdown(struct tty_port *port,
> 			      struct tty_struct *tty)
> 
> and not get the port reference. Both call sites already ensure that
> there is a kref on the tty or tty is NULL.
> 
> (I ended up re-looking at this patch to double-check that it won't drop
> DTR for the console, which it doesn't so that is good).

I'll send a v2.

Thanks, 
Johan
