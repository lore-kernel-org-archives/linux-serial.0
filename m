From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] pch_uart: don't hardcode PCI slot to get DMA device
Date: Wed, 30 Jul 2014 18:59:52 +0300
Message-ID: <1406735992-7477-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:47903 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405AbaG3QAj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Jul 2014 12:00:39 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The DMA is a function 0 of the multifunction device where SPI host is attached.
Thus, we may avoid to hardcode PCI slot number.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pch_uart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 2f06e5a..ea4ffc2 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -736,9 +736,10 @@ static void pch_request_dma(struct uart_port *port)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	dma_dev = pci_get_bus_and_slot(priv->pdev->bus->number,
-				       PCI_DEVFN(0xa, 0)); /* Get DMA's dev
-								information */
+	/* Get DMA's dev information */
+	dma_dev = pci_get_slot(priv->pdev->bus,
+			PCI_DEVFN(PCI_SLOT(priv->pdev->devfn), 0));
+
 	/* Set Tx DMA */
 	param = &priv->param_tx;
 	param->dma_dev = &dma_dev->dev;
-- 
2.0.1

