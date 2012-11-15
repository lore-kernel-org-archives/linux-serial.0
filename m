From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] serial/8250: Add support for Exar's XR17V35x family
 of multi-port PCIe UARTs
Date: Thu, 15 Nov 2012 22:08:09 +0000
Message-ID: <20121115220809.21ca5fc4@pyramind.ukuu.org.uk>
References: <CAJp1Oe7tdGRzBAfXq67kzehgfUnw2FeeJRUEiX7RGya4NWkw7g@mail.gmail.com>
	<20121114230036.2504063c@pyramind.ukuu.org.uk>
	<CAJp1Oe71SsuWR4qxNhuEJouj2jddYPYUOdQMSAsZ6nLR-MZRpw@mail.gmail.com>
	<CAJp1Oe7qXCsy_r6aFgWtv6aWNjWEvoYhJ_j7-jLmccvQrPpi7A@mail.gmail.com>
	<20121115204613.566da859@pyramind.ukuu.org.uk>
	<CAJp1Oe6jSNxJu-MKeAFzObDwkPUPK9K5GitbsStKQib6big9pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54953 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab2KOWDB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 17:03:01 -0500
In-Reply-To: <CAJp1Oe6jSNxJu-MKeAFzObDwkPUPK9K5GitbsStKQib6big9pQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>

On Thu, 15 Nov 2012 15:37:37 -0600
Matt Schulte <matts@commtech-fastcom.com> wrote:

> On Thu, Nov 15, 2012 at 2:46 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Thu, 15 Nov 2012 10:14:59 -0600
> > Matt Schulte <matts@commtech-fastcom.com> wrote:
> >
> >> On Wed, Nov 14, 2012 at 5:05 PM, Matt Schulte
> >> <matts@commtech-fastcom.com> wrote:
> >> > On Wed, Nov 14, 2012 at 5:00 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> >>> +     /* Fixme: needs tidying up */
> >> >>> +     check = serial_in(up, UART_EXAR_DVID);
> >> >>> +     if ((check == 0x82) || (check == 0x84) || (check == 0x88))
> >> >>> +             p->handle_irq = exar_handle_irq;
> >> >>
> >> >> Can't you check the port type here rather than re-probing stuff ?
> >> >>
> >> >>
> >> >> Otherwise looks good
> >> >
> >> > I tried that but in my tests port.type == 0 at this point.
> >> >
> >>
> >> _Should_ the port.type have the correct value inside of set_io_from_upio?
> >
> > Yes - except possibly if autoconfig changes the port type.
> >
> > It may in fact be sufficient to set it in serial8250_config_port after
> > autoconfig has run. There are far too many different init paths in this
> > code 8(
> 
> Turns out you were right, it seems to work out if I put it in here:
> 
> @@ -2684,10 +2679,14 @@ static void serial8250_config_port(struct
> uart_port *port, int flags)
> 
>  	if (port->type != PORT_RSA && probeflags & PROBE_RSA)
>  		serial8250_release_rsa_resource(up);
>  	if (port->type == PORT_UNKNOWN)
>  		serial8250_release_std_resource(up);
> +
> +	/* Fixme: might not be the best place for this */
> +	if (port->type == PORT_XR17V35X)
> +		port->handle_irq = exar_handle_irq;
>  }
> 
> This look better?

Yep

Alan
