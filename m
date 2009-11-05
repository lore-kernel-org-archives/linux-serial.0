From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 6/6] SERIAL: BCM63xx: Fix serial driver compile breakage.
Date: Thu, 05 Nov 2009 16:26:04 +0100
Message-ID: <20091105152702.606651698@linux-mips.org>
References: <20091105152555.227009519@linux-mips.org>
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline; filename=0009.patch
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maxime Bizon <mbizon@freebox.fr>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Maxime Bizon <mbizon@freebox.fr>

The driver missed an API change.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/serial/bcm63xx_uart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: upstream-linus/drivers/serial/bcm63xx_uart.c
===================================================================
--- upstream-linus.orig/drivers/serial/bcm63xx_uart.c
+++ upstream-linus/drivers/serial/bcm63xx_uart.c
@@ -242,7 +242,7 @@ static void bcm_uart_do_rx(struct uart_p
 	 * higher than fifo size anyway since we're much faster than
 	 * serial port */
 	max_count = 32;
-	tty = port->info->port.tty;
+	tty = port->state->port.tty;
 	do {
 		unsigned int iestat, c, cstat;
 		char flag;
@@ -318,7 +318,7 @@ static void bcm_uart_do_tx(struct uart_p
 		return;
 	}
 
-	xmit = &port->info->xmit;
+	xmit = &port->state->xmit;
 	if (uart_circ_empty(xmit))
 		goto txq_empty;
 
