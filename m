From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 12/12] serial: 8250_lpss: enable DMA on Intel Quark UART
Date: Thu,  7 Apr 2016 23:37:13 +0300
Message-ID: <1460061433-63750-13-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

DMA on Intel Quark SoC is a part of UART IP block. Enable it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 60 +++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 1b36d32..bc55738 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -15,7 +15,7 @@
 #include <linux/rational.h>
 
 #include <linux/dmaengine.h>
-#include <linux/platform_data/dma-dw.h>
+#include <linux/dma/dw.h>
 
 #include "8250.h"
 
@@ -47,6 +47,7 @@ struct lpss8250_board {
 	unsigned long freq;
 	unsigned int base_baud;
 	int (*setup)(struct lpss8250 *, struct uart_port *p);
+	void (*exit)(struct lpss8250 *);
 };
 
 struct lpss8250 {
@@ -55,6 +56,7 @@ struct lpss8250 {
 
 	/* DMA parameters */
 	struct uart_8250_dma dma;
+	struct dw_dma_chip dma_chip;
 	struct dw_dma_slave dma_param;
 	u8 dma_maxburst;
 };
@@ -141,17 +143,60 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
+	.nr_channels = 2,
+	.is_private = true,
+	.is_nollp = true,
+	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
+	.chan_priority = CHAN_PRIORITY_ASCENDING,
+	.block_size = 4095,
+	.nr_masters = 1,
+	.data_width = 4,
+};
+
 static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
+	struct uart_8250_dma *dma = &lpss->dma;
+	struct dw_dma_chip *chip = &lpss->dma_chip;
+	struct dw_dma_slave *param = &lpss->dma_param;
 	struct pci_dev *pdev = to_pci_dev(port->dev);
+	int ret;
 
 	pci_enable_msi(pdev);
 
 	port->irq = pdev->irq;
 
+	chip->dev = &pdev->dev;
+	chip->irq = pdev->irq;
+	chip->regs = pci_ioremap_bar(pdev, 1);
+	chip->pdata = &qrk_serial_dma_pdata;
+
+	/* Falling back to PIO mode if DMA probing fails */
+	ret = dw_dma_probe(chip);
+	if (ret)
+		return 0;
+
+	/* Special DMA address for UART */
+	dma->dma_addr = 0xfffff000;
+
+	param->dma_dev = &pdev->dev;
+	param->src_id = 0;
+	param->dst_id = 1;
+	param->polarity = true;
+
+	lpss->dma_maxburst = 8;
 	return 0;
 }
 
+static void qrk_serial_exit(struct lpss8250 *lpss)
+{
+	struct dw_dma_slave *param = &lpss->dma_param;
+
+	if (!param->dma_dev)
+		return;
+	dw_dma_remove(&lpss->dma_chip);
+}
+
 /*****************************************************************************/
 
 static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
@@ -243,22 +288,30 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = lpss8250_dma_setup(lpss, &uart);
 	if (ret)
-		return ret;
+		goto err_exit;
 
 	ret = serial8250_register_8250_port(&uart);
 	if (ret < 0)
-		return ret;
+		goto err_exit;
 
 	lpss->line = ret;
 
 	pci_set_drvdata(pdev, lpss);
 	return 0;
+
+err_exit:
+	if (lpss->board->exit)
+		lpss->board->exit(lpss);
+	return ret;
 }
 
 static void lpss8250_remove(struct pci_dev *pdev)
 {
 	struct lpss8250 *lpss = pci_get_drvdata(pdev);
 
+	if (lpss->board->exit)
+		lpss->board->exit(lpss);
+
 	serial8250_unregister_port(lpss->line);
 }
 
@@ -272,6 +325,7 @@ static const struct lpss8250_board qrk_board = {
 	.freq = 44236800,
 	.base_baud = 2764800,
 	.setup = qrk_serial_setup,
+	.exit = qrk_serial_exit,
 };
 
 #define LPSS_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
-- 
2.8.0.rc3
