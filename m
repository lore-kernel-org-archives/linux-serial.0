From: Johan Hovold <jhovold@gmail.com>
Subject: Re: USB to Serial converter code pl2303
Date: Wed, 19 Feb 2014 18:00:39 +0100
Message-ID: <20140219170039.GG24335@localhost>
References: <1392688665.7323.32.camel@mange>
 <20140218090946.GA1954@localhost>
 <1392828260.3113.24.camel@mange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51093 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbaBSRBJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 12:01:09 -0500
Content-Disposition: inline
In-Reply-To: <1392828260.3113.24.camel@mange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Magnus <magnus-swe@telia.com>
Cc: Johan Hovold <jhovold@gmail.com>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Feb 19, 2014 at 05:44:20PM +0100, Magnus wrote:
> >[ Please make sure to CC the linux-usb list as well. ]
> Sure Johan.

[ And please try to avoid top-posting... ]

> The brand of this USB-Serial converter is sold by or as
> "Plexgear" or "Marquant".
> 
> Absolutely no info on the adapter is provided in the package
> other then a mini-cd saying its a "prolific" product.
> 
> I tried to send initialization code "117" followed by
> servo movement codes to it via gtkterm.
> The only time the adapter responded was at 115200 Baud.
> 
> I need an adapter that can handle 2400 Baud to talk to the
> ft639/ede639 servo controller chip or possibly a pl2303 driver
> that is improved.

The pl2303-driver can handle 2400 baud, but not sure exactly what baud
rates are available for a cloned/pirated pl2303 chip (if that is what
you've got). 115200 baud should be supported, though.

> I have looked at vscom, a very similar
> looking adapter on all counts except shape.
> This adapter uses a linux driver called "ftdi_sio"
> from info i have read on the net.

That driver also works at 2400 baud.

> What im really looking for here is an usb to serial
> adapter that works for 2400 Baud and not only 115200.
> I guess ill have to buy a new one from somewhere, but im
> missing the what and the where :)

I only suggested using 115200 baud as a way to verify your setup. Once
you do that you can try 2400.

Good luck,
Johan
