From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH v3] 8250_lpss: check null return when calling pci_ioremap_bar
Date: Fri, 26 Jul 2019 14:53:43 -0500
Message-ID: <20190726195345.30294-1-navid.emamdoost@gmail.com>
References: <20190726115746.GT9224@smile.fi.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726115746.GT9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andriy.shevchenko@linux.intel.com
Cc: emamd001@umn.edu, kjlu@umn.edu, b.zolnierkie@samsung.com, gregkh@linuxfoundation.org, smccaman@umn.edu, secalert@redhat.com, Navid Emamdoost <navid.emamdoost@gmail.com>, Jiri Slaby <jslaby@suse.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_ioremap_bar may return null. This is eventually de-referenced at
drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check
is needed to prevent null de-reference. I am adding the check and in case
 of failure. Thanks to Andy Shevchenko for the hint on the necessity of
pci_iounmap when exiting.
Update: also covered the dw_dma_probe() failure.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..19b356119ef6 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -169,15 +169,20 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	struct pci_dev *pdev = to_pci_dev(port->dev);
 	int ret;
 
+	chip->pdata = &qrk_serial_dma_pdata;
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
-	chip->pdata = &qrk_serial_dma_pdata;
+	if (!chip->regs)
+		return;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
-	if (ret)
+	if (ret) {
+		dw_dma_remove(chip);
+		pci_iounmap(to_pci_dev(chip->dev), chip->regs);
 		return;
+	}
 
 	pci_try_set_mwi(pdev);
 
@@ -195,11 +200,15 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
 {
+	struct dw_dma_chip *chip = &lpss->dma_chip;
 	struct dw_dma_slave *param = &lpss->dma_param;
 
 	if (!param->dma_dev)
 		return;
-	dw_dma_remove(&lpss->dma_chip);
+
+	dw_dma_remove(chip);
+
+	pci_iounmap(to_pci_dev(chip->dev), chip->regs);
 }
 #else	/* CONFIG_SERIAL_8250_DMA */
 static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port) {}
-- 
2.17.1
