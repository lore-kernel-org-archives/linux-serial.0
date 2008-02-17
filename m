From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: RM9000 code broken in 8250.c
Date: Sat, 16 Feb 2008 23:09:30 -0700
Message-ID: <1203228570.7285.32.camel@bling>
References: <200712211250.18002.thomas@koeller.dyndns.org>
	 <1198246996.7091.17.camel@bling>
	 <200802161818.16415.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:6999 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbYBQGJe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Feb 2008 01:09:34 -0500
In-Reply-To: <200802161818.16415.thomas@koeller.dyndns.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Hi Thomas,

On Sat, 2008-02-16 at 18:18 +0100, Thomas Koeller wrote:
> >    Sorry this code is causing you trouble.  I tried the existing TXEN
> > bug code, it seems to be fighting a similar, but still quite different
> > bug.  The UART bug the backup timer code is trying to fix is more
> > asynchronous.  It might need a kick in the middle of a transmit, not
> > just at the beginning.
> 
> Is the test code you added really capable of detecting this kind of behavior?
> To me it does not seem to be - it looks as if it only checks whether the
> transmitter empty interrupt is raised when that interrupt is enabled
> while the transmitter holding register is empty. That is the same
> condition the UART_BUG_TXEN code checks for.

   No, it's slightly different.  Note that the test code enables the
transmit empty interrupt, reads the IIR to clear the interrupt, then
disables and re-enables the transmit empty interrupt.  At this point a
normal UART will re-assert the transmitter empty interrupt.  The UART
I'm looking for doesn't.

> > Can we re-arrange the tests such that they both 
> > work?  It would be fine with me if we don't run the test for the backup
> > timer on ports with UART_BUG_TXEN already enabled.  The easiest
> > mechanism might be to test port.type for PORT_RM9000, and not test those
> > for the backup timer.  Then we don't need to re-order the code too much.
> 
> I do not think that is an option. The UART_BUG_TXEN code has been there
> before I added support for the RM9000, so it probably has more users.

   If there are more TXEN bug users, I haven't heard complaints.  I'm
really not sure what uses the TXEN bug code, which makes it difficult to
test or modify it's behavior.  Why do you think it's not an option to
have both tests?  Is your UART testing positive for both the backup
timer and the TXEN bug?  If so, perhaps my test needs to store the first
IIR we read and make sure NO_INT is only asserted on the second read.
Maybe we could even combine the tests then.

> Looking at your description of the bug you are trying to deal with
> (interrupts cease to be generated randomly in the middle of a transmission),
> I wonder if it is at all possible to write a runtime check that reliably
> can detect it. Wouldn't a configuration option be more appropriate here?
> This would also have the added advantage of being able to leave out your
> code in cases where it is not needed, reducing bloat.

   The existing test seems to be able to reliably distinguish between
UARTs exhibiting normal transmitter interrupt behavior and those that
can effectively drop an interrupt.  Even with a configuration option, we
need a runtime test because these systems need to be supported by
standard distribution kernels and we can't interfere with fully
functional UARTs.  I'd much rather pursue an option that can allow both
workarounds.  Thanks,

	Alex

-- 
Alex Williamson                             HP Open Source & Linux Org.

