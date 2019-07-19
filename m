From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] 8250_lpss: check null return when calling pci_ioremap_bar
Date: Thu, 18 Jul 2019 21:54:42 -0500
Message-ID: <20190719025443.2368-1-navid.emamdoost@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vkoul@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

pci_ioremap_bar may return null. This is eventually de-referenced at 
drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168. A null check is
 needed to prevent null de-reference. I am adding the check and in case of
 failure returning -ENOMEM (I am not sure this is the best errno, you may 
consider it as a placeholder), and subsequently changing the caller’s 
return type, and propagating the error.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 53ca9ba6ab4b..5954b2e09b76 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -161,7 +161,7 @@ static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.multi_block = {0},
 };
 
-static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
+static int qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct uart_8250_dma *dma = &lpss->dma;
 	struct dw_dma_chip *chip = &lpss->dma_chip;
@@ -172,12 +172,14 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	chip->dev = &pdev->dev;
 	chip->irq = pci_irq_vector(pdev, 0);
 	chip->regs = pci_ioremap_bar(pdev, 1);
+	if (!chip->regs)
+		return -ENOMEM;
 	chip->pdata = &qrk_serial_dma_pdata;
 
 	/* Falling back to PIO mode if DMA probing fails */
 	ret = dw_dma_probe(chip);
 	if (ret)
-		return;
+		return 0;
 
 	pci_try_set_mwi(pdev);
 
@@ -191,6 +193,7 @@ static void qrk_serial_setup_dma(struct lpss8250 *lpss, struct uart_port *port)
 	param->hs_polarity = true;
 
 	lpss->dma_maxburst = 8;
+	return 0;
 }
 
 static void qrk_serial_exit_dma(struct lpss8250 *lpss)
@@ -219,7 +222,9 @@ static int qrk_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 
 	port->irq = pci_irq_vector(pdev, 0);
 
-	qrk_serial_setup_dma(lpss, port);
+	ret = qrk_serial_setup_dma(lpss, port);
+	if (ret < 0)
+		return ret;
 	return 0;
 }
 
-- 
2.17.1
