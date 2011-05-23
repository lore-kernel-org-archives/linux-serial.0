From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 47/48] tty/serial: Fix break handling for PORT_TEGRA
Date: Mon, 23 May 2011 12:10:53 -0700
Message-ID: <1306177854-18172-47-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47374 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756324Ab1EWTMb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:12:31 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Stephen Warren <swarren@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Stephen Warren <swarren@nvidia.com>

When a break is received, Tegra's UART apparently fills the FIFO with
0 bytes. These must be drained so that they aren't interpreted as actual
data received. This allows e.g. MAGIC_SYSRQ to work on Tegra's UARTs.

v2: Added FIXME comment to clear_rx_fifo

Originally-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c  |   28 ++++++++++++++++++++++++++++
 include/linux/serial_reg.h |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index a5e290d..b40f7b9 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1433,6 +1433,27 @@ static void serial8250_enable_ms(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+/*
+ * Clear the Tegra rx fifo after a break
+ *
+ * FIXME: This needs to become a port specific callback once we have a
+ * framework for this
+ */
+static void clear_rx_fifo(struct uart_8250_port *up)
+{
+	unsigned int status, tmout = 10000;
+	do {
+		status = serial_in(up, UART_LSR);
+		if (status & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
+			status = serial_in(up, UART_RX);
+		else
+			break;
+		if (--tmout == 0)
+			break;
+		udelay(1);
+	} while (1);
+}
+
 static void
 receive_chars(struct uart_8250_port *up, unsigned int *status)
 {
@@ -1468,6 +1489,13 @@ receive_chars(struct uart_8250_port *up, unsigned int *status)
 				lsr &= ~(UART_LSR_FE | UART_LSR_PE);
 				up->port.icount.brk++;
 				/*
+				 * If tegra port then clear the rx fifo to
+				 * accept another break/character.
+				 */
+				if (up->port.type == PORT_TEGRA)
+					clear_rx_fifo(up);
+
+				/*
 				 * We do the SysRQ and SAK checking
 				 * here because otherwise the break
 				 * may get masked by ignore_status_mask
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 5f66e84..c75bda3 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -119,6 +119,7 @@
 #define UART_MCR_DTR		0x01 /* DTR complement */
 
 #define UART_LSR	5	/* In:  Line Status Register */
+#define UART_LSR_FIFOE		0x80 /* Fifo error */
 #define UART_LSR_TEMT		0x40 /* Transmitter empty */
 #define UART_LSR_THRE		0x20 /* Transmit-hold-register empty */
 #define UART_LSR_BI		0x10 /* Break interrupt indicator */
-- 
1.7.4.2

