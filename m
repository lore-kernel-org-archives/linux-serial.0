From: Thomas Koeller <thomas@koeller.dyndns.org>
Subject: Re: RM9000 code broken in 8250.c
Date: Sat, 16 Feb 2008 18:18:16 +0100
Message-ID: <200802161818.16415.thomas@koeller.dyndns.org>
References: <200712211250.18002.thomas@koeller.dyndns.org> <1198246996.7091.17.camel@bling>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx01.hansenet.de ([213.191.73.25]:52381 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751055AbYBPXry (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 16 Feb 2008 18:47:54 -0500
In-Reply-To: <1198246996.7091.17.camel@bling>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Hi Alex,

I apologize for the long delay, I had to sort out a couple of things first,
but I am now ready to return to the issue.

>    Sorry this code is causing you trouble.  I tried the existing TXEN
> bug code, it seems to be fighting a similar, but still quite different
> bug.  The UART bug the backup timer code is trying to fix is more
> asynchronous.  It might need a kick in the middle of a transmit, not
> just at the beginning.

Is the test code you added really capable of detecting this kind of behavior?
To me it does not seem to be - it looks as if it only checks whether the
transmitter empty interrupt is raised when that interrupt is enabled
while the transmitter holding register is empty. That is the same
condition the UART_BUG_TXEN code checks for.

> Can we re-arrange the tests such that they both 
> work?  It would be fine with me if we don't run the test for the backup
> timer on ports with UART_BUG_TXEN already enabled.  The easiest
> mechanism might be to test port.type for PORT_RM9000, and not test those
> for the backup timer.  Then we don't need to re-order the code too much.

I do not think that is an option. The UART_BUG_TXEN code has been there
before I added support for the RM9000, so it probably has more users.

Looking at your description of the bug you are trying to deal with
(interrupts cease to be generated randomly in the middle of a transmission),
I wonder if it is at all possible to write a runtime check that reliably
can detect it. Wouldn't a configuration option be more appropriate here?
This would also have the added advantage of being able to leave out your
code in cases where it is not needed, reducing bloat.

thanks,
Thomas

-- 
Thomas Koeller
thomas@koeller.dyndns.org
