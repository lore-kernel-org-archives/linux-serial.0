From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] exynos: serial clear and set big endian fix
Date: Mon, 21 Jul 2014 16:50:32 +0100
Message-ID: <1405957832-6444-1-git-send-email-broonie@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48034 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322AbaGUPuq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jul 2014 11:50:46 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linaro-kernel@lists.linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Mark Brown <broonie@linaro.org>

From: Victor Kamensky <victor.kamensky@linaro.org>

The Samsung serial driver uses __set_bit and __clear_bit functions
directly with h/w registers but these functions do not account for any
difference between the endianess of the CPU and the hardware so if
running in big endian mode we need to byte swap.  Handle this by
wrapping these functions with open coded versions when configured for
big endian.

[Rewrote commit message -- broonie]

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/tty/serial/samsung.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 8df6c173d6ed..7191adefe40e 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -78,6 +78,41 @@ static void dbg(const char *fmt, ...)
 #define S3C24XX_SERIAL_MAJOR	204
 #define S3C24XX_SERIAL_MINOR	64
 
+#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
+static inline void __hw_set_bit(int nr, volatile unsigned long *addr)
+{
+	__set_bit(nr, addr);
+}
+
+static inline void __hw_clear_bit(int nr, volatile unsigned long *addr)
+{
+	__clear_bit(nr, addr);
+}
+#else
+static inline void __hw_set_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long val = le32_to_cpu(*p);
+
+	val  |= mask;
+
+	*p = cpu_to_le32(val);
+}
+
+static inline void __hw_clear_bit(int nr, volatile unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+
+	unsigned long val = le32_to_cpu(*p);
+
+	val &= ~mask;
+
+	*p = cpu_to_le32(val);
+}
+#endif
+
 /* macros to change one thing to another */
 
 #define tx_enabled(port) ((port)->unused[0])
@@ -157,7 +192,7 @@ static void s3c24xx_serial_stop_tx(struct uart_port *port)
 
 	if (tx_enabled(port)) {
 		if (s3c24xx_serial_has_interrupt_mask(port))
-			__set_bit(S3C64XX_UINTM_TXD,
+			__hw_set_bit(S3C64XX_UINTM_TXD,
 				portaddrl(port, S3C64XX_UINTM));
 		else
 			disable_irq_nosync(ourport->tx_irq);
@@ -176,7 +211,7 @@ static void s3c24xx_serial_start_tx(struct uart_port *port)
 			s3c24xx_serial_rx_disable(port);
 
 		if (s3c24xx_serial_has_interrupt_mask(port))
-			__clear_bit(S3C64XX_UINTM_TXD,
+			__hw_clear_bit(S3C64XX_UINTM_TXD,
 				portaddrl(port, S3C64XX_UINTM));
 		else
 			enable_irq(ourport->tx_irq);
@@ -191,7 +226,7 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 	if (rx_enabled(port)) {
 		dbg("s3c24xx_serial_stop_rx: port=%p\n", port);
 		if (s3c24xx_serial_has_interrupt_mask(port))
-			__set_bit(S3C64XX_UINTM_RXD,
+			__hw_set_bit(S3C64XX_UINTM_RXD,
 				portaddrl(port, S3C64XX_UINTM));
 		else
 			disable_irq_nosync(ourport->rx_irq);
@@ -548,7 +583,7 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	ourport->tx_claimed = 1;
 
 	/* Enable Rx Interrupt */
-	__clear_bit(S3C64XX_UINTM_RXD, portaddrl(port, S3C64XX_UINTM));
+	__hw_clear_bit(S3C64XX_UINTM_RXD, portaddrl(port, S3C64XX_UINTM));
 	dbg("s3c64xx_serial_startup ok\n");
 	return ret;
 }
-- 
2.0.1

