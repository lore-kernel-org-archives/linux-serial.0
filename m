From: Matthew Leach <matthew@mattleach.net>
Subject: [PATCH v2 3/3] tty: serial: samsung: add byte-order aware bit functions
Date: Wed, 22 Jun 2016 17:57:03 +0100
Message-ID: <20160622165703.7775-4-matthew@mattleach.net>
References: <20160622165703.7775-1-matthew@mattleach.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160622165703.7775-1-matthew@mattleach.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew Leach <matthew@mattleach.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This driver makes use of the __set_bit() and __clear_bit() functions.
When running under big-endian, these functions don't convert the bit
indexes when working with peripheral registers, leading to the
incorrect bits being set and cleared when running big-endian.

Add two new driver functions for setting and clearing bits that are
byte-order aware.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/samsung.c | 16 +++++++---------
 drivers/tty/serial/samsung.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 99bb231..e4f53d5 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -169,8 +169,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 		return;
 
 	if (s3c24xx_serial_has_interrupt_mask(port))
-		__set_bit(S3C64XX_UINTM_TXD,
-			portaddrl(port, S3C64XX_UINTM));
+		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
 	else
 		disable_irq_nosync(ourport->tx_irq);
 
@@ -235,8 +234,7 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
 
 	/* Mask Tx interrupt */
 	if (s3c24xx_serial_has_interrupt_mask(port))
-		__set_bit(S3C64XX_UINTM_TXD,
-			  portaddrl(port, S3C64XX_UINTM));
+		s3c24xx_set_bit(port, S3C64XX_UINTM_TXD, S3C64XX_UINTM);
 	else
 		disable_irq_nosync(ourport->tx_irq);
 
@@ -269,8 +267,8 @@ static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
 
 	/* Unmask Tx interrupt */
 	if (s3c24xx_serial_has_interrupt_mask(port))
-		__clear_bit(S3C64XX_UINTM_TXD,
-			    portaddrl(port, S3C64XX_UINTM));
+		s3c24xx_clear_bit(port, S3C64XX_UINTM_TXD,
+				  S3C64XX_UINTM);
 	else
 		enable_irq(ourport->tx_irq);
 
@@ -397,8 +395,8 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 	if (rx_enabled(port)) {
 		dbg("s3c24xx_serial_stop_rx: port=%p\n", port);
 		if (s3c24xx_serial_has_interrupt_mask(port))
-			__set_bit(S3C64XX_UINTM_RXD,
-				portaddrl(port, S3C64XX_UINTM));
+			s3c24xx_set_bit(port, S3C64XX_UINTM_RXD,
+					S3C64XX_UINTM);
 		else
 			disable_irq_nosync(ourport->rx_irq);
 		rx_enabled(port) = 0;
@@ -1069,7 +1067,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	/* Enable Rx Interrupt */
-	__clear_bit(S3C64XX_UINTM_RXD, portaddrl(port, S3C64XX_UINTM));
+	s3c24xx_clear_bit(port, S3C64XX_UINTM_RXD, S3C64XX_UINTM);
 
 	dbg("s3c64xx_serial_startup ok\n");
 	return ret;
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 8f96b71..2ae4fce 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -123,4 +123,32 @@ struct s3c24xx_uart_port {
 #define wr_regb(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
 #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
 
+/* Byte-order aware bit setting/clearing functions. */
+
+static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
+				   unsigned int reg)
+{
+	unsigned long flags;
+	u32 val;
+
+	local_irq_save(flags);
+	val = rd_regl(port, reg);
+	val |= (1 << idx);
+	wr_regl(port, reg, val);
+	local_irq_restore(flags);
+}
+
+static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
+				     unsigned int reg)
+{
+	unsigned long flags;
+	u32 val;
+
+	local_irq_save(flags);
+	val = rd_regl(port, reg);
+	val &= ~(1 << idx);
+	wr_regl(port, reg, val);
+	local_irq_restore(flags);
+}
+
 #endif
-- 
2.8.3
