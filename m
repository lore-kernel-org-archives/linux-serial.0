From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 4/7] serial: core: Add big-endian iotype
Date: Mon, 24 Nov 2014 15:36:19 -0800
Message-ID: <1416872182-6440-5-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47038 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaKXXge (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 18:36:34 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Since most drivers interpret UPIO_MEM32 to mean "little-endian" and use
readl/writel to access the registers, add a parallel UPIO_MEM32BE to
request the use of big-endian MMIO accessors (ioread32be/iowrite32be).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/serial_core.c |  2 ++
 include/linux/serial_core.h      | 13 +++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index eaeb9a0..ecc7d6c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2092,6 +2092,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 		break;
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 	case UPIO_TSI:
 		snprintf(address, sizeof(address),
@@ -2736,6 +2737,7 @@ int uart_match_port(struct uart_port *port1, struct uart_port *port2)
 		       (port1->hub6   == port2->hub6);
 	case UPIO_MEM:
 	case UPIO_MEM32:
+	case UPIO_MEM32BE:
 	case UPIO_AU:
 	case UPIO_TSI:
 		return (port1->mapbase == port2->mapbase);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 21c2e05..d2d5bf6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -140,12 +140,13 @@ struct uart_port {
 	unsigned char		iotype;			/* io access style */
 	unsigned char		unused1;
 
-#define UPIO_PORT		(0)
-#define UPIO_HUB6		(1)
-#define UPIO_MEM		(2)
-#define UPIO_MEM32		(3)
-#define UPIO_AU			(4)			/* Au1x00 and RT288x type IO */
-#define UPIO_TSI		(5)			/* Tsi108/109 type IO */
+#define UPIO_PORT		(0)			/* 8b I/O port access */
+#define UPIO_HUB6		(1)			/* Hub6 ISA card */
+#define UPIO_MEM		(2)			/* 8b MMIO access */
+#define UPIO_MEM32		(3)			/* 32b little endian */
+#define UPIO_MEM32BE		(4)			/* 32b big endian */
+#define UPIO_AU			(5)			/* Au1x00 and RT288x type IO */
+#define UPIO_TSI		(6)			/* Tsi108/109 type IO */
 
 	unsigned int		read_status_mask;	/* driver specific */
 	unsigned int		ignore_status_mask;	/* driver specific */
-- 
2.1.0

