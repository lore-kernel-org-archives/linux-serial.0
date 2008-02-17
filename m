From: Thomas Koeller <thomas@koeller.dyndns.org>
Subject: Re: RM9000 code broken in 8250.c
Date: Sun, 17 Feb 2008 13:47:03 +0100
Message-ID: <200802171347.03312.thomas@koeller.dyndns.org>
References: <200712211250.18002.thomas@koeller.dyndns.org> <200802161818.16415.thomas@koeller.dyndns.org> <1203228570.7285.32.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx01.hansenet.de ([213.191.73.25]:55196 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755297AbYBQMqN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 17 Feb 2008 07:46:13 -0500
In-Reply-To: <1203228570.7285.32.camel@bling>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

On Sonntag, 17. Februar 2008, Alex Williamson wrote:
> On Sat, 2008-02-16 at 18:18 +0100, Thomas Koeller wrote:
> > >    Sorry this code is causing you trouble.  I tried the existing TXEN
> > > bug code, it seems to be fighting a similar, but still quite different
> > > bug.  The UART bug the backup timer code is trying to fix is more
> > > asynchronous.  It might need a kick in the middle of a transmit, not
> > > just at the beginning.
> >
> > Is the test code you added really capable of detecting this kind of
> > behavior? To me it does not seem to be - it looks as if it only checks
> > whether the transmitter empty interrupt is raised when that interrupt is
> > enabled while the transmitter holding register is empty. That is the same
> > condition the UART_BUG_TXEN code checks for.
>
>    No, it's slightly different.  Note that the test code enables the
> transmit empty interrupt, reads the IIR to clear the interrupt, then
> disables and re-enables the transmit empty interrupt.  At this point a
> normal UART will re-assert the transmitter empty interrupt.  The UART
> I'm looking for doesn't.

O.K., let me try to get this straight. While a real 8250 or 16550 compatible
UART raises a transmitter empty interrupt if this interrupt is enabled while
the transmitter holding register is empty, there are buggy implementations
that do not. Your test code checks for this condition, and, in a less robust
and less elaborate way, so does the UART_BUG_TXEN test code.

The way to deal with this bug is to kick the transmitter by transmitting
the first character upon start of every transmission, instead of relying on
the interrupt handler to do this. If this is done, the RM9000 UART works
normally, by generating transmitter empty interrupts as expected when the
transmitter holding register becomes empty again, so it does not need any
special treatment after the initial kick. Also, as I did not introduce
this code, there must be (or have been) at least one more UART that behaves
this way.

Your hardware seems to be even buggier than that, because, to quote you
"It might need a kick in the middle of a transmit, not just at the beginning".
Is this to say that the transmitter interrupt is not working at all, or that
it is not generated reliably, but works to some extent? I assumed the latter
was the case, because of the phrase "might need a kick" which seemed to imply
that this only occurs at random.

>
> > > Can we re-arrange the tests such that they both
> > > work?  It would be fine with me if we don't run the test for the backup
> > > timer on ports with UART_BUG_TXEN already enabled.  The easiest
> > > mechanism might be to test port.type for PORT_RM9000, and not test
> > > those for the backup timer.  Then we don't need to re-order the code
> > > too much.
> >
> > I do not think that is an option. The UART_BUG_TXEN code has been there
> > before I added support for the RM9000, so it probably has more users.
>
>    If there are more TXEN bug users, I haven't heard complaints.  I'm
> really not sure what uses the TXEN bug code, which makes it difficult to
> test or modify it's behavior.  Why do you think it's not an option to
> have both tests?  Is your UART testing positive for both the backup
> timer and the TXEN bug?  If so, perhaps my test needs to store the first
> IIR we read and make sure NO_INT is only asserted on the second read.
> Maybe we could even combine the tests then.

Yes, my hardware fails your test and therefore the backup timer is used,
although its interrupt is working perfectly after kicking it once at the
beginning of the transmission. I still do not see how your existing test code
would discriminate between a hardware that behaves this way and one like
yours that looses interrupts later on even if kicked once at the beginning,
or has no working interrupt at all.

thanks,
Thomas


-- 
Thomas Koeller
thomas@koeller.dyndns.org
