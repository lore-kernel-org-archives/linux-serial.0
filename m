From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH v3] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Sun, 24 Mar 2019 11:09:00 -0500
Message-ID: <20190324160901.23001-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_ioremap_bar could fail. The patch returns in case of failure to
acquire IOMEM. It also releases the acquired resource in the exit path.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Failed to release resource in exit path and incorrect code in non
DMA case, suggested by Andy Shevchenko
v1: Missed return by default in CONFIG_SERIAL_8250_DMA, suggested by
Jiri Slaby
---
 drivers/tty/serial/8250/8250_lpss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..7889b2552013 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -170,9 +170,11 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	int ret;
 
 	chip->dev = &pdev->dev;
+	chip->pdata = &qrk_serial_dma_pdata;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
-	chip->pdata = &qrk_serial_dma_pdata;
+	if (!chip->regs)
+		return;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
@@ -199,6 +201,7 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 
 	if (!param->dma_dev)
 		return;
+	pci_iounmap(param->dma_dev, &lpss->dma_chip->regs);
 	dw_dma_remove(&lpss->dma_chip);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
-- 
2.17.1
