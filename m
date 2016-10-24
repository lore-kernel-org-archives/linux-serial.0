From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/4] serial: 8250_uniphier: hardcode regshift to avoid unneeded memory read
Date: Mon, 24 Oct 2016 17:00:29 +0900
Message-ID: <1477296030-7517-4-git-send-email-yamada.masahiro@socionext.com>
References: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For this driver, uart_port::regshift is always 2.  Hardcode the
shift value instead of reading ->regshift to get an already known
value.  (pointed out by Denys Vlasenko)

Furthermore, I am using register macros that are already shifted,
which will save code a bit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/tty/serial/8250/8250_uniphier.c | 42 +++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 417d9e7..92e7bb7 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -24,10 +24,22 @@
 /* Most (but not all) of UniPhier UART devices have 64-depth FIFO. */
 #define UNIPHIER_UART_DEFAULT_FIFO_SIZE	64
 
-#define UNIPHIER_UART_CHAR_FCR	3	/* Character / FIFO Control Register */
-#define UNIPHIER_UART_LCR_MCR	4	/* Line/Modem Control Register */
-#define   UNIPHIER_UART_LCR_SHIFT	8
-#define UNIPHIER_UART_DLR	9	/* Divisor Latch Register */
+/*
+ * This hardware is similar to 8250, but its register map is a bit different:
+ *   - MMIO32 (regshift = 2)
+ *   - FCR is not at 2, but 3
+ *   - LCR and MCR are not at 3 and 4, they share 4
+ *   - Divisor latch at 9, no divisor latch access bit
+ */
+
+#define UNIPHIER_UART_REGSHIFT		2
+
+/* bit[15:8] = CHAR (not used), bit[7:0] = FCR */
+#define UNIPHIER_UART_CHAR_FCR		(3 << (UNIPHIER_UART_REGSHIFT))
+/* bit[15:8] = LCR, bit[7:0] = MCR */
+#define UNIPHIER_UART_LCR_MCR		(4 << (UNIPHIER_UART_REGSHIFT))
+/* Divisor Latch Register */
+#define UNIPHIER_UART_DLR		(9 << (UNIPHIER_UART_REGSHIFT))
 
 struct uniphier8250_priv {
 	int line;
@@ -44,7 +56,7 @@ static int __init uniphier_early_console_setup(struct earlycon_device *device,
 
 	/* This hardware always expects MMIO32 register interface. */
 	device->port.iotype = UPIO_MEM32;
-	device->port.regshift = 2;
+	device->port.regshift = UNIPHIER_UART_REGSHIFT;
 
 	/*
 	 * Do not touch the divisor register in early_serial8250_setup();
@@ -68,17 +80,16 @@ static unsigned int uniphier_serial_in(struct uart_port *p, int offset)
 
 	switch (offset) {
 	case UART_LCR:
-		valshift = UNIPHIER_UART_LCR_SHIFT;
+		valshift = 8;
 		/* fall through */
 	case UART_MCR:
 		offset = UNIPHIER_UART_LCR_MCR;
 		break;
 	default:
+		offset <<= UNIPHIER_UART_REGSHIFT;
 		break;
 	}
 
-	offset <<= p->regshift;
-
 	/*
 	 * The return value must be masked with 0xff because LCR and MCR reside
 	 * in the same register that must be accessed by 32-bit write/read.
@@ -97,7 +108,7 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 		offset = UNIPHIER_UART_CHAR_FCR;
 		break;
 	case UART_LCR:
-		valshift = UNIPHIER_UART_LCR_SHIFT;
+		valshift = 8;
 		/* Divisor latch access bit does not exist. */
 		value &= ~UART_LCR_DLAB;
 		/* fall through */
@@ -106,11 +117,10 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
 		break;
 	default:
 		normal = true;
+		offset <<= UNIPHIER_UART_REGSHIFT;
 		break;
 	}
 
-	offset <<= p->regshift;
-
 	if (normal) {
 		writel(value, p->membase + offset);
 	} else {
@@ -139,16 +149,12 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
  */
 static int uniphier_serial_dl_read(struct uart_8250_port *up)
 {
-	int offset = UNIPHIER_UART_DLR << up->port.regshift;
-
-	return readl(up->port.membase + offset);
+	return readl(up->port.membase + UNIPHIER_UART_DLR);
 }
 
 static void uniphier_serial_dl_write(struct uart_8250_port *up, int value)
 {
-	int offset = UNIPHIER_UART_DLR << up->port.regshift;
-
-	writel(value, up->port.membase + offset);
+	writel(value, up->port.membase + UNIPHIER_UART_DLR);
 }
 
 static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
@@ -234,7 +240,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	up.port.type = PORT_16550A;
 	up.port.iotype = UPIO_MEM32;
-	up.port.regshift = 2;
+	up.port.regshift = UNIPHIER_UART_REGSHIFT;
 	up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	up.capabilities = UART_CAP_FIFO;
 
-- 
1.9.1
