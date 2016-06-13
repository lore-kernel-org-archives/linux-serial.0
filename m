From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 09/11] serial: 8250_lpss: move Quark code from PCI driver
Date: Mon, 13 Jun 2016 16:42:38 +0300
Message-ID: <1465825360-97711-10-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1465825360-97711-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465825360-97711-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Intel Quark has DesignWare UART. Move the code from 8250_pci to 8250_lpss.

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 11 +++++++++++
 drivers/tty/serial/8250/8250_pci.c  | 15 +--------------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 77cf7e3..3beb3aa 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -25,6 +25,8 @@
 #define PCI_DEVICE_ID_INTEL_BSW_UART1	0x228a
 #define PCI_DEVICE_ID_INTEL_BSW_UART2	0x228c
 
+#define PCI_DEVICE_ID_INTEL_QRK_UARTx	0x0936
+
 #define PCI_DEVICE_ID_INTEL_BDW_UART1	0x9ce3
 #define PCI_DEVICE_ID_INTEL_BDW_UART2	0x9ce4
 
@@ -165,6 +167,9 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
 	struct dw_dma_slave *rx_param, *tx_param;
 	struct device *dev = port->port.dev;
 
+	if (!lpss->dma_param.dma_dev)
+		return 0;
+
 	rx_param = devm_kzalloc(dev, sizeof(*rx_param), GFP_KERNEL);
 	if (!rx_param)
 		return -ENOMEM;
@@ -252,6 +257,11 @@ static const struct lpss8250_board byt_board = {
 	.setup = byt_serial_setup,
 };
 
+static const struct lpss8250_board qrk_board = {
+	.freq = 44236800,
+	.base_baud = 2764800,
+};
+
 #define LPSS_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
 
 static const struct pci_device_id pci_ids[] = {
@@ -259,6 +269,7 @@ static const struct pci_device_id pci_ids[] = {
 	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BYT_UART2, byt_board),
 	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART1, byt_board),
 	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART2, byt_board),
+	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_QRK_UARTx, qrk_board),
 	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART1, byt_board),
 	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART2, byt_board),
 	{ },
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index bb4df5d..b94b1ee 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1765,7 +1765,6 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE	0x0022
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
-#define PCI_DEVICE_ID_INTEL_QRK_UART	0x0936
 
 #define PCI_VENDOR_ID_SUNIX		0x1fd4
 #define PCI_DEVICE_ID_SUNIX_1999	0x1999
@@ -2736,7 +2735,6 @@ enum pci_board_num_t {
 	pbn_ADDIDATA_PCIe_4_3906250,
 	pbn_ADDIDATA_PCIe_8_3906250,
 	pbn_ce4100_1_115200,
-	pbn_qrk,
 	pbn_omegapci,
 	pbn_NETMOS9900_2s_115200,
 	pbn_brcm_trumanage,
@@ -3512,12 +3510,6 @@ static struct pciserial_board pci_boards[] = {
 		.base_baud	= 921600,
 		.reg_shift      = 2,
 	},
-	[pbn_qrk] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 1,
-		.base_baud	= 2764800,
-		.reg_shift	= 2,
-	},
 	[pbn_omegapci] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 8,
@@ -3634,6 +3626,7 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(INTEL, 0x0f0c), },
 	{ PCI_VDEVICE(INTEL, 0x228a), },
 	{ PCI_VDEVICE(INTEL, 0x228c), },
+	{ PCI_VDEVICE(INTEL, 0x0936), },
 	{ PCI_VDEVICE(INTEL, 0x9ce3), },
 	{ PCI_VDEVICE(INTEL, 0x9ce4), },
 };
@@ -5303,12 +5296,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 		pbn_ce4100_1_115200 },
 
 	/*
-	 * Intel Quark x1000
-	 */
-	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_QRK_UART,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_qrk },
-	/*
 	 * Cronyx Omega PCI
 	 */
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA,
-- 
2.8.1
