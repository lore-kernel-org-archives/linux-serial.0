From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: RM9000 code broken in 8250.c
Date: Tue, 26 Feb 2008 08:37:22 -0700
Message-ID: <1204040242.24352.32.camel@bling>
References: <200712211250.18002.thomas@koeller.dyndns.org>
	 <200802171347.03312.thomas@koeller.dyndns.org>
	 <1203530165.6754.11.camel@lappy>
	 <200802260159.09182.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:12968 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759197AbYBZPhZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2008 10:37:25 -0500
In-Reply-To: <200802260159.09182.thomas@koeller.dyndns.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>


On Tue, 2008-02-26 at 01:59 +0100, Thomas Koeller wrote:
> On Mittwoch, 20. Februar 2008, Alex Williamson wrote:
> >
> >    The key is that I'm looking at the 2nd IIR read and expecting NO_INT.
> > My UART passes the TXEN bug test, so the first interrupt is generated
> > correctly.  Does this patch help at all?
> 
> The patch seems to be good. After applying it, my UART passes the
> modified test. I never tried enabling the interrupt twice, as your
> modified test does, and was not aware that in this case my hardware
> would raise an interrupt. How did you know? Can we be sure that possible
> other UARTS affected by UART_BUG_TXEN will also do this?

Hi Thomas,

   What I expect to happen is that your UART will not raise the transmit
empty interrupt either time (but most importantly the first time).  My
UART does interrupt on the first, but not the second.  Thus the failure
to *reassert* the interrupt as described in the comment.  Are you sure
your hardware is raising the interrupt?  I'm hoping that it doesn't, and
will fall out of my test and get caught by the original TXEN test.

   I placed the backup timer test before the TXEN bug test to make sure
I get a clean shot at the interrupts.  I was assuming that TXEN bug
UARTs never assert the transmitter empty interrupt, but I either forgot
to add the check that this patch does, or was hoping the backup timer
would keep them running too.  We could consider consolidating the tests,
as they're very similar, but frankly, I'm afraid to mess with the TXEN
test without having at least a couple UARTs with the issue to test.

   If your UART is detected correctly now and you don't have any
suggestions for further improvements, I'll go ahead and submit this.
Let me know.  Thanks,

	Alex

-- 
Alex Williamson                             HP Open Source & Linux Org.

