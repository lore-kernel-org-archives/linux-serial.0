From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: RM9000 code broken in 8250.c
Date: Fri, 21 Dec 2007 07:23:16 -0700
Message-ID: <1198246996.7091.17.camel@bling>
References: <200712211250.18002.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:5597 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbXLUOXT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Dec 2007 09:23:19 -0500
In-Reply-To: <200712211250.18002.thomas@koeller.dyndns.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Hi Thomas,

   Sorry this code is causing you trouble.  I tried the existing TXEN
bug code, it seems to be fighting a similar, but still quite different
bug.  The UART bug the backup timer code is trying to fix is more
asynchronous.  It might need a kick in the middle of a transmit, not
just at the beginning.  Can we re-arrange the tests such that they both
work?  It would be fine with me if we don't run the test for the backup
timer on ports with UART_BUG_TXEN already enabled.  The easiest
mechanism might be to test port.type for PORT_RM9000, and not test those
for the backup timer.  Then we don't need to re-order the code too much.
Thanks,

  Alex

On Fri, 2007-12-21 at 12:50 +0100, Thomas Koeller wrote:
> Hi,
> 
> while investigating breakage of the RM9000 code in
> drivers/serial/8250.c, I found that my problems are
> caused by commit 40b36daad0ac704e6d5c1b75789f371ef5b053c1.
> My device has the characteristic of not generating a
> 'transmitter empty' interrupt immediately if interrupts
> are enabled while the transmitter is empty, it needs to
> be kicked by transmitting a character first. Before
> commit 40b36daad0ac704e6d5c1b75789f371ef5b053c1 this was
> taken care of by code in serial8250_startup() that probed
> the hardware for this bug an set the UART_BUG_TXEN flag,
> which then modified the behavior of serial8250_start_tx()
> to take the bug into account. This used to work well for
> my device.
> 
> The commit introduced another check for the same condition
> which is done earlier in serial8250_startup(), and causes
> the driver to use a periodic timer instead of the hardware
> interrupt. Now my device uses that timer, while it was
> perfectly capable of using the serial port transmit
> interrupt before.
> 
> I wonder why a new workaround has been introduced for a
> problem for which there had already been a (far superior)
> solution. Didn't this existing solution solve the problem
> for the hardware in question? If so, wouldn't it have been
> possible to modify the existing solution instead of adding
> another one that conflicts with existing code that depends
> on the old code?
> 
> regards,
> Thomas
-- 
Alex Williamson                             HP Open Source & Linux Org.

