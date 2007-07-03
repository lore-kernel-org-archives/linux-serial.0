From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] amiserial: Remove incorrect 'no termios change' check
Date: Tue, 3 Jul 2007 15:18:04 +0100
Message-ID: <20070703151804.6575445e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44375 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753849AbXGCOMR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 10:12:17 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Lots of serial drivers check and optimise for setting the termios values
to the ones they were before. This is pointless and the check is wrong
anyway. Remove the checks on the serial drivers. If we ever do need such
a check put it back in the tty layer instead _once_!

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/amiserial.c linux-2.6.22-rc6-mm1/drivers/char/amiserial.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/amiserial.c	2007-07-02 20:48:49.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/amiserial.c	2007-07-02 21:05:53.000000000 +0100
@@ -738,6 +738,7 @@
 	}
 	/* If the quotient is zero refuse the change */
 	if (!quot && old_termios) {
+		/* FIXME: Will need updating for new tty in the end */
 		info->tty->termios->c_cflag &= ~CBAUD;
 		info->tty->termios->c_cflag |= (old_termios->c_cflag & CBAUD);
 		baud = tty_get_baud_rate(info->tty);
@@ -783,7 +784,6 @@
 	/*
 	 * Set up parity check flag
 	 */
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
 
 	info->read_status_mask = UART_LSR_OE | UART_LSR_DR;
 	if (I_INPCK(info->tty))
@@ -1367,11 +1367,6 @@
 	unsigned long flags;
 	unsigned int cflag = tty->termios->c_cflag;
 
-	if (   (cflag == old_termios->c_cflag)
-	    && (   RELEVANT_IFLAG(tty->termios->c_iflag) 
-		== RELEVANT_IFLAG(old_termios->c_iflag)))
-	  return;
-
 	change_speed(info, old_termios);
 
 	/* Handle transition to B0 status */
