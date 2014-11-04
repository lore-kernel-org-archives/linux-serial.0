From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] tty: cadence:: Add support for setting modem control signals
Date: Tue,  4 Nov 2014 11:49:54 +0100
Message-ID: <1415098194-18992-1-git-send-email-lars@metafoo.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out-061.synserver.de ([212.40.185.61]:1122 "EHLO
	smtp-out-058.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751364AbaKDK4g (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2014 05:56:36 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Add support for setting the state of the DTR and RTS signals.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/tty/serial/xilinx_uartps.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 200c1af..fb1de12 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -133,6 +133,15 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 #define CDNS_UART_IXR_BRK	0x80000000
 
 /*
+ * Modem Control register:
+ * The read/write Modem Control register controls the interface with the modem
+ * or data set, or a peripheral device emulating a modem.
+ */
+#define CDNS_UART_MODEMCR_FCM	0x00000020 /* Automatic flow control mode */
+#define CDNS_UART_MODEMCR_RTS	0x00000002 /* Request to send output control */
+#define CDNS_UART_MODEMCR_DTR	0x00000001 /* Data Terminal Ready */
+
+/*
  * Channel Status Register:
  * The channel status register (CSR) is provided to enable the control logic
  * to monitor the status of bits in the channel interrupt status register,
@@ -915,7 +924,18 @@ static unsigned int cdns_uart_get_mctrl(struct uart_port *port)
 
 static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* N/A */
+	unsigned int val;
+
+	val = cdns_uart_readl(CDNS_UART_MODEMCR_OFFSET);
+
+	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
+
+	if (mctrl & TIOCM_RTS)
+		val |= CDNS_UART_MODEMCR_RTS;
+	if (mctrl & TIOCM_DTR)
+		val |= CDNS_UART_MODEMCR_DTR;
+
+	cdns_uart_writel(val, CDNS_UART_MODEMCR_OFFSET);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-- 
1.8.0

