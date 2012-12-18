From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] SERIAL: Remove RM9000 series serial driver.
Date: Tue, 18 Dec 2012 11:41:14 +0100
Message-ID: <20121218104114.GA28910@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:55607 "EHLO
	eddie.linux-mips.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753863Ab2LRKlY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Dec 2012 05:41:24 -0500
Received: from localhost.localdomain ([127.0.0.1]:37558 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823038Ab2LRKlWo3-NR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Dec 2012 11:41:22 +0100
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc: linux-mips@linux-mips.org

Now that support for RM9000 and platforms based on it has been removed,
remove the serial driver for it as well.  It's really only been a quirk
for an almost 8250 compatible UART anyway.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/tty/serial/8250/8250.c  | 70 +----------------------------------------
 drivers/tty/serial/8250/Kconfig |  9 ------
 include/linux/serial_core.h     |  1 -
 3 files changed, 1 insertion(+), 79 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 3ba4234..33711f5 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -239,13 +239,6 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_UUE | UART_CAP_RTOIE,
 	},
-	[PORT_RM9000] = {
-		.name		= "RM9000",
-		.fifo_size	= 16,
-		.tx_loadsz	= 16,
-		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-		.flags		= UART_CAP_FIFO,
-	},
 	[PORT_OCTEON] = {
 		.name		= "OCTEON",
 		.fifo_size	= 64,
@@ -354,56 +347,6 @@ static void au_serial_dl_write(struct uart_8250_port *up, int value)
 
 #endif
 
-#ifdef CONFIG_SERIAL_8250_RM9K
-
-static const u8
-	regmap_in[8] = {
-		[UART_RX]	= 0x00,
-		[UART_IER]	= 0x0c,
-		[UART_IIR]	= 0x14,
-		[UART_LCR]	= 0x1c,
-		[UART_MCR]	= 0x20,
-		[UART_LSR]	= 0x24,
-		[UART_MSR]	= 0x28,
-		[UART_SCR]	= 0x2c
-	},
-	regmap_out[8] = {
-		[UART_TX] 	= 0x04,
-		[UART_IER]	= 0x0c,
-		[UART_FCR]	= 0x18,
-		[UART_LCR]	= 0x1c,
-		[UART_MCR]	= 0x20,
-		[UART_LSR]	= 0x24,
-		[UART_MSR]	= 0x28,
-		[UART_SCR]	= 0x2c
-	};
-
-static unsigned int rm9k_serial_in(struct uart_port *p, int offset)
-{
-	offset = regmap_in[offset] << p->regshift;
-	return readl(p->membase + offset);
-}
-
-static void rm9k_serial_out(struct uart_port *p, int offset, int value)
-{
-	offset = regmap_out[offset] << p->regshift;
-	writel(value, p->membase + offset);
-}
-
-static int rm9k_serial_dl_read(struct uart_8250_port *up)
-{
-	return ((__raw_readl(up->port.membase + 0x10) << 8) |
-		(__raw_readl(up->port.membase + 0x08) & 0xff)) & 0xffff;
-}
-
-static void rm9k_serial_dl_write(struct uart_8250_port *up, int value)
-{
-	__raw_writel(value, up->port.membase + 0x08);
-	__raw_writel(value >> 8, up->port.membase + 0x10);
-}
-
-#endif
-
 static unsigned int hub6_serial_in(struct uart_port *p, int offset)
 {
 	offset = offset << p->regshift;
@@ -480,15 +423,6 @@ static void set_io_from_upio(struct uart_port *p)
 		p->serial_out = mem32_serial_out;
 		break;
 
-#ifdef CONFIG_SERIAL_8250_RM9K
-	case UPIO_RM9000:
-		p->serial_in = rm9k_serial_in;
-		p->serial_out = rm9k_serial_out;
-		up->dl_read = rm9k_serial_dl_read;
-		up->dl_write = rm9k_serial_dl_write;
-		break;
-#endif
-
 #ifdef CONFIG_MIPS_ALCHEMY
 	case UPIO_AU:
 		p->serial_in = au_serial_in;
@@ -1294,9 +1228,7 @@ static void serial8250_start_tx(struct uart_port *port)
 			unsigned char lsr;
 			lsr = serial_in(up, UART_LSR);
 			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
-			if ((port->type == PORT_RM9000) ?
-				(lsr & UART_LSR_THRE) :
-				(lsr & UART_LSR_TEMT))
+			if (lsr & UART_LSR_TEMT)
 				serial8250_tx_chars(up);
 		}
 	}
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f3d283f..700fe12 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -249,15 +249,6 @@ config SERIAL_8250_ACORN
 	  system, say Y to this option.  The driver can handle 1, 2, or 3 port
 	  cards.  If unsure, say N.
 
-config SERIAL_8250_RM9K
-	bool "Support for MIPS RM9xxx integrated serial port"
-	depends on SERIAL_8250 != n && SERIAL_RM9000
-	select SERIAL_8250_SHARE_IRQ
-	help
-	  Selecting this option will add support for the integrated serial
-	  port hardware found on MIPS RM9122 and similar processors.
-	  If unsure, say N.
-
 config SERIAL_8250_FSL
 	bool
 	depends on SERIAL_8250_CONSOLE && PPC_UDBG_16550
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3c43022..3ba8e91 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -134,7 +134,6 @@ struct uart_port {
 #define UPIO_MEM32		(3)
 #define UPIO_AU			(4)			/* Au1x00 type IO */
 #define UPIO_TSI		(5)			/* Tsi108/109 type IO */
-#define UPIO_RM9000		(6)			/* RM9000 type IO */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
