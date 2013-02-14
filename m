From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [RFC 3/4] tty: clean up port drain-delay handling
Date: Thu, 14 Feb 2013 10:12:06 +0100
Message-ID: <20130214091206.GB2130@localhost>
References: <20130213142513.GA21078@localhost>
 <1360776446-31371-1-git-send-email-jhovold@gmail.com>
 <1360776446-31371-4-git-send-email-jhovold@gmail.com>
 <1360805971.3385.27.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:64574 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab3BNJN3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 14 Feb 2013 04:13:29 -0500
Content-Disposition: inline
In-Reply-To: <1360805971.3385.27.camel@thor.lan>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johan Hovold <jhovold@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Chris Ruehl <chris.ruehl@gtsys.com.hk>, Alan Stern <stern@rowland.harvard.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Wed, Feb 13, 2013 at 08:39:31PM -0500, Peter Hurley wrote:
> On Wed, 2013-02-13 at 18:27 +0100, Johan Hovold wrote:
> > Move port drain-delay handling to a separate function.
> > ---
> >  drivers/tty/tty_port.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index ffe3689..0a5e955 100644
> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -407,6 +407,23 @@ int tty_port_block_til_ready(struct tty_port *port,
> >  }
> >  EXPORT_SYMBOL(tty_port_block_til_ready);
> >  
> > +static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
> > +{
> > +	unsigned int bps = tty_get_baud_rate(tty);
> > +	long timeout;
> 
> 
> > +	if (!port->drain_delay)
> > +		return;
>                ^^^^^^^^^^^^
> How about drop this and ...
> 
> > +	if (bps > 1200) {
> > +		timeout = (HZ * 10 * port->drain_delay) / bps;
> > +		timeout = max_t(long, timeout, HZ / 10);
> > +	} else {
> > +		timeout = 2 * HZ;
> > +	}
> > +	schedule_timeout_interruptible(timeout);
> > +}
> > +
> >  int tty_port_close_start(struct tty_port *port,
> >  				struct tty_struct *tty, struct file *filp)
> >  {
> > @@ -445,17 +462,7 @@ int tty_port_close_start(struct tty_port *port,
> >  	if (test_bit(ASYNCB_INITIALIZED, &port->flags) &&
> >  			port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
> >  		tty_wait_until_sent_from_close(tty, port->closing_wait);
> > -	if (port->drain_delay) {
> > -		unsigned int bps = tty_get_baud_rate(tty);
> > -		long timeout;
> > -
> > -		if (bps > 1200)
> > -			timeout = max_t(long,
> > -				(HZ * 10 * port->drain_delay) / bps, HZ / 10);
> > -		else
> > -			timeout = 2 * HZ;
> > -		schedule_timeout_interruptible(timeout);
> > -	}
> > +	tty_port_drain_delay(port, tty);
> 
> ....
> 	if (port->drain_delay)
> 		tty_port_drain_delay(port, tty);

Yeah, I agree. Checking at the call site would perhaps be more clear in
this case.

Thanks,
Johan
