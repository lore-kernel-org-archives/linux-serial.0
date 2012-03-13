From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH v3] serial: PL011: clear pending interrupts
Date: Tue, 13 Mar 2012 13:27:23 +0100
Message-ID: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:36012 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751345Ab2CMM2W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Mar 2012 08:28:22 -0400
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

This patch address the issue with a combination of two
patches suggested by Russell King that clears and mask
all interrupts at probe() and clears any pending error
and RX interrupts at port startup time.

We suspect the spurious interrupts are a side-effect of
switching the UART from FIFO to non-FIFO mode.

Cc: stable@kernel.org
Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
Cc: Jong-Sung Kim <neidhard.kim@lge.com>
Reported-by: Chanho Min <chanho0207@gmail.com>
Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Instead of making the IRQ fastpath account for spurious
  IRQs with zero characters, make sure to clear out any
  pending IRQ flags in startup().
ChangeLog v2->v3:
- Attempt to clear out any spuriously appearing RX interrups
  in startup() instead of in the interrupt handler. Let's
  see if this works.
---
 drivers/tty/serial/amba-pl011.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6800f5f..7e01399 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1381,6 +1381,10 @@ static int pl011_startup(struct uart_port *port)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
+	/* Clear pending error and receive interrupts */
+	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
+	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
+
 	/*
 	 * Allocate the IRQ
 	 */
@@ -1417,10 +1421,6 @@ static int pl011_startup(struct uart_port *port)
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
 	writew(cr, uap->port.membase + UART011_CR);
 
-	/* Clear pending error interrupts */
-	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
-	       uap->port.membase + UART011_ICR);
-
 	/*
 	 * initialise the old status of the modem signals
 	 */
@@ -1435,6 +1435,9 @@ static int pl011_startup(struct uart_port *port)
 	 * as well.
 	 */
 	spin_lock_irq(&uap->port.lock);
+	/* Clear out any spuriously appearing RX interrupts */
+	 writew(UART011_RTIS | UART011_RXIS,
+		uap->port.membase + UART011_ICR);
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
@@ -1927,6 +1930,10 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
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

