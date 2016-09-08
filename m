From: <tthayer@opensource.altera.com>
Subject: [PATCH 3/4] serial: 8250: Set Altera 16550 TX FIFO Threshold
Date: Thu, 8 Sep 2016 11:12:20 -0500
Message-ID: <1473351141-9239-4-git-send-email-tthayer@opensource.altera.com>
References: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473351141-9239-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org, mark.rutland@arm.com, lftan@altera.com, jslaby@suse.com, arnd@arndb.de, peter@hurleysoftware.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, yegorslists@googlemail.com, matwey@sai.msu.ru, mail@maciej.szmigiero.name
Cc: peter.ujfalusi@ti.com, jonathanh@nvidia.com, dongsheng.wang@nxp.com, luis@debethencourt.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, tthayer.linux@gmail.com, tthayer@opensource.altera.com, nios2-dev@lists.rocketboards.org
List-Id: linux-serial@vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

The Altera 16550 soft IP UART requires 2 additional registers for
TX FIFO threshold support. These 2 registers enable the TX FIFO
Low Watermark and set the TX FIFO Low Watermark.
These registers are initialized in serial8350_do_startup(). Set
the TX FIFO threshold to the FIFO size - tx_loadsz.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/tty/serial/8250/8250_port.c |   36 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/serial_reg.h     |    8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7481b95..35a3e2c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1880,6 +1880,30 @@ static int exar_handle_irq(struct uart_port *port)
 	return ret;
 }
 
+/*
+ * Newer 16550 compatible parts such as the SC16C650 & Altera 16550 Soft IP
+ * have a programmable TX threshold that triggers the THRE interrupt in
+ * the IIR register. In this case, the THRE interrupt indicates the FIFO
+ * has space available. Load it up with tx_loadsz bytes.
+ */
+static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
+{
+	unsigned long flags;
+	unsigned int iir = serial_port_in(port, UART_IIR);
+
+	/* TX Threshold IRQ triggered so load up FIFO */
+	if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
+		struct uart_8250_port *up = up_to_u8250p(port);
+
+		spin_lock_irqsave(&port->lock, flags);
+		serial8250_tx_chars(up);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+
+	iir = serial_port_in(port, UART_IIR);
+	return serial8250_handle_irq(port, iir);
+}
+
 static unsigned int serial8250_tx_empty(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2169,6 +2193,18 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_LCR, 0);
 	}
 
+	/*
+	 * For the Altera 16550 variants, set TX threshold trigger level.
+	 */
+	if (((port->type == PORT_ALTR_16550_F32) ||
+	     (port->type == PORT_ALTR_16550_F64) ||
+	     (port->type == PORT_ALTR_16550_F128)) && (port->fifosize > 1)) {
+		serial_port_out(port, UART_ALTR_AFR, UART_ALTR_EN_TXFIFO_LW);
+		serial_port_out(port, UART_ALTR_TX_LOW,
+				port->fifosize - up->tx_loadsz);
+		port->handle_irq = serial8250_tx_threshold_handle_irq;
+	}
+
 	if (port->irq) {
 		unsigned char iir1;
 		/*
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 1e5ac4e7..b4c0484 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -376,5 +376,13 @@
 #define UART_EXAR_TXTRG		0x0a	/* Tx FIFO trigger level write-only */
 #define UART_EXAR_RXTRG		0x0b	/* Rx FIFO trigger level write-only */
 
+/*
+ * These are definitions for the Altera ALTR_16550_F32/F64/F128
+ * Normalized from 0x100 to 0x40 because of shift by 2 (32 bit regs).
+ */
+#define UART_ALTR_AFR		0x40	/* Additional Features Register */
+#define UART_ALTR_EN_TXFIFO_LW	0x01	/* Enable the TX FIFO Low Watermark */
+#define UART_ALTR_TX_LOW	0x41	/* Tx FIFO Low Watermark */
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.7.9.5
