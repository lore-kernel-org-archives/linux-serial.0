From: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	 er
Date: Wed, 24 Jan 2007 08:48:53 -0800
Message-ID: <45B78DF5.9000203@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mother.pmc-sierra.com ([216.241.224.12]:55268 "HELO
	mother.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752015AbXAXQtA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Jan 2007 11:49:00 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

Sergei Shtylyov wrote:
> 
>  >>This I would hope you can hide in the platform specific
>  >>serial_in/serial_out functions. If you write the UART_LCR save it in
>  >>serial_out(), if you read IER etc.
> 
>  > I couldn't find hooks for platform specific serial_in/out functions.
> 
>     It's because there are none. :-)
> 
>  > Do you mean using the up->port.iotype's in serial_in/out from 8250.c?
> 
>     Not sure what Alan meant, but this seems the only option for now.

That's the conclusion I came to. I've rewritten the patch to use port.type
instead of iotype since one of the fix is SoC and not UART specific. I guess
I could use both iotype and type with a test on each for the appropriate
bug, what do you recommend?


>   >>And we might want to add a void * for board specific insanity to the 
> 8250
>  >>structures if we really have to so you can hang your brain damage
>  >>privately off that ?
> 
>  > Sounds good to me, it would give us a location to store the address 
> of the
>  > UART_STATUS_REG required by this UART variant.
> 
>     I doubt we really need to *store* it somewhere. Isn't it an fixed 
> offset
> from UART's base (I haven't seen the header)?

Unfortunately it's not a constant offset from the UART in the SoC register
space. I've used Alan suggestion and added a classic, on some other OSes %-|,
void "user" pointer.

I'll repost as soon I complete testing and try the new timer patch.

Marc
