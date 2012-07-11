From: Raphael Assenat <raph@8d.com>
Subject: [PATCH RFC] Remove minimum FIFO size check for enabling AFE
Date: Wed, 11 Jul 2012 16:02:00 -0400
Message-ID: <20120711200200.GD4260@8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:42277 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932448Ab2GKUCE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 11 Jul 2012 16:02:04 -0400
Received: from raph.usine.8d.com ([192.168.142.55] helo=renkinjitsu.usine.8d.com)
	by roc.holo.8d.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <raph@8d.com>)
	id 1Sp36m-00077Y-UH
	for linux-serial@vger.kernel.org; Wed, 11 Jul 2012 16:02:03 -0400
Received: from raph by renkinjitsu.usine.8d.com with local (Exim 4.72)
	(envelope-from <raph@8d.com>)
	id 1Sp36m-0001JE-Oc
	for linux-serial@vger.kernel.org; Wed, 11 Jul 2012 16:02:00 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

    When CRTSCTS is requested and the hardware supports AFE, I don't
    understand why having a FIFO of less than 32 bytes is a reason not
    to enable it.
    
    The logic currently in place prevents AFE from being enabled when
    we use a SC16C550 UART due to its 16 byte FIFO.
    
    The original comment is not wrong. Indeed, if the remote uart is not
    using automatic flow control, it will probably send extra bytes
    even after RTS is deasserted.
    
    But requiring a local UART FIFO of at least 32 bytes does not make
    sense to me because:
    
    1) If AFE is not enabled (due to a small FIFO of 16 bytes, as in my case),
    what mechanism will save us from receive overrun? None, and we loose data
    if the UART FIFO fills up.
    
    2) If AFE is enabled AND the remote latency is such that it stops
    sending data only after several bytes, filling the FIFO, we still loose
    data. But at least we /tried/ to stop the remote UART. By doing so,
    if the remote UART had been using auto flow control (or would have reacted
    fast enough anyway), then the flow would have been properly interrupted and
    no data would have been lost. Isn't this better?
    
    3) In the worst case of remote software latency, we can imagine the remote
    UART emptying its whole FIFO before stopping. If this FIFO is 64 bytes,
    the 32 bytes minimum wouldn't be enough anyway. The real problem here 
    would be the remote device which really should honor flow control signals 
    with a more acceptable latency.
    
    Given all the above, I would suggest simply removing the FIFO size check
    with the following patch. I don't think anything should break because of
    this, but as I could not find when this fifo size check was added, I could
    not read about the reasons why it is there...
    
    If this patch is not acceptable, alternatives that would still solve my
    problem include reducing the minimum FIFO size to 16 or adding a check
    for this specific UART at the same place.

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index ffea4f3..e09b393 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -2252,14 +2252,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	/*
-	 * MCR-based auto flow control.  When AFE is enabled, RTS will be
-	 * deasserted when the receive FIFO contains more characters than
-	 * the trigger, or the MCR RTS bit is cleared.  In the case where
-	 * the remote UART is not using CTS auto flow control, we must
-	 * have sufficient FIFO entries for the latency of the remote
-	 * UART to respond.  IOW, at least 32 bytes of FIFO.
+	 * MCR-based auto flow control. 
 	 */
-	if (up->capabilities & UART_CAP_AFE && port->fifosize >= 32) {
+	if (up->capabilities & UART_CAP_AFE) {
 		up->mcr &= ~UART_MCR_AFE;
 		if (termios->c_cflag & CRTSCTS)
 			up->mcr |= UART_MCR_AFE;
