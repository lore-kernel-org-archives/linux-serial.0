From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 76/76] pch_uart: reference clock on CM-iTC
Date: Wed, 16 Mar 2011 14:12:46 -0700
Message-ID: <1300309966-5745-76-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32990 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032Ab1CPVPn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:43 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denis Turischev <denis@compulab.co.il>, Greg Kroah-Hartman <gregkh@suse.de>

From: Denis Turischev <denis@compulab.co.il>

Default clock source for UARTs on Topcliff is external UART_CLK.
On CM-iTC USB_48MHz is used instead. After VCO2PLL and DIV
manipulations UARTs will receive 192 MHz.
Clock manipulations on Topcliff are controlled in pch_phub.c

v2: redone against the linux-next tree
v3: redone against linux/kernel/git/next/linux-next.git snapshot

Signed-off-by: Denis Turischev <denis@compulab.co.il>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/misc/pch_phub.c       |   16 ++++++++++++++++
 drivers/tty/serial/pch_uart.c |    9 +++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 98bffc4..5dd0b92 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/if_ether.h>
 #include <linux/ctype.h>
+#include <linux/dmi.h>
 
 #define PHUB_STATUS 0x00		/* Status Register offset */
 #define PHUB_CONTROL 0x04		/* Control Register offset */
@@ -46,6 +47,13 @@
 #define PCH_MINOR_NOS 1
 #define CLKCFG_CAN_50MHZ 0x12000000
 #define CLKCFG_CANCLK_MASK 0xFF000000
+#define CLKCFG_UART_MASK			0xFFFFFF
+
+/* CM-iTC */
+#define CLKCFG_UART_48MHZ			(1 << 16)
+#define CLKCFG_BAUDDIV				(2 << 20)
+#define CLKCFG_PLL2VCO				(8 << 9)
+#define CLKCFG_UARTCLKSEL			(1 << 18)
 
 /* Macros for ML7213 */
 #define PCI_VENDOR_ID_ROHM			0x10db
@@ -618,6 +626,14 @@ static int __devinit pch_phub_probe(struct pci_dev *pdev,
 					       CLKCFG_CAN_50MHZ,
 					       CLKCFG_CANCLK_MASK);
 
+		/* quirk for CM-iTC board */
+		if (strstr(dmi_get_system_info(DMI_BOARD_NAME), "CM-iTC"))
+			pch_phub_read_modify_write_reg(chip,
+						(unsigned int)CLKCFG_REG_OFFSET,
+						CLKCFG_UART_48MHZ | CLKCFG_BAUDDIV |
+						CLKCFG_PLL2VCO | CLKCFG_UARTCLKSEL,
+						CLKCFG_UART_MASK);
+
 		/* set the prefech value */
 		iowrite32(0x000affaa, chip->pch_phub_base_address + 0x14);
 		/* set the interrupt delay value */
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index a5ce9a5..a9ad7f3 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -21,6 +21,7 @@
 #include <linux/serial_core.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/dmi.h>
 
 #include <linux/dmaengine.h>
 #include <linux/pch_dma.h>
@@ -1404,14 +1405,18 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (!rxbuf)
 		goto init_port_free_txbuf;
 
+	base_baud = 1843200; /* 1.8432MHz */
+
+	/* quirk for CM-iTC board */
+	if (strstr(dmi_get_system_info(DMI_BOARD_NAME), "CM-iTC"))
+		base_baud = 192000000; /* 192.0MHz */
+
 	switch (port_type) {
 	case PORT_UNKNOWN:
 		fifosize = 256; /* EG20T/ML7213: UART0 */
-		base_baud = 1843200; /* 1.8432MHz */
 		break;
 	case PORT_8250:
 		fifosize = 64; /* EG20T:UART1~3  ML7213: UART1~2*/
-		base_baud = 1843200; /* 1.8432MHz */
 		break;
 	default:
 		dev_err(&pdev->dev, "Invalid Port Type(=%d)\n", port_type);
-- 
1.7.4.1

