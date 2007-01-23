From: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date: Tue, 23 Jan 2007 14:37:23 -0800
Message-ID: <45B68E23.7080800@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from father.pmc-sierra.com ([216.241.224.13]:36261 "HELO
	father.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965500AbXAWWhe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Jan 2007 17:37:34 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mips@linux-mips.org


Alan wrote:
>  > There are three different fixes:
>  > 1. Fix for THRE errata
> 
> That should be handled anyway. The current code actually spots this and
> uses a backup timer for dodgy UARTS

Thanks, I'll retest without this fix on the current l-m.o git master and see
if it still solves our errata.

>  > 2. Fix for Busy Detect on LCR write
>  > 3. Workaround for interrupt/data concurrency issue
> 
>  >       case UPIO_MEM:
>  > +#ifdef CONFIG_PMC_MSP
>  > +             /* Save the LCR value so it can be re-written when a
>  > +              * Busy Detect interrupt occurs. */
>  > +             if (dwapb_offset == UART_LCR)
>  > +                     up->dwapb_lcr = value;
>  > +#endif
>  >               writeb(value, up->port.membase + offset);
>  > +#ifdef CONFIG_PMC_MSP
>  > +             /* Re-read the IER to ensure any interrupt disabling has
>  > +              * completed before proceeding with ISR. */
>  > +             if (dwapb_offset == UART_IER)
>  > +                     value = serial_in(up, dwapb_offset);
>  > +#endif
>  >               break;
> 
> This I would hope you can hide in the platform specific
> serial_in/serial_out functions. If you write the UART_LCR save it in
> serial_out(), if you read IER etc.

I couldn't find hooks for platform specific serial_in/out functions.
Do you mean using the up->port.iotype's in serial_in/out from 8250.c?

> 
>  > +#ifdef CONFIG_PMC_MSP
>  > +             } else if ((iir & UART_IER_BUSY) == UART_IER_BUSY) {
>  > +                     /*
>  > +                      * The MSP (DesignWare APB UART) serial 
> subsystem has a
>  > +                      * non-standard interrupt condition (0x7) which 
> means
>  > +                      * that the LCR was written while the UART was 
> busy, so
>  > +                      * the LCR was not actually written.  It is 
> cleared by
>  > +                      * reading the special non-standard extended 
> UART status
>  > +                      * register.
> 
> Ditto... spot this case and whack it in your serial methods.

A serial_in(up, UART_IIR) calls occur in more places that just the interrupt
handler (i.e. autoconfig*, serial8250_start_tx, etc). We will need to check
if we are in an interrupt on each IIR read, hopefully that won't be too much
overhead!

> 
> And we might want to add a void * for board specific insanity to the 8250
> structures if we really have to so you can hang your brain damage
> privately off that ?

Sounds good to me, it would give us a location to store the address of the
UART_STATUS_REG required by this UART variant.

Marc
