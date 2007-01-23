From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
 er
Date: Tue, 23 Jan 2007 23:41:53 +0000
Message-ID: <20070123234153.66fbeac6@localhost.localdomain>
References: <45B68E23.7080800@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51333 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965594AbXAWXck (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Jan 2007 18:32:40 -0500
In-Reply-To: <45B68E23.7080800@pmc-sierra.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Tue, 23 Jan 2007 14:37:23 -0800
Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:
> > This I would hope you can hide in the platform specific
> > serial_in/serial_out functions. If you write the UART_LCR save it in
> > serial_out(), if you read IER etc.
> 
> I couldn't find hooks for platform specific serial_in/out functions.
> Do you mean using the up->port.iotype's in serial_in/out from 8250.c?

If you can have other uarts as well then yes. Basically I want all the
ugliness to belong to you not to the 8250 driver (and ditto for any other
half baked uart or demented piece of broken glue logic). If we don't do
that then 8250.c will end up unmanagable. So long as you crap in your own
pond everyone else is fine ;)

> A serial_in(up, UART_IIR) calls occur in more places that just the interrupt
> handler (i.e. autoconfig*, serial8250_start_tx, etc). We will need to check
> if we are in an interrupt on each IIR read, hopefully that won't be too much
> overhead!

Or if need be we make that hint generally available as we can do that bit
cleanly.

> > 
> > And we might want to add a void * for board specific insanity to the 8250
> > structures if we really have to so you can hang your brain damage
> > privately off that ?
> 
> Sounds good to me, it would give us a location to store the address of the
> UART_STATUS_REG required by this UART variant.

and for anything harder people can hang a struct off it.

Alan
