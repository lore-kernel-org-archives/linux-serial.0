From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: RM9000 code broken in 8250.c
Date: Wed, 20 Feb 2008 10:56:05 -0700
Message-ID: <1203530165.6754.11.camel@lappy>
References: <200712211250.18002.thomas@koeller.dyndns.org>
	 <200802161818.16415.thomas@koeller.dyndns.org>
	 <1203228570.7285.32.camel@bling>
	 <200802171347.03312.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:22880 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763654AbYBTR4D (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Feb 2008 12:56:03 -0500
In-Reply-To: <200802171347.03312.thomas@koeller.dyndns.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Hi Thomas,

On Sun, 2008-02-17 at 13:47 +0100, Thomas Koeller wrote:
> 
> O.K., let me try to get this straight. While a real 8250 or 16550 compatible
> UART raises a transmitter empty interrupt if this interrupt is enabled while
> the transmitter holding register is empty, there are buggy implementations
> that do not. Your test code checks for this condition, and, in a less robust
> and less elaborate way, so does the UART_BUG_TXEN test code.

   UART_BUG_TXEN does not provide the kick my UART needs to keep
running.  I just re-tested enabling it and the UART hangs repeatedly.  I
think the patch below might clarify the logic of the backup timer test
and might be a potential compromise to allow both to exist.  Please
check.

> The way to deal with this bug is to kick the transmitter by transmitting
> the first character upon start of every transmission, instead of relying on
> the interrupt handler to do this. If this is done, the RM9000 UART works
> normally, by generating transmitter empty interrupts as expected when the
> transmitter holding register becomes empty again, so it does not need any
> special treatment after the initial kick. Also, as I did not introduce
> this code, there must be (or have been) at least one more UART that behaves
> this way.

   Certainly, your UART needs a different fix, and I don't think one
precludes the other.

> Your hardware seems to be even buggier than that, because, to quote you
> "It might need a kick in the middle of a transmit, not just at the beginning".
> Is this to say that the transmitter interrupt is not working at all, or that
> it is not generated reliably, but works to some extent? I assumed the latter
> was the case, because of the phrase "might need a kick" which seemed to imply
> that this only occurs at random.

   My UART generates the first interrupt, but then fails to reassert the
interrupt again later.  Thus the kick approach.  The TXEN bug doesn't
handle this

> Yes, my hardware fails your test and therefore the backup timer is used,
> although its interrupt is working perfectly after kicking it once at the
> beginning of the transmission. I still do not see how your existing test code
> would discriminate between a hardware that behaves this way and one like
> yours that looses interrupts later on even if kicked once at the beginning,
> or has no working interrupt at all.

   The key is that I'm looking at the 2nd IIR read and expecting NO_INT.
My UART passes the TXEN bug test, so the first interrupt is generated
correctly.  Does this patch help at all?  Thanks,

	Alex

Signed-off-by: Alex Williamson <alex.williamson@hp.com>
--

diff -r 3ecfcae9a8f9 drivers/serial/8250.c
--- a/drivers/serial/8250.c	Fri Jan 25 00:00:31 2008 +0000
+++ b/drivers/serial/8250.c	Wed Feb 20 10:35:39 2008 -0700
@@ -1813,6 +1813,7 @@ static int serial8250_startup(struct uar
 	}
 
 	if (is_real_interrupt(up->port.irq)) {
+		unsigned char iir1;
 		/*
 		 * Test for UARTs that do not reassert THRE when the
 		 * transmitter is idle and the interrupt has already
@@ -1826,7 +1827,7 @@ static int serial8250_startup(struct uar
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_out_sync(up, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow THRE to set */
-		serial_in(up, UART_IIR);
+		iir1 = serial_in(up, UART_IIR);
 		serial_out(up, UART_IER, 0);
 		serial_out_sync(up, UART_IER, UART_IER_THRI);
 		udelay(1); /* allow a working UART time to re-assert THRE */
@@ -1839,7 +1840,7 @@ static int serial8250_startup(struct uar
 		 * If the interrupt is not reasserted, setup a timer to
 		 * kick the UART on a regular basis.
 		 */
-		if (iir & UART_IIR_NO_INT) {
+		if (!(iir1 & UART_IIR_NO_INT) && iir & UART_IIR_NO_INT) {
 			pr_debug("ttyS%d - using backup timer\n", port->line);
 			up->timer.function = serial8250_backup_timeout;
 			up->timer.data = (unsigned long)up;



