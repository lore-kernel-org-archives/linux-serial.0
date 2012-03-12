From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] serial: PL011: clear pending interrupts
Date: Mon, 12 Mar 2012 09:25:50 +0100
Message-ID: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:39067 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754285Ab2CLI1X (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 04:27:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, Linus Walleij <linus.walleij@linaro.org>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

From: Linus Walleij <linus.walleij@linaro.org>

Chanho Min reported that when the boot loader transfers
control to the kernel, there may be pending interrupts
causing the UART to lock up in an eternal loop trying to
pick tokens from the FIFO (since the RX interrupt flag
indicates there are tokens) while in practice there are
no tokens - in fact there is only a pending IRQ flag.

This patch address the issue with a combination of a patch
from Russell King that clears and mask all interrupts at
probe() and clears any pending error and RX interrupts at
port startup time, and a patch from Jong-Sung Kim that
clears any RX interrupts (including timeouts) even if if
there are zero tokens in the FIFO.

This way these pending interrupts should be addressed in
two ways and solidify the driver in both probe() and
IRQ paths.

Cc: stable@kernel.org
Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
Reported-by: Chanho Min <chanho0207@gmail.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
Suggested-by: Jong-Sung Kim <neidhard.kim@lge.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
OK Greg requested that we send out this combined approach, can
addressees (Chanho especially) please confirm that the patch
solves the problem? Tested on U300 and U8500.
---
 drivers/tty/serial/amba-pl011.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6800f5f..ff3fed0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -224,6 +224,11 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
 	}
 
+	/* RXIS but RXFE? Just clear the interrupt */
+	if(unlikely(fifotaken == 0))
+		writew(UART011_RTIS | UART011_RXIS,
+		       uap->port.membase + UART011_ICR);
+
 	return fifotaken;
 }
 
@@ -1381,6 +1386,10 @@ static int pl011_startup(struct uart_port *port)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
+	/* Clear pending error and receive interrupts */
+	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
+	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
+
 	/*
 	 * Allocate the IRQ
 	 */
@@ -1417,10 +1426,6 @@ static int pl011_startup(struct uart_port *port)
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
 	writew(cr, uap->port.membase + UART011_CR);
 
-	/* Clear pending error interrupts */
-	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
-	       uap->port.membase + UART011_ICR);
-
 	/*
 	 * initialise the old status of the modem signals
 	 */
@@ -1927,6 +1932,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		goto unmap;
 	}
 
+	/* Ensure interrupts from this UART are masked and cleared */
+	writew(0, uap->port.membase + UART011_IMSC);
+	writew(0xffff, uap->port.membase + UART011_ICR);
+
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
-- 
1.7.8

