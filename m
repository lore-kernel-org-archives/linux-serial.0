From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2)
Date: Wed, 1 Dec 2010 11:27:28 -0800
Message-ID: <20101201192728.GB31841@kroah.com>
References: <1290436007-683-1-git-send-email-jamie@jamieiles.com>
 <20101201011758.GA21009@kroah.com>
 <20101201081044.GM4398@pulham.picochip.com>
 <20101201170125.GA30594@kroah.com>
 <20101201171700.GF2898@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46771 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755308Ab0LAT3z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 14:29:55 -0500
Content-Disposition: inline
In-Reply-To: <20101201171700.GF2898@pulham.picochip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org

On Wed, Dec 01, 2010 at 05:17:00PM +0000, Jamie Iles wrote:
> On Wed, Dec 01, 2010 at 09:01:25AM -0800, Greg KH wrote:
> > On Wed, Dec 01, 2010 at 08:10:44AM +0000, Jamie Iles wrote:
> > > --- a/drivers/serial/8250.c
> > > +++ b/drivers/serial/8250.c
> > > @@ -454,21 +454,40 @@ static void tsi_serial_out(struct uart_port *p, int offset, int value)
> > >  		writeb(value, p->membase + offset);
> > >  }
> > >  
> > > +/* Save the LCR value so it can be re-written when a Busy Detect IRQ occurs. */
> > > +static inline void dwapb_save_out_value(struct uart_port *p, int offset,
> > > +					int value)
> > > +{
> > > +	struct uart_8250_port *up =
> > > +		container_of(p, struct uart_8250_port, port);
> > 
> > container_of, when the original code did a simple cast:
> > 
> > >  static void dwapb_serial_out(struct uart_port *p, int offset, int value)
> > >  {
> > >  	int save_offset = offset;
> > >  	offset = map_8250_out_reg(p, offset) << p->regshift;
> > > -	/* Save the LCR value so it can be re-written when a
> > > -	 * Busy Detect interrupt occurs. */
> > > -	if (save_offset == UART_LCR) {
> > > -		struct uart_8250_port *up = (struct uart_8250_port *)p;
> > > -		up->lcr = value;
> > > -	}
> > > +	dwapb_save_out_value(p, save_offset, value);
> > 
> > Because of that, are you sure this is correct now?  You might just be
> > getting lucky due to the location of the pointer within the structure,
> > but then the old code was wrong.
> > 
> > Either way, I don't feel comfortable with this, do you?
> struct uart_8250_port is defined in drivers/serial/8250.c as:
> 
> struct uart_8250_port {
>         struct uart_port        port;
>         struct timer_list       timer;          /* "no irq" timer */
> 	...
> };
> 

Ah, yeah, you are right.

> So yes, I'm happy with the change but I could be missing something... I'm also 
> happy to convert it back to a cast but container_of() feels a bit safer.  

I totally agree, it is safer and makes more sense.

> I've just tried the patch below (on top of my previous patch) to convert all 
> of the explicit casts (apart from the timer callbacks that take an unsigned 
> long) to container_of() and that works fine on my board. Is this worth 
> applying or would you rather I just keep the original cast?

Yes, it's worth applying.

So, care to send me 2 patches that I can apply with the proper changelog
comments and signed-off-by: for this?  I don't care which order you do
things in, which ever is easier for you.

thanks,

greg k-h
