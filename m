From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Thu, 14 Mar 2019 23:56:16 -0500
Message-ID: <20190315045617.7616-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_ioremap_bar could fail. The fix captures the failure and
pass an error code upstream. This can avoid potential NULL
pointer dereferences in the future.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/tty/serial/8250/8250_lpss.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 98dbc796353f..e95332d8b35e 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -162,7 +162,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.multi_block = {0},
 };
 
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct uart_8250_dma *dma = &lpss->dma;
 	struct dw_dma_chip *chip = &lpss->dma_chip;
@@ -173,12 +173,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
+	if (!chip->regs)
+		return -EIO;
 	chip->pdata = &qrk_serial_dma_pdata;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
 	if (ret)
-		return;
+		return ret;
 
 	pci_try_set_mwi(pdev);
 
@@ -192,6 +194,8 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	param->hs_polarity = true;
 
 	lpss->dma_maxburst = 8;
+
+	return 0;
 }
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
@@ -203,7 +207,7 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 	dw_dma_remove(&lpss->dma_chip);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
 static void qrk_serial_exit_dma(struct lpss8250 *lpss) {}
 #endif	/* !CONFIG_SERIAL_8250_DMA */
 
@@ -220,8 +224,7 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 	port->irq = pci_irq_vector(pdev, 0);
 
-	qrk_serial_setup_dma(lpss, port);
-	return 0;
+	return qrk_serial_setup_dma(lpss, port);
 }
 
 static void qrk_serial_exit(struct lpss8250 *lpss)
-- 
2.17.1
