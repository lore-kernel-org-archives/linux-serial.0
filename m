From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/5] serial: 8250_mid: use proper bar for DNV platform
Date: Mon,  4 Apr 2016 17:35:09 +0300
Message-ID: <1459780513-140200-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1459780513-140200-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1459780513-140200-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Unlike Intel Medfield and Tangier platforms DNV uses PCI BAR0 for IO compatible
resources and BAR1 for MMIO. We need latter in a way to support DMA. Introduce
an additional field in the internal structure and pass PCI BAR based on device
ID.

Reported-by: "Lai, Poey Seng" <poey.seng.lai@intel.com>
Fixes: 6ede6dcd87aa ("serial: 8250_mid: add support for DMA engine handling from UART MMIO")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 88531a3..7aa6ef8 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include <linux/dma/hsu.h>
+#include <linux/8250_pci.h>
 
 #include "8250.h"
 
@@ -31,6 +32,7 @@
 struct mid8250;
 
 struct mid8250_board {
+	unsigned int flags;
 	unsigned long freq;
 	unsigned int base_baud;
 	int (*setup)(struct mid8250 *, struct uart_port *p);
@@ -106,12 +108,13 @@ static int dnv_setup(struct mid8250 *mid, struct uart_port *p)
 {
 	struct hsu_dma_chip *chip = &mid->dma_chip;
 	struct pci_dev *pdev = to_pci_dev(p->dev);
+	unsigned int bar = FL_GET_BASE(mid->board->flags);
 	int ret;
 
 	chip->dev = &pdev->dev;
 	chip->irq = pdev->irq;
 	chip->regs = p->membase;
-	chip->length = pci_resource_len(pdev, 0);
+	chip->length = pci_resource_len(pdev, bar);
 	chip->offset = DNV_DMA_CHAN_OFFSET;
 
 	/* Falling back to PIO mode if DMA probing fails */
@@ -217,6 +220,7 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port uart;
 	struct mid8250 *mid;
+	unsigned int bar;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -230,6 +234,7 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	mid->board = (struct mid8250_board *)id->driver_data;
+	bar = FL_GET_BASE(mid->board->flags);
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
@@ -242,8 +247,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	uart.port.set_termios = mid8250_set_termios;
 
-	uart.port.mapbase = pci_resource_start(pdev, 0);
-	uart.port.membase = pcim_iomap(pdev, 0, 0);
+	uart.port.mapbase = pci_resource_start(pdev, bar);
+	uart.port.membase = pcim_iomap(pdev, bar, 0);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
@@ -282,18 +287,21 @@ static void mid8250_remove(struct pci_dev *pdev)
 }
 
 static const struct mid8250_board pnw_board = {
+	.flags = FL_BASE0,
 	.freq = 50000000,
 	.base_baud = 115200,
 	.setup = pnw_setup,
 };
 
 static const struct mid8250_board tng_board = {
+	.flags = FL_BASE0,
 	.freq = 38400000,
 	.base_baud = 1843200,
 	.setup = tng_setup,
 };
 
 static const struct mid8250_board dnv_board = {
+	.flags = FL_BASE1,
 	.freq = 133333333,
 	.base_baud = 115200,
 	.setup = dnv_setup,
-- 
2.8.0.rc3
