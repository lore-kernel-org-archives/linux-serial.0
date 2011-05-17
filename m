From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] tty/serial: Fix break handling for PORT_TEGRA
Date: Tue, 17 May 2011 16:12:37 -0600
Message-ID: <1305670357-4291-2-git-send-email-swarren@nvidia.com>
References: <1305670357-4291-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1305670357-4291-1-git-send-email-swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-l3A5Bk7waGM@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

When a break is received, Tegra's UART apparently fills the FIFO with
0 bytes. These must be drained so that they aren't interpreted as actual
data received. This allows e.g. MAGIC_SYSRQ to work on Tegra's UARTs.

v2: Added FIXME comment to clear_rx_fifo

Originally-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
1.7.0.4
