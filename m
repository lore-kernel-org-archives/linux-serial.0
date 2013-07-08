From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] serial: fsl_lpuart: restore UARTCR2 after watermark setup is done
Date: Mon, 8 Jul 2013 15:53:38 +0800
Message-ID: <1373270018-3705-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:51706
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118Ab3GHHwy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Jul 2013 03:52:54 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jingchang Lu <b35083@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

Function lpuart_setup_watermark() clears some bits in register UARTCR2
before writing FIFO configuration registers as required by hardware.
But it should restore UARTCR2 after that.  Otherwise, we end up changing
UARTCR2 register when setting up watermark, and that is not really
desirable.  At least, when low-level debug and earlyprint is enabled,
serial console is broken due to it.

Fix the problem by restoring UARTCR2 register at the end of function
lpuart_setup_watermark().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/fsl_lpuart.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 263cfaa..7bc17f2 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -342,8 +342,10 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
 	unsigned char val, cr2;
+	unsigned char cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
+	cr2_saved = cr2;
 	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_TE |
 			UARTCR2_RIE | UARTCR2_RE);
 	writeb(cr2, sport->port.membase + UARTCR2);
@@ -366,6 +368,9 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 
 	writeb(2, sport->port.membase + UARTTWFIFO);
 	writeb(1, sport->port.membase + UARTRWFIFO);
+
+	/* Restore cr2 */
+	writeb(cr2_saved, sport->port.membase + UARTCR2);
 }
 
 static int lpuart_startup(struct uart_port *port)
-- 
1.7.9.5


