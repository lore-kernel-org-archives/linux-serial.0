From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] tty: serial: altera_uart: Add CONSOLE_POLL support
Date: Wed,  8 Feb 2012 14:36:09 +0100
Message-ID: <1328708169-25134-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:35029 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab2BHNph (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Feb 2012 08:45:37 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

This allows altera_uart to be used for KGDB debugging over serial line.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/Makefile      |    2 +-
 drivers/tty/serial/altera_uart.c |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index fee0690..d469771 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -81,12 +81,12 @@ obj-$(CONFIG_SERIAL_OF_PLATFORM) += of_serial.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) += nwpserial.o
 obj-$(CONFIG_SERIAL_KS8695) += serial_ks8695.o
 obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
+obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
 obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
 obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
 obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
 obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
-obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
 obj-$(CONFIG_SERIAL_VT8500) += vt8500_serial.o
 obj-$(CONFIG_SERIAL_MRST_MAX3110)	+= mrst_max3110.o
 obj-$(CONFIG_SERIAL_MFD_HSU)	+= mfd.o
diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 3a9cffa..fefaa4c 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -377,6 +377,26 @@ static int altera_uart_verify_port(struct uart_port *port,
 	return 0;
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+static int altera_uart_poll_get_char(struct uart_port *port)
+{
+	while (!(altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
+		 ALTERA_UART_STATUS_RRDY_MSK))
+		cpu_relax();
+
+	return altera_uart_readl(port, ALTERA_UART_RXDATA_REG);
+}
+
+static void altera_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	while (!(altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
+		 ALTERA_UART_STATUS_TRDY_MSK))
+		cpu_relax();
+
+	altera_uart_writel(port, c, ALTERA_UART_TXDATA_REG);
+}
+#endif
+
 /*
  *	Define the basic serial functions we support.
  */
@@ -397,6 +417,10 @@ static struct uart_ops altera_uart_ops = {
 	.release_port	= altera_uart_release_port,
 	.config_port	= altera_uart_config_port,
 	.verify_port	= altera_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char	= altera_uart_poll_get_char,
+	.poll_put_char	= altera_uart_poll_put_char,
+#endif
 };
 
 static struct altera_uart altera_uart_ports[CONFIG_SERIAL_ALTERA_UART_MAXPORTS];
-- 
1.7.5.4

