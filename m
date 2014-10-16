From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 1/2] serial: of: add a PORT_RT2880 definition
Date: Thu, 16 Oct 2014 21:48:21 +0200
Message-ID: <1413488902-51635-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:51561
	"EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752597AbaJPTsa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 15:48:30 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

The Ralink RT2880 SoC and its successors have an internal 8250 core. This core
needs the same quirks applied as the AMD AU1xxx uart. In addition to these
quirks, the ports memory region is only 0x100 unlike the AU1xxx which has a
size of 0x1000.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/8250/8250_core.c |    5 ++++-
 drivers/tty/serial/of_serial.c      |   10 +++++++++-
 include/uapi/linux/serial_core.h    |    3 ++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 1d42dba..f487b13 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2502,8 +2502,11 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
-	if (pt->port.iotype == UPIO_AU)
+	if (pt->port.iotype == UPIO_AU) {
+		if (pt->port.type == PORT_RT2880)
+			return 0x100;
 		return 0x1000;
+	}
 	if (is_omap1_8250(pt))
 		return 0x16 << pt->port.regshift;
 
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 68d4455..99423eb 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -129,8 +129,15 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	port->dev = &ofdev->dev;
 
-	if (type == PORT_TEGRA)
+	switch (type) {
+	case PORT_TEGRA:
 		port->handle_break = tegra_serial_handle_break;
+		break;
+
+	case PORT_RT2880:
+		port->iotype = UPIO_AU;
+		break;
+	}
 
 	return 0;
 out:
@@ -256,6 +263,7 @@ static struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "ns16850",  .data = (void *)PORT_16850, },
 	{ .compatible = "nvidia,tegra20-uart", .data = (void *)PORT_TEGRA, },
 	{ .compatible = "nxp,lpc3220-uart", .data = (void *)PORT_LPC3220, },
+	{ .compatible = "ralink,rt2880-uart", .data = (void *)PORT_RT2880, },
 	{ .compatible = "altr,16550-FIFO32",
 		.data = (void *)PORT_ALTR_16550_F32, },
 	{ .compatible = "altr,16550-FIFO64",
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 5820269..8591d26 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -54,7 +54,8 @@
 #define PORT_ALTR_16550_F32 26	/* Altera 16550 UART with 32 FIFOs */
 #define PORT_ALTR_16550_F64 27	/* Altera 16550 UART with 64 FIFOs */
 #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
-#define PORT_MAX_8250	28	/* max port ID */
+#define PORT_RT2880	29	/* Ralink RT2880 internal UART */
+#define PORT_MAX_8250	29	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
-- 
1.7.10.4

