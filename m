From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/76] serial: pch_uart: support new device ML7213
Date: Wed, 16 Mar 2011 14:11:40 -0700
Message-ID: <1300309966-5745-10-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:60920 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675Ab1CPVND (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:03 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Support ML7213 device of OKI SEMICONDUCTOR.
ML7213 is companion chip of Intel Atom E6xx series for IVI(In-Vehicle Infotainment).
ML7213 is completely compatible for Intel EG20T PCH.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/Kconfig    |    5 +++++
 drivers/tty/serial/pch_uart.c |   27 +++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2b83346..86e2c99 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1596,4 +1596,9 @@ config SERIAL_PCH_UART
 	  This driver is for PCH(Platform controller Hub) UART of Intel EG20T
 	  which is an IOH(Input/Output Hub) for x86 embedded processor.
 	  Enabling PCH_DMA, this PCH UART works as DMA mode.
+
+	  This driver also can be used for OKI SEMICONDUCTOR ML7213 IOH(Input/
+	  Output Hub) which is for IVI(In-Vehicle Infotainment) use.
+	  ML7213 is companion chip for Intel Atom E6xx series.
+	  ML7213 is completely compatible for Intel EG20T PCH.
 endmenu
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 70a6145..3b2fb93 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -40,10 +40,11 @@ enum {
 
 #define PCH_UART_DRIVER_DEVICE "ttyPCH"
 
-#define PCH_UART_NR_GE_256FIFO		1
-#define PCH_UART_NR_GE_64FIFO		3
-#define PCH_UART_NR_GE	(PCH_UART_NR_GE_256FIFO+PCH_UART_NR_GE_64FIFO)
-#define PCH_UART_NR	PCH_UART_NR_GE
+/* Set the max number of UART port
+ * Intel EG20T PCH: 4 port
+ * OKI SEMICONDUCTOR ML7213 IOH: 3 port
+*/
+#define PCH_UART_NR	4
 
 #define PCH_UART_HANDLED_RX_INT	(1<<((PCH_UART_HANDLED_RX_INT_SHIFT)<<1))
 #define PCH_UART_HANDLED_TX_INT	(1<<((PCH_UART_HANDLED_TX_INT_SHIFT)<<1))
@@ -192,6 +193,8 @@ enum {
 #define PCH_UART_HAL_LOOP		(PCH_UART_MCR_LOOP)
 #define PCH_UART_HAL_AFE		(PCH_UART_MCR_AFE)
 
+#define PCI_VENDOR_ID_ROHM		0x10DB
+
 struct pch_uart_buffer {
 	unsigned char *buf;
 	int size;
@@ -1249,7 +1252,7 @@ static struct uart_driver pch_uart_driver = {
 };
 
 static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
-						int port_type)
+					     const struct pci_device_id *id)
 {
 	struct eg20t_port *priv;
 	int ret;
@@ -1258,6 +1261,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	unsigned char *rxbuf;
 	int fifosize, base_baud;
 	static int num;
+	int port_type = id->driver_data;
 
 	priv = kzalloc(sizeof(struct eg20t_port), GFP_KERNEL);
 	if (priv == NULL)
@@ -1269,11 +1273,11 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 
 	switch (port_type) {
 	case PORT_UNKNOWN:
-		fifosize = 256; /* UART0 */
+		fifosize = 256; /* EG20T/ML7213: UART0 */
 		base_baud = 1843200; /* 1.8432MHz */
 		break;
 	case PORT_8250:
-		fifosize = 64; /* UART1~3 */
+		fifosize = 64; /* EG20T:UART1~3  ML7213: UART1~2*/
 		base_baud = 1843200; /* 1.8432MHz */
 		break;
 	default:
@@ -1307,6 +1311,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, priv);
 	pch_uart_hal_request(pdev, fifosize, base_baud);
+
 	ret = uart_add_one_port(&pch_uart_driver, &priv->port);
 	if (ret < 0)
 		goto init_port_hal_free;
@@ -1384,6 +1389,12 @@ static DEFINE_PCI_DEVICE_TABLE(pch_uart_pci_id) = {
 	 .driver_data = PCH_UART_2LINE},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x8814),
 	 .driver_data = PCH_UART_2LINE},
+	{PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x8027),
+	 .driver_data = PCH_UART_8LINE},
+	{PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x8028),
+	 .driver_data = PCH_UART_2LINE},
+	{PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x8029),
+	 .driver_data = PCH_UART_2LINE},
 	{0,},
 };
 
@@ -1397,7 +1408,7 @@ static int __devinit pch_uart_pci_probe(struct pci_dev *pdev,
 	if (ret < 0)
 		goto probe_error;
 
-	priv = pch_uart_init_port(pdev, id->driver_data);
+	priv = pch_uart_init_port(pdev, id);
 	if (!priv) {
 		ret = -EBUSY;
 		goto probe_disable_device;
-- 
1.7.4.1

